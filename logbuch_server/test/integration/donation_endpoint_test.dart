import 'dart:convert';

import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'roles.dart';
import 'validation_matcher.dart';

void main() {
  withAdmin('Given donations of two donors in 2027', (
    sessionBuilder,
    endpoints,
  ) {
    late Contact marie;
    late Contact felix;
    late Donation spring;

    Future<Donation> donate(Contact donor, int amount, DateTime date) =>
        endpoints.donation.addDirect(
          sessionBuilder,
          Donation(
            contactId: donor.id!,
            amount: amount,
            date: date,
            source: DonationSource.overpayment,
          ),
        );

    Future<Operator> saveOperator({DateTime? noticeDate}) =>
        endpoints.operator.save(
          sessionBuilder,
          Operator(
            name: ' Haus am See e. V. ',
            street: 'Seeweg 1',
            zip: '34117',
            city: 'Kassel',
            taxOffice: 'Kassel',
            taxNumber: '26 250 12345',
            noticeDate: noticeDate ?? DateTime.utc(2025, 5, 3),
            purposes: 'der Jugendhilfe',
            purposesObject: 'die Jugendhilfe',
            place: 'Kassel',
          ),
        );

    setUp(() async {
      marie = await endpoints.contact.add(
        sessionBuilder,
        Contact(
          firstName: 'Marie',
          lastName: 'Weber',
          street: 'Lindenstraße 5',
          zip: '34119',
          city: 'Kassel',
        ),
      );
      // Felix has no address yet.
      felix = await endpoints.contact.add(
        sessionBuilder,
        Contact(firstName: 'Felix', lastName: 'Wagner'),
      );
      spring = await donate(marie, 5000, DateTime.utc(2027, 4, 2));
      await donate(marie, 2050, DateTime.utc(2027, 12, 31));
      await donate(felix, 1000, DateTime.utc(2027, 6, 1));
      await donate(marie, 9900, DateTime.utc(2028, 1, 1));
    });

    test('when listing a year '
        'then only its donations are returned, as direct donations', () async {
      final donations = await endpoints.donation.getByYear(
        sessionBuilder,
        2027,
      );

      expect(donations.map((d) => (d.contact!.lastName, d.amount)), [
        ('Weber', 5000),
        ('Wagner', 1000),
        ('Weber', 2050),
      ]);
      expect(donations.map((d) => d.source).toSet(), {DonationSource.direct});
      expect(donations.map((d) => d.receiptId).toSet(), {null});
    });

    test('when adding a donation without an amount '
        'then it is rejected', () async {
      await expectLater(
        donate(marie, 0, DateTime.utc(2027, 4, 2)),
        throwsValidation(ValidationError.invalidAmount),
      );
    });

    test(
      'when previewing the receipts '
      'then every donor is listed with what the receipt would cover',
      () async {
        final previews = await endpoints.donation.previewReceipts(
          sessionBuilder,
          2027,
        );

        expect(
          previews.map(
            (p) => (
              p.contact.lastName,
              p.donationCount,
              p.total,
              p.addressComplete,
            ),
          ),
          [('Wagner', 1, 1000, false), ('Weber', 2, 7050, true)],
        );
      },
    );

    test('when the details of the operator are missing '
        'then no receipts are issued', () async {
      await expectLater(
        endpoints.donation.createReceipts(sessionBuilder, 2027),
        throwsValidation(ValidationError.operatorIncomplete),
      );
    });

    test('when saving the details of the operator twice '
        'then the second time replaces the first', () async {
      await saveOperator();
      final saved = await saveOperator(noticeDate: DateTime.utc(2026, 2, 1));

      final loaded = await endpoints.operator.load(sessionBuilder.asViewer);
      expect(loaded?.id, saved.id);
      expect(loaded?.name, 'Haus am See e. V.');
      expect(loaded?.noticeDate, DateTime.utc(2026, 2, 1));
      expect(loaded?.noticeType, TaxNoticeType.statutoryCompliance);
    });

    group('when the receipts of the year are issued', () {
      late List<DonationReceipt> receipts;

      setUp(() async {
        await saveOperator();
        receipts = await endpoints.donation.createReceipts(
          sessionBuilder,
          2027,
        );
      });

      test('then the donor with an address gets one for all donations '
          'of the year', () async {
        final receipt = receipts.single;
        expect(receipt.number, 'SB-2027-0001');
        expect(receipt.contactId, marie.id);
        expect(receipt.year, 2027);
        expect(receipt.total, 7050);

        final donations = await endpoints.donation.getByYear(
          sessionBuilder,
          2027,
        );
        expect(donations.map((d) => (d.amount, d.receipt?.number)), [
          (5000, 'SB-2027-0001'),
          (1000, null),
          (2050, 'SB-2027-0001'),
        ]);
      });

      test('then the receipt comes as a PDF', () async {
        final pdf = await endpoints.donation.getReceiptPdf(
          sessionBuilder.asViewer,
          receipts.single.id!,
        );

        // The bytes are a view into a larger buffer.
        final start = pdf.buffer.asUint8List(pdf.offsetInBytes, 5);
        expect(ascii.decode(start), '%PDF-');
        expect(pdf.lengthInBytes, greaterThan(1000));
      });

      test('then its donations can no longer be removed', () async {
        final rejected = throwsValidation(ValidationError.alreadyReceipted);

        await expectLater(
          endpoints.donation.delete(sessionBuilder, spring.id!),
          rejected,
        );
        await expectLater(
          endpoints.billing.deleteDonation(sessionBuilder, spring.id!),
          rejected,
        );
      });

      test('then issuing again only covers what has no receipt yet', () async {
        expect(
          await endpoints.donation.createReceipts(sessionBuilder, 2027),
          isEmpty,
        );

        await endpoints.contact.update(
          sessionBuilder,
          felix.copyWith(street: 'Am Markt 2', zip: '99084', city: 'Erfurt'),
        );
        await donate(marie, 300, DateTime.utc(2027, 7, 7));
        final more = await endpoints.donation.createReceipts(
          sessionBuilder,
          2027,
        );

        expect(more.map((r) => (r.number, r.contact?.lastName, r.total)), [
          ('SB-2027-0002', 'Wagner', 1000),
          ('SB-2027-0003', 'Weber', 300),
        ]);
        final all = await endpoints.donation.getReceipts(sessionBuilder, 2027);
        expect(all.map((r) => r.number), [
          'SB-2027-0001',
          'SB-2027-0002',
          'SB-2027-0003',
        ]);
      });

      test('then another year starts its numbers again', () async {
        final next = await endpoints.donation.createReceipts(
          sessionBuilder,
          2028,
        );

        expect(next.single.number, 'SB-2028-0001');
      });
    });

    test('when removing a donation that is on no receipt '
        'then it is gone', () async {
      await endpoints.donation.delete(sessionBuilder, spring.id!);

      final donations = await endpoints.donation.getByYear(
        sessionBuilder,
        2027,
      );
      expect(donations.map((d) => d.amount), [1000, 2050]);
    });

    test('when a viewer looks at the donations '
        'then they are shown but cannot be changed', () async {
      final viewer = sessionBuilder.asViewer;
      final rejected = throwsValidation(ValidationError.adminRequired);

      expect(await endpoints.donation.getByYear(viewer, 2027), hasLength(3));
      expect(
        await endpoints.donation.previewReceipts(viewer, 2027),
        hasLength(2),
      );
      await expectLater(
        endpoints.donation.createReceipts(viewer, 2027),
        rejected,
      );
      await expectLater(
        endpoints.donation.delete(viewer, spring.id!),
        rejected,
      );
      await expectLater(
        endpoints.operator.save(
          viewer,
          Operator(
            name: 'X',
            street: '',
            zip: '',
            city: '',
            taxOffice: '',
            taxNumber: '',
            purposes: '',
            place: '',
          ),
        ),
        rejected,
      );
    });
  });
}
