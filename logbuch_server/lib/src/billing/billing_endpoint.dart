import 'dart:typed_data';

import 'package:logbuch_server/src/auth/roles.dart';
import 'package:logbuch_server/src/billing/folio_distribution.dart';
import 'package:logbuch_server/src/billing/invoice_pdf.dart';
import 'package:logbuch_server/src/common/today.dart';
import 'package:logbuch_server/src/common/validation.dart';
import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:logbuch_server/src/generated/serverpod.dart';
import 'package:logbuch_server/src/pricing/pricing_data.dart';

/// The types of charges that are worked out from the booking. The others
/// are added by hand.
const _calculated = {ChargeType.lodging, ChargeType.meal, ChargeType.fee};

/// Serializes the numbering of invoices across all bookings.
const _invoiceNumberLock = 727001;

/// The folios of a booking: what each payer is charged, what they paid and
/// what they donated.
class BillingEndpoint extends AppEndpoint {
  /// The folios of the booking with their charges, their payments and the
  /// donations made with those.
  ///
  /// The charges of folios that are not invoiced yet are brought in line
  /// with the booking and the current rates first, so they always reflect
  /// its guests, rooms and billing mode. An invoiced folio stays as it was
  /// invoiced.
  Future<List<Folio>> getFolios(Session session, int bookingId) async {
    await session.db.transaction(
      (transaction) => _refresh(session, bookingId, transaction),
    );
    return Folio.db.find(
      session,
      where: (t) => t.bookingId.equals(bookingId),
      orderBy: (t) => t.id,
      include: Folio.include(
        payer: Contact.include(),
        charges: Charge.includeList(orderBy: (t) => t.id),
        payments: Payment.includeList(
          orderBy: (t) => t.id,
          include: Payment.include(donations: Donation.includeList()),
        ),
      ),
    );
  }

  /// Adds a charge by hand to a folio that is not invoiced yet: something
  /// extra, or a discount with a negative price.
  Future<Charge> addCharge(Session session, Charge charge) async {
    requireAdmin(session);
    final description = requireName(charge.description);
    final isDiscount = charge.type == ChargeType.discount;
    if (!isDiscount && charge.type != ChargeType.manual) {
      throw ValidationException(reason: ValidationError.invalidAmount);
    }
    if (charge.quantity <= 0 ||
        charge.unitPrice == 0 ||
        (charge.unitPrice < 0) != isDiscount) {
      throw ValidationException(reason: ValidationError.invalidAmount);
    }
    if (charge.taxRate < 0 || charge.taxRate > 10000) {
      throw ValidationException(reason: ValidationError.invalidTaxRate);
    }
    await _requireOpen(session, charge.folioId);
    return await Charge.db.insertRow(
      session,
      charge.copyWith(
        description: description,
        total: charge.quantity * charge.unitPrice,
      ),
    );
  }

  /// Removes a charge that was added by hand, while its folio is not
  /// invoiced yet.
  Future<void> deleteCharge(Session session, int id) async {
    requireAdmin(session);
    final charge = await Charge.db.findById(session, id);
    if (charge == null) return;
    if (_calculated.contains(charge.type)) {
      throw ValidationException(reason: ValidationError.inUse);
    }
    await _requireOpen(session, charge.folioId);
    await Charge.db.deleteRow(session, charge);
  }

  /// Turns the folio into an invoice: it gets the next invoice number of the
  /// year and its charges stay as they are from now on.
  ///
  /// Fails while a part of the booking cannot be priced, so that nothing is
  /// missing on an invoice.
  Future<Folio> invoice(Session session, int folioId) async {
    requireAdmin(session);
    return session.db.transaction((transaction) async {
      final known = await Folio.db.findById(
        session,
        folioId,
        transaction: transaction,
      );
      if (known == null) {
        throw ValidationException(reason: ValidationError.notFound);
      }
      if (known.invoiceNumber != null) {
        throw ValidationException(reason: ValidationError.alreadyInvoiced);
      }
      final price = await _refresh(session, known.bookingId, transaction);
      if (price.problems.isNotEmpty) {
        throw ValidationException(reason: ValidationError.pricingIncomplete);
      }
      // The folio is gone if there turned out to be nothing to charge.
      final charges = await Charge.db.count(
        session,
        where: (t) => t.folioId.equals(folioId),
        transaction: transaction,
      );
      if (charges == 0) {
        throw ValidationException(reason: ValidationError.nothingToInvoice);
      }

      final today = await todayInGermany(
        session,
        transaction: transaction,
      );
      await Folio.db.updateRow(
        session,
        known.copyWith(
          invoiceNumber: await _nextInvoiceNumber(
            session,
            today.year,
            transaction,
          ),
          invoicedAt: today,
        ),
        transaction: transaction,
      );
      return _updateStatus(session, folioId, transaction);
    });
  }

