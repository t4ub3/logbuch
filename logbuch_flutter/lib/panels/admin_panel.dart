import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_flutter/components/inset_divider.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/panels/admin/age_groups_section.dart';
import 'package:logbuch_flutter/panels/admin/booking_categories_section.dart';
import 'package:logbuch_flutter/panels/admin/fees_section.dart';
import 'package:logbuch_flutter/panels/admin/meal_plans_section.dart';
import 'package:logbuch_flutter/panels/admin/operator_section.dart';
import 'package:logbuch_flutter/panels/admin/price_categories_section.dart';
import 'package:logbuch_flutter/panels/admin/rates_section.dart';
import 'package:logbuch_flutter/panels/admin/rooms_section.dart';
import 'package:logbuch_flutter/panels/admin/seasons_section.dart';
import 'package:logbuch_flutter/panels/admin/users_section.dart';
import 'package:logbuch_flutter/providers/admin_view_provider.dart';
import 'package:logbuch_flutter/providers/current_user_provider.dart';
import 'package:yaru/yaru.dart';

/// Setup of the house: rooms and everything that prices are made of.
class AdminPanel extends ConsumerWidget {
  const AdminPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.admin.sections;
    // Only admins manage the users.
    final canEdit = ref.watch(canEditProvider);
    final selected = ref.watch(selectedAdminSectionProvider);
    final section = selected == AdminSection.users && !canEdit
        ? AdminSection.rooms
        : selected;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // The sections do not fit next to each other in a narrow window.
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(8),
          child: SegmentedButton<AdminSection>(
            segments: [
              ButtonSegment(
                value: AdminSection.rooms,
                label: Text(t.rooms),
                icon: const Icon(Icons.bed),
              ),
              ButtonSegment(
                value: AdminSection.priceCategories,
                label: Text(t.priceCategories),
                icon: const Icon(YaruIcons.tag),
              ),
              ButtonSegment(
                value: AdminSection.ageGroups,
                label: Text(t.ageGroups),
                icon: const Icon(YaruIcons.users),
              ),
              ButtonSegment(
                value: AdminSection.seasons,
                label: Text(t.seasons),
                icon: const Icon(YaruIcons.sun),
              ),
              ButtonSegment(
                value: AdminSection.mealPlans,
                label: Text(t.mealPlans),
                icon: const Icon(Icons.restaurant),
              ),
              ButtonSegment(
                value: AdminSection.rates,
                label: Text(t.rates),
                icon: const Icon(Icons.euro),
              ),
              ButtonSegment(
                value: AdminSection.fees,
                label: Text(t.fees),
                icon: const Icon(Icons.receipt_long),
              ),
              ButtonSegment(
                value: AdminSection.bookingCategories,
                label: Text(t.bookingCategories),
                icon: const Icon(YaruIcons.calendar),
              ),
              ButtonSegment(
                value: AdminSection.operator,
                label: Text(t.operator),
                icon: const Icon(Icons.apartment),
              ),
              if (canEdit)
                ButtonSegment(
                  value: AdminSection.users,
                  label: Text(t.users),
                  icon: const Icon(YaruIcons.user),
                ),
            ],
            selected: {section},
            showSelectedIcon: false,
            onSelectionChanged: (selection) => ref
                .read(selectedAdminSectionProvider.notifier)
                .select(selection.single),
          ),
        ),
        const InsetDivider(),
        Expanded(
          child: switch (section) {
            AdminSection.rooms => const RoomsSection(),
            AdminSection.priceCategories => const PriceCategoriesSection(),
            AdminSection.ageGroups => const AgeGroupsSection(),
            AdminSection.seasons => const SeasonsSection(),
            AdminSection.mealPlans => const MealPlansSection(),
            AdminSection.rates => const RatesSection(),
            AdminSection.fees => const FeesSection(),
            AdminSection.bookingCategories => const BookingCategoriesSection(),
            AdminSection.operator => const OperatorSection(),
            AdminSection.users => const UsersSection(),
          },
        ),
      ],
    );
  }
}
