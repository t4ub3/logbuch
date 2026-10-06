import 'dart:convert';
import 'dart:typed_data';

import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'roles.dart';
import 'validation_matcher.dart';

void main() {
  withAdmin('Given a booking with two adults for three nights', (
    sessionBuilder,
    endpoints,
  ) {
    late Contact lead;
    late Contact partner;
    late Season season;
    late AgeGroup adult;
    late Room room;
    late Booking booking;
    late GuestGroup friends;

    Future<void> setRate(int price) => endpoints.roomRate.saveForSeason(
      sessionBuilder,
      season.id!,
      [
        RoomRate(
          seasonId: season.id!,
          priceCategoryId: room.priceCategoryId,
          ageGroupId: adult.id!,
          pricePerNight: price,
        ),
      ],
    );

    Future<List<Folio>> folios() =>
        endpoints.billing.getFolios(sessionBuilder, booking.id!);

    Future<Folio> folio() async => (await folios()).single;

    int total(Folio folio) =>
        folio.charges!.fold(0, (sum, charge) => sum + charge.total);

    Future<Payment> pay(Folio folio, int amount) =>
        endpoints.billing.addPayment(
          sessionBuilder,
          Payment(
            folioId: folio.id!,
            payerId: folio.payerId,
            amount: amount,
            date: DateTime.utc(2027, 5, 13),
            method: PaymentMethod.bankTransfer,
          ),
        );

    setUp(() async {
      lead = await endpoints.contact.add(
        sessionBuilder,
        Contact(
          firstName: 'Marie',
          lastName: 'Weber',
          birthDate: DateTime.utc(1984, 5, 17),
        ),
      );
      partner = await endpoints.contact.add(
        sessionBuilder,
        Contact(
          firstName: 'Felix',
          lastName: 'Wagner',
          birthDate: DateTime.utc(1980, 1, 1),
        ),
      );
      final category = await endpoints.priceCategory.add(
        sessionBuilder,
        PriceCategory(name: 'Standard'),
      );
      room = await endpoints.room.add(
        sessionBuilder,
        Room(roomNumber: '101', bedAmount: 4, priceCategoryId: category.id!),
      );
      season = await endpoints.season.add(
        sessionBuilder,
        Season(
          name: 'Spring',
          validFrom: DateTime.utc(2027, 3, 1),
          validTo: DateTime.utc(2027, 5, 31),
        ),
      );
      adult = await endpoints.ageGroup.add(
        sessionBuilder,
        AgeGroup(name: 'Adult', minAge: 18),
      );
      await setRate(2500);

      booking = await endpoints.booking.add(
        sessionBuilder,
        Booking(
          title: 'Spring days',
          arrival: DateTime.utc(2027, 5, 10),
          departure: DateTime.utc(2027, 5, 13),
          leadId: lead.id!,
        ),
      );
      booking = await endpoints.booking.setRooms(sessionBuilder, booking.id!, [
        room.id!,
      ]);
      friends = await endpoints.guest.addGroup(
        sessionBuilder,
        GuestGroup(bookingId: booking.id!, name: 'Friends'),
      );
      final guests = [
        for (final contact in [lead, partner])
          await endpoints.guest.addGuest(
            sessionBuilder,
            Guest(groupId: friends.id!, contactId: contact.id!),
          ),
      ];
      await endpoints.guest.assign(sessionBuilder, [
        for (final guest in guests) guest.id!,
      ], booking.rooms!.single.id);
    });

    test('when reading its folios '
        'then the lead is charged for everybody', () async {
      final only = await folio();

      expect(only.payerId, lead.id);
      expect(only.payer?.lastName, 'Weber');
      expect(only.status, FolioStatus.open);
      expect(only.charges!.map((c) => (c.type, c.quantity, c.total)), [
        (ChargeType.lodging, 3, 7500),
        (ChargeType.lodging, 3, 7500),
      ]);
    });

    test('when a rate changes before invoicing '
        'then the charges follow it', () async {
      await folio();
      await setRate(3000);

      expect(total(await folio()), 18000);
    });

    test('when nothing changes '
        'then reading the folios again keeps the charges', () async {
      final before = await folio();
      final after = await folio();

      expect(after.charges!.map((c) => c.id), before.charges!.map((c) => c.id));
    });

    test('when billing per guest '
        'then every adult gets a folio of their own', () async {
      await folio();
      await endpoints.booking.update(
        sessionBuilder,
        booking.copyWith(billingMode: BillingMode.perGuest),
      );

      final perGuest = await folios();
      expect(perGuest.map((f) => (f.payerId, total(f))).toSet(), {
        (lead.id, 7500),
        (partner.id, 7500),
      });
    });

    test(
      'when billing per group with a payer '
      'then the folio of the lead is replaced by one for the payer',
      () async {
        await folio();
        await endpoints.guest.updateGroup(
          sessionBuilder,
          friends.copyWith(payerId: partner.id),
        );
        await endpoints.booking.update(
          sessionBuilder,
          booking.copyWith(billingMode: BillingMode.perGroup),
        );

        final only = await folio();
        expect(only.payerId, partner.id);
        expect(total(only), 15000);
      },
    );

    group('when a charge is added by hand', () {
      Charge charge(Folio folio, ChargeType type, int unitPrice) => Charge(
        folioId: folio.id!,
        type: type,
        description: ' Sauna ',
        quantity: 2,
        unitPrice: unitPrice,
        total: 0,
        taxRate: 700,
      );

      test('then it stays when the charges are calculated again', () async {
        final added = await endpoints.billing.addCharge(
          sessionBuilder,
          charge(await folio(), ChargeType.manual, 800),
        );
        expect(added.description, 'Sauna');
        expect(added.total, 1600);

        await setRate(3000);
        final after = await folio();
        expect(total(after), 18000 + 1600);

        await endpoints.billing.deleteCharge(sessionBuilder, added.id!);
        expect(total(await folio()), 18000);
      });

      test('then a discount lowers what is owed', () async {
        await endpoints.billing.addCharge(
          sessionBuilder,
          charge(await folio(), ChargeType.discount, -500),
        );

        expect(total(await folio()), 15000 - 1000);
      });

      test('then the sign of the price has to fit its type', () async {
        final only = await folio();

        await expectLater(
          endpoints.billing.addCharge(
            sessionBuilder,
            charge(only, ChargeType.discount, 500),
          ),
          throwsValidation(ValidationError.invalidAmount),
        );
        await expectLater(
          endpoints.billing.addCharge(
            sessionBuilder,
            charge(only, ChargeType.manual, -500),
          ),
          throwsValidation(ValidationError.invalidAmount),
        );
        await expectLater(
          endpoints.billing.addCharge(
            sessionBuilder,
            charge(only, ChargeType.lodging, 500),
          ),
          throwsValidation(ValidationError.invalidAmount),
        );
      });

      test('then a calculated charge cannot be removed', () async {
        final only = await folio();

        await expectLater(
          endpoints.billing.deleteCharge(
            sessionBuilder,
            only.charges!.first.id!,
          ),
          throwsValidation(ValidationError.inUse),
        );
      });
    });

    group('when the folio is invoiced', () {
      late Folio invoiced;

      setUp(() async {
        invoiced = await endpoints.billing.invoice(
          sessionBuilder,
          (await folio()).id!,
        );
      });

      test('then it has the first invoice number of the year', () async {
        expect(invoiced.invoiceNumber, matches(RegExp(r'^\d{4}-0001$')));
        expect(invoiced.invoicedAt, isNotNull);
        expect(invoiced.status, FolioStatus.invoiced);
      });

      test('then its charges no longer follow the rates', () async {
        await setRate(3000);

        expect(total(await folio()), 15000);
      });

      test('then it cannot be invoiced again or changed by hand', () async {
        final rejected = throwsValidation(ValidationError.alreadyInvoiced);

        await expectLater(
          endpoints.billing.invoice(sessionBuilder, invoiced.id!),
          rejected,
        );
        await expectLater(
          endpoints.billing.addCharge(
            sessionBuilder,
            Charge(
              folioId: invoiced.id!,
              type: ChargeType.manual,
              description: 'Sauna',
              quantity: 1,
              unitPrice: 800,
              total: 800,
              taxRate: 700,
            ),
          ),
          rejected,
        );
        await expectLater(
          endpoints.booking.update(
            sessionBuilder,
            booking.copyWith(billingMode: BillingMode.perGuest),
          ),
          rejected,
        );
      });

      test('then the next invoice gets the next number', () async {
        final other = await endpoints.booking.add(
          sessionBuilder,
          Booking(title: 'Other', leadId: partner.id!),
        );
        final otherFolio = (await endpoints.billing.getFolios(
          sessionBuilder,
          other.id!,
        )).firstOrNull;
        // A booking without dates has nothing to charge and no folio.
        expect(otherFolio, isNull);

        await endpoints.booking.update(
          sessionBuilder,
          booking.copyWith(title: 'Spring days again'),
        );
        final second = await endpoints.booking.add(
          sessionBuilder,
          Booking(
            title: 'Second',
            arrival: DateTime.utc(2027, 5, 20),
            departure: DateTime.utc(2027, 5, 21),
            leadId: lead.id!,
          ),
        );
        final secondGroup = await endpoints.guest.addGroup(
          sessionBuilder,
          GuestGroup(bookingId: second.id!, name: 'Solo'),
        );
        final held = await endpoints.booking.setRooms(
          sessionBuilder,
          second.id!,
          [room.id!],
        );
        final guest = await endpoints.guest.addGuest(
          sessionBuilder,
          Guest(groupId: secondGroup.id!, contactId: lead.id!),
        );
        await endpoints.guest.assign(sessionBuilder, [
          guest.id!,
        ], held.rooms!.single.id);
        final secondFolio = (await endpoints.billing.getFolios(
          sessionBuilder,
          second.id!,
        )).single;

        final next = await endpoints.billing.invoice(
          sessionBuilder,
          secondFolio.id!,
        );

        expect(next.invoiceNumber, matches(RegExp(r'^\d{4}-0002$')));
      });

      group('and its invoice is asked for', () {
        Future<Operator> saveOperator(String name) => endpoints.operator.save(
          sessionBuilder,
          Operator(
            name: name,
            street: 'Seeweg 1',
            zip: '34117',
            city: 'Kassel',
            taxOffice: '',
            taxNumber: '026 250 12345',
            purposes: '',
            place: '',
          ),
        );

        test('then it needs the details of the operator', () async {
          await expectLater(
            endpoints.billing.getInvoicePdf(sessionBuilder, invoiced.id!),
            throwsValidation(ValidationError.operatorIncomplete),
          );
        });

        test('then it is a PDF that stays as it was first produced', () async {
          await saveOperator('Haus am See e. V.');
          final first = await endpoints.billing.getInvoicePdf(
            sessionBuilder,
            invoiced.id!,
          );
          final start = first.buffer.asUint8List(first.offsetInBytes, 5);
          expect(ascii.decode(start), '%PDF-');

          await saveOperator('Haus am Berg e. V.');
          final again = await endpoints.billing.getInvoicePdf(
            sessionBuilder.asViewer,
            invoiced.id!,
          );

          expect(
            again.buffer.asUint8List(again.offsetInBytes, again.lengthInBytes),
            first.buffer.asUint8List(first.offsetInBytes, first.lengthInBytes),
          );
        });
      });

      test(
        'then an admin can renew its invoice with changed details',
        () async {
          Future<Operator> saveOperator(String name) => endpoints.operator.save(
            sessionBuilder,
            Operator(
              name: name,
              street: 'Seeweg 1',
              zip: '34117',
              city: 'Kassel',
              taxOffice: '',
              taxNumber: '026 250 12345',
              purposes: '',
              place: '',
            ),
          );
          List<int> bytes(ByteData pdf) =>
              pdf.buffer.asUint8List(pdf.offsetInBytes, pdf.lengthInBytes);

          await saveOperator('Haus am See e. V.');
          final first = await endpoints.billing.getInvoicePdf(
            sessionBuilder,
            invoiced.id!,
          );
          await saveOperator('Haus am Berg und am See e. V.');

          await expectLater(
            endpoints.billing.renewInvoicePdf(
              sessionBuilder.asViewer,
              invoiced.id!,
            ),
            throwsValidation(ValidationError.adminRequired),
          );
          final renewed = await endpoints.billing.renewInvoicePdf(
            sessionBuilder,
            invoiced.id!,
          );
          expect(bytes(renewed).length, isNot(bytes(first).length));

          // The renewed document is the one that is kept.
          final again = await endpoints.billing.getInvoicePdf(
            sessionBuilder,
            invoiced.id!,
          );
          expect(bytes(again), bytes(renewed));
        },
      );

      test('then paying what is owed settles it', () async {
        await pay(invoiced, 10000);
        expect((await folio()).status, FolioStatus.invoiced);

        await pay(invoiced, 5000);
        expect((await folio()).status, FolioStatus.settled);
      });

      test('then only what was overpaid can become a donation', () async {
        final payment = await pay(invoiced, 16000);

        await expectLater(
          endpoints.billing.donate(sessionBuilder, payment.id!, 1001),
          throwsValidation(ValidationError.notOverpaid),
        );

        final donation = await endpoints.billing.donate(
          sessionBuilder,
          payment.id!,
          1000,
        );
        expect(donation.contactId, lead.id);
        expect(donation.source, DonationSource.overpayment);
        expect(donation.date, DateTime.utc(2027, 5, 13));

        // Nothing is left over that could be donated twice.
        await expectLater(
          endpoints.billing.donate(sessionBuilder, payment.id!, 1),
          throwsValidation(ValidationError.notOverpaid),
        );
        final after = await folio();
        expect(after.payments!.single.donations!.single.amount, 1000);
        expect(after.status, FolioStatus.settled);
      });

      test('then a payment with a donation stays until the donation is '
          'taken back', () async {
        final payment = await pay(invoiced, 16000);
        final donation = await endpoints.billing.donate(
          sessionBuilder,
          payment.id!,
          1000,
        );

        await expectLater(
          endpoints.billing.deletePayment(sessionBuilder, payment.id!),
          throwsValidation(ValidationError.inUse),
        );
        await expectLater(
          endpoints.contact.delete(sessionBuilder, lead.id!),
          throwsValidation(ValidationError.inUse),
        );

        await endpoints.billing.deleteDonation(sessionBuilder, donation.id!);
        await endpoints.billing.deletePayment(sessionBuilder, payment.id!);

        final after = await folio();
        expect(after.payments, isEmpty);
        expect(after.status, FolioStatus.invoiced);
      });

      test('then a refund is a payment with a negative amount', () async {
        await pay(invoiced, 16000);
        await pay(invoiced, -1000);

        final after = await folio();
        expect(after.payments!.map((p) => p.amount), [16000, -1000]);
        expect(after.status, FolioStatus.settled);
      });
    });

    test('when asking for the invoice of a folio that is not invoiced '
        'then there is none', () async {
      await expectLater(
        endpoints.billing.getInvoicePdf(sessionBuilder, (await folio()).id!),
        throwsValidation(ValidationError.notFound),
      );
    });

    test('when a guest cannot be priced '
        'then the folio cannot be invoiced', () async {
      final only = await folio();
      await endpoints.guest.addNewGuest(
        sessionBuilder,
        Guest(groupId: friends.id!, contactId: 0),
        Contact(firstName: 'No', lastName: 'Birthday'),
      );

      await expectLater(
        endpoints.billing.invoice(sessionBuilder, only.id!),
        throwsValidation(ValidationError.pricingIncomplete),
      );
    });

    test('when a viewer looks at the folios '
        'then they are shown but cannot be changed', () async {
      final viewer = sessionBuilder.asViewer;

      final only = (await endpoints.billing.getFolios(
        viewer,
        booking.id!,
      )).single;
      expect(total(only), 15000);

      final rejected = throwsValidation(ValidationError.adminRequired);
      await expectLater(endpoints.billing.invoice(viewer, only.id!), rejected);
      await expectLater(
        endpoints.billing.addPayment(
          viewer,
          Payment(
            folioId: only.id!,
            payerId: only.payerId,
            amount: 100,
            date: DateTime.utc(2027, 5, 13),
            method: PaymentMethod.cash,
          ),
        ),
        rejected,
      );
      await expectLater(endpoints.billing.donate(viewer, 1, 100), rejected);
    });
  });
}
