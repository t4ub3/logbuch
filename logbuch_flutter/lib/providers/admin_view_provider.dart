import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'admin_view_provider.g.dart';

enum AdminSection {
  rooms,
  priceCategories,
  ageGroups,
  seasons,
  mealPlans,
  rates,
  fees,
  bookingCategories,
  operator,
  users,
}

/// The section currently shown in the admin panel.
@Riverpod(keepAlive: true)
class SelectedAdminSection extends _$SelectedAdminSection {
  @override
  AdminSection build() => AdminSection.rooms;

  void select(AdminSection section) => state = section;
}