  /// The invoice of an invoiced folio as a PDF.
  ///
  /// It is produced when it is first asked for and kept as it is from then
  /// on, so that an invoice that was sent out does not change when the
  /// details of the operator or the address of the payer do.
  Future<ByteData> getInvoicePdf(Session session, int folioId) async {
    return session.db.transaction((transaction) async {
      // Only one call at a time produces the document.
      await Folio.db.lockRows(
        session,
        where: (t) => t.id.equals(folioId),
        lockMode: LockMode.forUpdate,
        transaction: transaction,
      );
      final stored = await InvoiceDocument.db.findFirstRow(
        session,
        where: (t) => t.folioId.equals(folioId),
        transaction: transaction,
      );
      if (stored != null) return stored.pdf;

      final folio = await Folio.db.findById(
        session,
        folioId,
        include: Folio.include(
          payer: Contact.include(),
          booking: Booking.include(),
          charges: Charge.includeList(orderBy: (t) => t.id),
        ),
        transaction: transaction,
      );
      if (folio == null || folio.invoiceNumber == null) {
        throw ValidationException(reason: ValidationError.notFound);
      }
      final operator = await Operator.db.findFirstRow(
        session,
        transaction: transaction,
      );
      if (operator == null || !isCompleteForInvoices(operator)) {
        throw ValidationException(reason: ValidationError.operatorIncomplete);
      }
      final guests = await Guest.db.find(
        session,
        where: (t) => t.group.bookingId.equals(folio.bookingId),
        include: Guest.include(contact: Contact.include()),
        transaction: transaction,
      );

      final pdf = ByteData.sublistView(
        await buildInvoicePdf(
          operator: operator,
          folio: folio,
          guestNames: {
            for (final guest in guests)
              guest.id!:
                  '${guest.contact!.firstName} ${guest.contact!.lastName}'
                      .trim(),
          },
        ),
      );
      await InvoiceDocument.db.insertRow(
        session,
        InvoiceDocument(folioId: folioId, pdf: pdf),
        transaction: transaction,
      );
      return pdf;
    });
  }

  /// Produces the invoice anew from the details as they are now and keeps
  /// that in place of the stored document.
  ///
  /// Meant for an invoice that was not sent out yet, for example because the
  /// bank details were only entered after it was first opened.
  Future<ByteData> renewInvoicePdf(Session session, int folioId) async {
    requireAdmin(session);
    await InvoiceDocument.db.deleteWhere(
      session,
      where: (t) => t.folioId.equals(folioId),
    );
    return getInvoicePdf(session, folioId);
  }

  /// Records money received for a folio. A negative amount is a refund.
  Future<Payment> addPayment(Session session, Payment payment) async {
    requireAdmin(session);
    if (payment.amount == 0) {
      throw ValidationException(reason: ValidationError.invalidAmount);
    }
    requireDateOnly(payment.date);
    return session.db.transaction((transaction) async {
      final added = await Payment.db.insertRow(
        session,
        payment,
        transaction: transaction,
      );
      await _updateStatus(session, payment.folioId, transaction);
      return added;
    });
  }

  /// Removes a payment that was recorded by mistake. A payment that a
  /// donation was made with stays until the donation is removed.
  Future<void> deletePayment(Session session, int id) async {
    requireAdmin(session);
    await session.db.transaction((transaction) async {
      final payment = await Payment.db.findById(
        session,
        id,
        transaction: transaction,
      );
      if (payment == null) return;
      final donations = await Donation.db.count(
        session,
        where: (t) => t.paymentId.equals(id),
        transaction: transaction,
      );
      if (donations > 0) {
        throw ValidationException(reason: ValidationError.inUse);
      }
      await Payment.db.deleteRow(session, payment, transaction: transaction);
      await _updateStatus(session, payment.folioId, transaction);
    });
  }

