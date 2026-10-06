import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:logbuch_server/src/pricing/price_calculation.dart';

/// Sums up the guests of a booking for the kitchen: how many there are in
/// every age group, and what some of them cannot or do not eat.
///
/// A guest counts in the age group they are priced with, which is the one
/// set for the guest or else the group of their age on the day they arrive.
/// A booking without dates has no such day, so [today] is used instead.
/// Every age group is listed, youngest first, also those without guests.
///
/// [groups] must come with their guests and the contacts of those.
KitchenOverview buildKitchenOverview({
  required Booking booking,
  required List<GuestGroup> groups,
  required List<AgeGroup> ageGroups,
  required DateTime today,
}) {
  final youngestFirst = [...ageGroups]
    ..sort((a, b) => a.minAge.compareTo(b.minAge));
  final counts = {for (final ageGroup in youngestFirst) ageGroup.id: 0};
  final dietaryNeeds = <DietaryNeed>[];
  var guestCount = 0;
  var unknownAge = 0;

  for (final group in groups) {
    for (final guest in group.guests ?? <Guest>[]) {
      guestCount++;
      final ageGroup = resolveAgeGroup(
        guest,
        guest.arrivalOverride ?? booking.arrival ?? today,
        ageGroups,
      );
      if (ageGroup == null) {
        unknownAge++;
      } else {
        counts[ageGroup.id] = counts[ageGroup.id]! + 1;
      }

      final notes = guest.dietaryNotes?.trim() ?? '';
      if (notes.isEmpty) continue;
      final contact = guest.contact;
      dietaryNeeds.add(
        DietaryNeed(
          guestName: '${contact?.firstName ?? ''} ${contact?.lastName ?? ''}'
              .trim(),
          groupName: group.name,
          ageGroupName: ageGroup?.name,
          notes: notes,
        ),
      );
    }
  }

  return KitchenOverview(
    guestCount: guestCount,
    ageGroups: [
      for (final ageGroup in youngestFirst)
        AgeGroupCount(ageGroup: ageGroup, count: counts[ageGroup.id]!),
    ],
    unknownAge: unknownAge,
    dietaryNeeds: dietaryNeeds,
  );
}
