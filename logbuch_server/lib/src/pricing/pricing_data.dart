import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:logbuch_server/src/generated/serverpod.dart';
import 'package:logbuch_server/src/pricing/price_calculation.dart';

/// A booking with everything that its price is calculated from.
class PricingData {
  PricingData._({
    required this.booking,
    required this.groups,
    required this.ageGroups,
    required this.price,
  });

  /// With the rooms it holds and its meal plan.
  final Booking booking;

  /// With their guests and the contacts of those.
  final List<GuestGroup> groups;
  final List<AgeGroup> ageGroups;

  /// What the booking costs by the rates and fees as they are now.
  final BookingPrice price;

  /// Reads the booking and prices it, see [calculatePrice]. Null if there
  /// is no such booking.
  static Future<PricingData?> load(
    Session session,
    int bookingId, {
    Transaction? transaction,
  }) async {
    final booking = await Booking.db.findById(
      session,
      bookingId,
      include: Booking.include(
        mealPlan: MealPlan.include(),
        rooms: BookingRoom.includeList(
          include: BookingRoom.include(room: Room.include()),
        ),
      ),
      transaction: transaction,
    );
    if (booking == null) return null;

    final groups = await GuestGroup.db.find(
      session,
      where: (t) => t.bookingId.equals(bookingId),
      orderByList: (t) => [t.sortOrder.asc(), t.id.asc()],
      include: GuestGroup.include(
        guests: Guest.includeList(
          orderBy: (t) => t.id,
          include: Guest.include(contact: Contact.include()),
        ),
      ),
      transaction: transaction,
    );
    final ageGroups = await AgeGroup.db.find(session, transaction: transaction);

    return PricingData._(
      booking: booking,
      groups: groups,
      ageGroups: ageGroups,
      price: calculatePrice(
        booking: booking,
        guests: [for (final group in groups) ...?group.guests],
        seasons: await Season.db.find(session, transaction: transaction),
        ageGroups: ageGroups,
        priceCategories: await PriceCategory.db.find(
          session,
          transaction: transaction,
        ),
        mealPlan: booking.mealPlan,
        roomRates: await RoomRate.db.find(session, transaction: transaction),
        mealRates: await MealRate.db.find(session, transaction: transaction),
        fees: await Fee.db.find(
          session,
          orderBy: (t) => t.name,
          transaction: transaction,
        ),
      ),
    );
  }
}