  /// Records that the payer leaves [amount] of what they overpaid with the
  /// payment as a donation.
  ///
  /// This is only called when the payer said so. A donation has to be
  /// voluntary to count as one, so overpaid money never becomes a donation
  /// by itself.
  Future<Donation> donate(Session session, int paymentId, int amount) async {
    requireAdmin(session);
    if (amount <= 0) {
      throw ValidationException(reason: ValidationError.invalidAmount);
    }
    return session.db.transaction((transaction) async {
      final payment = await Payment.db.findById(
        session,
        paymentId,
        transaction: transaction,
      );
      if (payment == null) {
        throw ValidationException(reason: ValidationError.notFound);
      }
      final overpaid = await _balance(session, payment.folioId, transaction);
      if (amount > overpaid) {
        throw ValidationException(reason: ValidationError.notOverpaid);
      }
      final donation = await Donation.db.insertRow(
        session,
        Donation(
          contactId: payment.payerId,
          amount: amount,
          date: payment.date,
          paymentId: paymentId,
          source: DonationSource.overpayment,
        ),
        transaction: transaction,
      );
      await _updateStatus(session, payment.folioId, transaction);
      return donation;
    });
  }

  /// Takes back a donation; the money counts as overpaid again. A
  /// donation that is on a receipt stays.
  Future<void> deleteDonation(Session session, int id) async {
    requireAdmin(session);
    await session.db.transaction((transaction) async {
      final donation = await Donation.db.findById(
        session,
        id,
        include: Donation.include(payment: Payment.include()),
        transaction: transaction,
      );
      if (donation == null) return;
      if (donation.receiptId != null) {
        throw ValidationException(reason: ValidationError.alreadyReceipted);
      }
      await Donation.db.deleteRow(session, donation, transaction: transaction);
      if (donation.payment case final payment?) {
        await _updateStatus(session, payment.folioId, transaction);
      }
    });
  }

  /// Brings the calculated charges of the folios that are not invoiced yet
  /// in line with the booking, and returns what the booking costs.
  ///
  /// Folios are created for payers who have none. A folio that nobody is
  /// charged on anymore is removed, unless it has payments or charges that
  /// were added by hand.
  Future<BookingPrice> _refresh(
    Session session,
    int bookingId,
    Transaction transaction,
  ) async {
    // One refresh of a booking at a time.
    await Booking.db.lockRows(
      session,
      where: (t) => t.id.equals(bookingId),
      lockMode: LockMode.forUpdate,
      transaction: transaction,
    );
    final data = await PricingData.load(
      session,
      bookingId,
      transaction: transaction,
    );
    if (data == null) {
      throw ValidationException(reason: ValidationError.notFound);
    }
    final byPayer = distributeLines(
      booking: data.booking,
      groups: data.groups,
      ageGroups: data.ageGroups,
      lines: data.price.lines,
    );

    final folios = await Folio.db.find(
      session,
      where: (t) => t.bookingId.equals(bookingId),
      include: Folio.include(
        charges: Charge.includeList(orderBy: (t) => t.id),
        payments: Payment.includeList(),
      ),
      transaction: transaction,
    );
    for (final MapEntry(key: payerId, value: lines) in byPayer.entries) {
      final folio =
          folios.where((folio) => folio.payerId == payerId).firstOrNull ??
          await Folio.db.insertRow(
            session,
            Folio(bookingId: bookingId, payerId: payerId),
            transaction: transaction,
          );
      if (folio.invoiceNumber != null) continue;
      await _setCalculated(session, folio, lines, transaction);
    }
    for (final folio in folios) {
      if (folio.invoiceNumber != null) continue;
      if (byPayer.containsKey(folio.payerId)) continue;
      await _setCalculated(session, folio, [], transaction);
      final byHand = folio.charges!.where((c) => !_calculated.contains(c.type));
      if (byHand.isEmpty && folio.payments!.isEmpty) {
        await Folio.db.deleteRow(session, folio, transaction: transaction);
      }
    }
    return data.price;
  }

