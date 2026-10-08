import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'admin_view_provider.g.dart';

enum AdminSection {
  buildings,
  rooms,
  unitTypes,
  ageGroups,
  mealPlans,
  fees,
  priceLists,
  bookingCategories,
  operator,
  users,
}

/// What the sections of the admin panel are sorted into.
enum AdminGroup {
  house([AdminSection.buildings, AdminSection.rooms]),
  prices([
    AdminSection.unitTypes,
    AdminSection.ageGroups,
    AdminSection.mealPlans,
    AdminSection.fees,
    AdminSection.priceLists,
  ]),
  bookings([AdminSection.bookingCategories]),
  organisation([AdminSection.operator, AdminSection.users]);

  const AdminGroup(this.sections);

  final List<AdminSection> sections;

  static AdminGroup of(AdminSection section) =>
      values.firstWhere((group) => group.sections.contains(section));
}

/// The section currently shown in the admin panel.
@Riverpod(keepAlive: true)
class SelectedAdminSection extends _$SelectedAdminSection {
  @override
  AdminSection build() => AdminSection.rooms;

  void select(AdminSection section) => state = section;
}
