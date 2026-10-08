import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_flutter/components/inset_divider.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/panels/admin/age_groups_section.dart';
import 'package:logbuch_flutter/panels/admin/booking_categories_section.dart';
import 'package:logbuch_flutter/panels/admin/buildings_section.dart';
import 'package:logbuch_flutter/panels/admin/fees_section.dart';
import 'package:logbuch_flutter/panels/admin/meal_plans_section.dart';
import 'package:logbuch_flutter/panels/admin/operator_section.dart';
import 'package:logbuch_flutter/panels/admin/price_lists_section.dart';
import 'package:logbuch_flutter/panels/admin/rooms_section.dart';
import 'package:logbuch_flutter/panels/admin/unit_types_section.dart';
import 'package:logbuch_flutter/panels/admin/users_section.dart';
import 'package:logbuch_flutter/providers/admin_view_provider.dart';
import 'package:logbuch_flutter/providers/current_user_provider.dart';
import 'package:yaru/yaru.dart';

extension on AdminGroup {
  String label(BuildContext context) {
    final t = context.t.admin.groups;
    return switch (this) {
      AdminGroup.house => t.house,
      AdminGroup.prices => t.prices,
      AdminGroup.bookings => t.bookings,
      AdminGroup.organisation => t.organisation,
    };
  }

  IconData get icon => switch (this) {
    AdminGroup.house => YaruIcons.home,
    AdminGroup.prices => Icons.euro,
    AdminGroup.bookings => YaruIcons.calendar,
    AdminGroup.organisation => Icons.apartment,
  };
}

extension on AdminSection {
  String label(BuildContext context) {
    final t = context.t.admin.sections;
    return switch (this) {
      AdminSection.buildings => t.buildings,
      AdminSection.rooms => t.rooms,
      AdminSection.unitTypes => t.unitTypes,
      AdminSection.ageGroups => t.ageGroups,
      AdminSection.mealPlans => t.mealPlans,
      AdminSection.fees => t.fees,
      AdminSection.priceLists => t.priceLists,
      AdminSection.bookingCategories => t.bookingCategories,
      AdminSection.operator => t.operator,
      AdminSection.users => t.users,
    };
  }
}

/// Setup of the house, in groups of sections: the buildings and rooms, what
/// prices are made of and the prices themselves, what bookings are sorted
/// by, and who runs the house and may use the app.
class AdminPanel extends ConsumerWidget {
  const AdminPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Only admins manage the users.
    final canEdit = ref.watch(canEditProvider);
    final selected = ref.watch(selectedAdminSectionProvider);
    final section = selected == AdminSection.users && !canEdit
        ? AdminSection.rooms
        : selected;
    final group = AdminGroup.of(section);
    final sections = [
      for (final section in group.sections)
        if (section != AdminSection.users || canEdit) section,
    ];
    final notifier = ref.read(selectedAdminSectionProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // The groups do not fit next to each other in a narrow window.
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(8),
          child: SegmentedButton<AdminGroup>(
            segments: [
              for (final group in AdminGroup.values)
                ButtonSegment(
                  value: group,
                  label: Text(group.label(context)),
                  icon: Icon(group.icon),
                ),
            ],
            selected: {group},
            showSelectedIcon: false,
            // A group opens with its first section.
            onSelectionChanged: (selection) =>
                notifier.select(selection.single.sections.first),
          ),
        ),
        // A group with a single section has nothing to choose from.
        if (sections.length > 1)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: Row(
              spacing: 8,
              children: [
                for (final other in sections)
                  ChoiceChip(
                    label: Text(other.label(context)),
                    selected: other == section,
                    onSelected: (_) => notifier.select(other),
                  ),
              ],
            ),
          ),
        const InsetDivider(),
        Expanded(
          child: switch (section) {
            AdminSection.buildings => const BuildingsSection(),
            AdminSection.rooms => const RoomsSection(),
            AdminSection.unitTypes => const UnitTypesSection(),
            AdminSection.ageGroups => const AgeGroupsSection(),
            AdminSection.mealPlans => const MealPlansSection(),
            AdminSection.fees => const FeesSection(),
            AdminSection.priceLists => const PriceListsSection(),
            AdminSection.bookingCategories => const BookingCategoriesSection(),
            AdminSection.operator => const OperatorSection(),
            AdminSection.users => const UsersSection(),
          },
        ),
      ],
    );
  }
}