  /// Replaces the calculated charges of the folio with [lines], unless they
  /// are the same already.
  Future<void> _setCalculated(
    Session session,
    Folio folio,
    List<ChargeLine> lines,
    Transaction transaction,
  ) async {
    final current = [
      for (final charge in folio.charges ?? <Charge>[])
        if (_calculated.contains(charge.type)) charge,
    ];
    final wanted = [
      for (final line in lines)
        Charge(
          folioId: folio.id!,
          guestId: line.guestId,
          type: line.type,
          description: line.description,
          quantity: line.quantity,
          unitPrice: line.unitPrice,
          total: line.total,
          taxRate: line.taxRate,
          periodFrom: line.periodFrom,
          periodTo: line.periodTo,
        ),
    ];
    if (current.length == wanted.length) {
      var same = true;
      for (var i = 0; i < current.length && same; i++) {
        same = _sameCharge(current[i], wanted[i]);
      }
      if (same) return;
    }

    if (current.isNotEmpty) {
      await Charge.db.deleteWhere(
        session,
        where: (t) => t.folioId.equals(folio.id) & t.type.inSet(_calculated),
        transaction: transaction,
      );
    }
    if (wanted.isNotEmpty) {
      await Charge.db.insert(session, wanted, transaction: transaction);
    }
  }

  bool _sameCharge(Charge a, Charge b) =>
      a.guestId == b.guestId &&
      a.type == b.type &&
      a.description == b.description &&
      a.quantity == b.quantity &&
      a.unitPrice == b.unitPrice &&
      a.total == b.total &&
      a.taxRate == b.taxRate &&
      a.periodFrom == b.periodFrom &&
      a.periodTo == b.periodTo;

  Future<void> _requireOpen(Session session, int folioId) async {
    final folio = await Folio.db.findById(session, folioId);
    if (folio == null) {
      throw ValidationException(reason: ValidationError.notFound);
    }
    if (folio.invoiceNumber != null) {
      throw ValidationException(reason: ValidationError.alreadyInvoiced);
    }
  }

  /// What was paid on the folio beyond its charges and the donations made
  /// with its payments; negative while money is still owed.
  Future<int> _balance(
    Session session,
    int folioId,
    Transaction transaction,
  ) async {
    final charges = await Charge.db.find(
      session,
      where: (t) => t.folioId.equals(folioId),
      transaction: transaction,
    );
    final payments = await Payment.db.find(
      session,
      where: (t) => t.folioId.equals(folioId),
      include: Payment.include(donations: Donation.includeList()),
      transaction: transaction,
    );
    var balance = 0;
    for (final payment in payments) {
      balance += payment.amount;
      for (final donation in payment.donations ?? <Donation>[]) {
        balance -= donation.amount;
      }
    }
    for (final charge in charges) {
      balance -= charge.total;
    }
    return balance;
  }

  /// An invoiced folio is settled once nothing is owed on it anymore.
  Future<Folio> _updateStatus(
    Session session,
    int folioId,
    Transaction transaction,
  ) async {
    final folio = await Folio.db.findById(
      session,
      folioId,
      transaction: transaction,
    );
    if (folio == null) {
      throw ValidationException(reason: ValidationError.notFound);
    }
    final status = folio.invoiceNumber == null
        ? FolioStatus.open
        : await _balance(session, folioId, transaction) >= 0
        ? FolioStatus.settled
        : FolioStatus.invoiced;
    if (status == folio.status) return folio;
    return Folio.db.updateRow(
      session,
      folio.copyWith(status: status),
      transaction: transaction,
    );
  }

  /// The next number of the year, such as 2026-0001. Numbers are given one
  /// at a time and in order, so there are no gaps and no duplicates.
  Future<String> _nextInvoiceNumber(
    Session session,
    int year,
    Transaction transaction,
  ) async {
    await session.db.unsafeExecute(
      'SELECT pg_advisory_xact_lock($_invoiceNumberLock)',
      transaction: transaction,
    );
    final result = await session.db.unsafeQuery(
      'SELECT max(substring("invoiceNumber" from 6)::int) FROM folios '
      'WHERE "invoiceNumber" LIKE \'$year-%\'',
      transaction: transaction,
    );
    final last = result.first.first as int? ?? 0;
    return '$year-${(last + 1).toString().padLeft(4, '0')}';
  }
}
