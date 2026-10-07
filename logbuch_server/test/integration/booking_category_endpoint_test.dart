import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'roles.dart';
import 'validation_matcher.dart';

void main() {
  withAdmin('Given the categories of bookings', (sessionBuilder, endpoints) {
    Future<BookingCategory> add(
      String name, {
      BookingCategoryIcon icon = BookingCategoryIcon.education,
      BookingCategoryColor color = BookingCategoryColor.blue,
    }) => endpoints.bookingCategory.add(
      sessionBuilder,
      BookingCategory(name: name, icon: icon, color: color),
    );

    test('when adding some then they come back by name '
        'with their icon and color', () async {
      await add(
        ' Music ',
        icon: BookingCategoryIcon.music,
        color: BookingCategoryColor.purple,
      );
      await add('Class trips');

      final categories = await endpoints.bookingCategory.getAll(sessionBuilder);

      expect([for (final c in categories) c.name], ['Class trips', 'Music']);
      expect(categories.last.icon, BookingCategoryIcon.music);
      expect(categories.last.color, BookingCategoryColor.purple);
    });

    test('when adding one without a name then it is rejected', () async {
      expect(add('  '), throwsValidation(ValidationError.nameRequired));
    });

    test('when updating one then the changes are stored', () async {
      final category = await add('Class trips');

      await endpoints.bookingCategory.update(
        sessionBuilder,
        category.copyWith(name: 'School', color: BookingCategoryColor.red),
      );

      final stored = await endpoints.bookingCategory.getAll(sessionBuilder);
      expect(stored.single.name, 'School');
      expect(stored.single.color, BookingCategoryColor.red);
      expect(stored.single.icon, BookingCategoryIcon.education);
    });

    group('when a booking has a category', () {
      late BookingCategory category;
      late Booking booking;

      setUp(() async {
        category = await add('Class trips');
        final lead = await endpoints.contact.add(
          sessionBuilder,
          Contact(firstName: 'Ada', lastName: 'Lovelace'),
        );
        booking = await endpoints.booking.add(
          sessionBuilder,
          Booking(title: '8a', leadId: lead.id!, categoryId: category.id),
        );
      });

      test('then the booking comes with it', () async {
        expect(booking.category?.name, 'Class trips');
        final all = await endpoints.booking.getAll(sessionBuilder);
        expect(all.single.category?.icon, BookingCategoryIcon.education);
      });

      test('then the category cannot be deleted', () async {
        expect(
          endpoints.bookingCategory.delete(sessionBuilder, category.id!),
          throwsValidation(ValidationError.inUse),
        );
      });

      test('then it can be deleted once the booking has another', () async {
        await endpoints.booking.update(
          sessionBuilder,
          Booking(id: booking.id, title: '8a', leadId: booking.leadId),
        );

        await endpoints.bookingCategory.delete(sessionBuilder, category.id!);

        expect(await endpoints.bookingCategory.getAll(sessionBuilder), isEmpty);
      });
    });

    test('when a viewer changes them then that is rejected', () async {
      final category = await add('Class trips');
      final viewer = sessionBuilder.asViewer;
      final rejected = throwsValidation(ValidationError.adminRequired);

      expect(await endpoints.bookingCategory.getAll(viewer), hasLength(1));
      expect(endpoints.bookingCategory.add(viewer, category), rejected);
      expect(endpoints.bookingCategory.update(viewer, category), rejected);
      expect(endpoints.bookingCategory.delete(viewer, category.id!), rejected);
    });
  });
}
