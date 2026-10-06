import 'dart:typed_data';

import 'package:logbuch_server/src/auth/roles.dart';
import 'package:logbuch_server/src/common/today.dart';
import 'package:logbuch_server/src/common/validation.dart';
import 'package:logbuch_server/src/donations/receipt_pdf.dart';
import 'package:logbuch_server/src/donations/receipt_text.dart';
import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:logbuch_server/src/generated/serverpod.dart';

/// Serializes the numbering of receipts.
const _receiptNumberLock = 727002;

/// Donations and the yearly receipts for them.
class DonationEndpoint extends AppEndpoint {
  /// The donations made in [year], with their donors and receipts.
  Future<List<Donation>> getByYear(Session session, int year) async {
    return Donation.db.find(
      session,
      where: (t) => _inYear(t, year),
      orderByList: (t) => [t.date.asc(), t.id.asc()],
      include: Donation.include(
        contact: Contact.include(),
        receipt: DonationReceipt.include(),
      ),
    );
  }

  /// Records a donation that was not left over from a payment.
  Future<Donation> addDirect(Session session, Donation donation) async {
    requireAdmin(session);
    if (donation.amount <= 0) {
      throw ValidationException(reason: ValidationError.invalidAmount);
    }
    requireDateOnly(donation.date);
    return await Donation.db.insertRow(
      session,
      Donation(
        contactId: donation.contactId,
        amount: donation.amount,
        date: donation.date,
        source: DonationSource.direct,
      ),
    );
  }

  /// Removes a donation that was recorded with [addDirect], unless it is on
  /// a receipt. A donation from a payment is taken back in its booking.
  Future<void> delete(Session session, int id) async {
    requireAdmin(session);
    final donation = await Donation.db.findById(session, id);
    if (donation == null) return;
    if (donation.receiptId != null) {
      throw ValidationException(reason: ValidationError.alreadyReceipted);
    }
    if (donation.paymentId != null) {
      throw ValidationException(reason: ValidationError.inUse);
    }
    await Donation.db.deleteRow(session, donation);
  }

  /// The receipts that [createReceipts] would issue for [year]: one per
  /// donor with donations that are on no receipt yet.
  Future<List<ReceiptPreview>> previewReceipts(
    Session session,
    int year,
  ) async {
    final byDonor = await _withoutReceipt(session, year);
    return [
      for (final donations in byDonor)
        ReceiptPreview(
          contact: donations.first.contact!,
          donationCount: donations.length,
          total: _total(donations),
          addressComplete: hasFullAddress(donations.first.contact!),
        ),
    ];
  }

  /// Issues a receipt to every donor for their donations of [year] that are
  /// on no receipt yet, and returns the new receipts.
  ///
  /// A donor without a full address gets none until the address is there,
  /// as a receipt has to state it. From now on the donations of a receipt
  /// cannot change.
  Future<List<DonationReceipt>> createReceipts(
    Session session,
    int year,
  ) async {
    requireAdmin(session);
    final operator = await Operator.db.findFirstRow(session);
    if (operator == null || !isCompleteForReceipts(operator)) {
      throw ValidationException(reason: ValidationError.operatorIncomplete);
    }

    return session.db.transaction((transaction) async {
      await session.db.unsafeExecute(
        'SELECT pg_advisory_xact_lock($_receiptNumberLock)',
        transaction: transaction,
      );
      final issuedAt = await todayInGermany(session, transaction: transaction);
      final prefix = 'SB-$year-';
      final result = await session.db.unsafeQuery(
        'SELECT max(substring("number" from ${prefix.length + 1})::int) '
        'FROM donation_receipts WHERE "number" LIKE \'$prefix%\'',
        transaction: transaction,
      );
      var last = result.first.first as int? ?? 0;

      final receipts = <DonationReceipt>[];
      final byDonor = await _withoutReceipt(session, year, transaction);
      for (final donations in byDonor) {
        final donor = donations.first.contact!;
        if (!hasFullAddress(donor)) continue;

        final number = '$prefix${(++last).toString().padLeft(4, '0')}';
        final pdf = await buildReceiptPdf(
          operator: operator,
          donor: donor,
          number: number,
          year: year,
          issuedAt: issuedAt,
          donations: donations,
        );
        final receipt = await DonationReceipt.db.insertRow(
          session,
          DonationReceipt(
            contactId: donor.id!,
            year: year,
            number: number,
            total: _total(donations),
            issuedAt: issuedAt,
            pdf: ByteData.sublistView(pdf),
          ),
          transaction: transaction,
        );
        await Donation.db.update(
          session,
          [
            for (final donation in donations)
              donation.copyWith(receiptId: receipt.id),
          ],
          columns: (t) => [t.receiptId],
          transaction: transaction,
        );
        receipts.add(receipt.copyWith(contact: donor));
      }
      return receipts;
    });
  }

  /// The receipts issued for [year], without their documents.
  Future<List<DonationReceipt>> getReceipts(Session session, int year) async {
    return DonationReceipt.db.find(
      session,
      where: (t) => t.year.equals(year),
      orderBy: (t) => t.number,
      include: DonationReceipt.include(contact: Contact.include()),
    );
  }

  /// The document of a receipt as it was issued, a PDF.
  Future<ByteData> getReceiptPdf(Session session, int receiptId) async {
    final receipt = await DonationReceipt.db.findById(session, receiptId);
    final pdf = receipt?.pdf;
    if (pdf == null) {
      throw ValidationException(reason: ValidationError.notFound);
    }
    return pdf;
  }

  /// The donations of [year] that are on no receipt, grouped by donor. The
  /// donors are sorted by name and their donations by date.
  Future<List<List<Donation>>> _withoutReceipt(
    Session session,
    int year, [
    Transaction? transaction,
  ]) async {
    final donations = await Donation.db.find(
      session,
      where: (t) => _inYear(t, year) & t.receiptId.equals(null),
      orderByList: (t) => [
        t.contact.lastName.asc(),
        t.contact.firstName.asc(),
        t.contactId.asc(),
        t.date.asc(),
        t.id.asc(),
      ],
      include: Donation.include(contact: Contact.include()),
      transaction: transaction,
    );
    final byDonor = <int, List<Donation>>{};
    for (final donation in donations) {
      byDonor.putIfAbsent(donation.contactId, () => []).add(donation);
    }
    return byDonor.values.toList();
  }

  Expression _inYear(DonationTable t, int year) =>
      (t.date >= DateTime.utc(year)) & (t.date < DateTime.utc(year + 1));

  int _total(List<Donation> donations) =>
      donations.fold(0, (sum, donation) => sum + donation.amount);
}
