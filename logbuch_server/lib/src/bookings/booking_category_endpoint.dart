import 'package:logbuch_server/src/auth/roles.dart';
import 'package:logbuch_server/src/common/validation.dart';
import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:logbuch_server/src/generated/serverpod.dart';

/// The categories that bookings are sorted into, such as class trips. A
/// category gives its bookings their icon and color.
class BookingCategoryEndpoint extends AppEndpoint {
  Future<List<BookingCategory>> getAll(Session session) async {
    return BookingCategory.db.find(session, orderBy: (t) => t.name);
  }

  Future<BookingCategory> add(Session session, BookingCategory category) async {
    requireAdmin(session);
    return await BookingCategory.db.insertRow(session, _validated(category));
  }

  Future<BookingCategory> update(
    Session session,
    BookingCategory category,
  ) async {
    requireAdmin(session);
    return await BookingCategory.db.updateRow(session, _validated(category));
  }

  /// A category that a booking has cannot be deleted.
  Future<void> delete(Session session, int id) async {
    requireAdmin(session);
    final bookings = await Booking.db.count(
      session,
      where: (t) => t.categoryId.equals(id),
    );
    if (bookings > 0) throw ValidationException(reason: ValidationError.inUse);
    await BookingCategory.db.deleteWhere(
      session,
      where: (t) => t.id.equals(id),
    );
  }

  BookingCategory _validated(BookingCategory category) =>
      category.copyWith(name: requireName(category.name));
}
