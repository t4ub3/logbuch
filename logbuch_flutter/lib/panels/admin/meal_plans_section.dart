import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/panels/admin/admin_widgets.dart';
import 'package:logbuch_flutter/providers/client_provider.dart';
import 'package:logbuch_flutter/providers/meal_plans_provider.dart';

class MealPlansSection extends ConsumerWidget {
  const MealPlansSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.admin.mealPlans;

    return AdminListSection<MealPlan>(
      value: ref.watch(mealPlansProvider),
      onRetry: () => ref.refresh(mealPlansProvider.future),
      emptyText: t.empty,
      addLabel: t.add,
      onAdd: () => _edit(context, ref),
      itemBuilder: (context, plan) => AdminTile(
        icon: Icons.restaurant,
        title: plan.name,
        onEdit: () => _edit(context, ref, plan),
        onDelete: () async {
          final deleted = await confirmAndDelete(
            context,
            name: plan.name,
            hint: t.deleteHint,
            delete: () =>
                ref.read(serverpodClientProvider).mealPlan.delete(plan.id!),
          );
          if (deleted) ref.invalidate(mealPlansProvider);
        },
      ),
    );
  }

  Future<void> _edit(
    BuildContext context,
    WidgetRef ref, [
    MealPlan? plan,
  ]) async {
    if (await showAdminDialog(context, _MealPlanDialog(plan: plan))) {
      ref.invalidate(mealPlansProvider);
    }
  }
}

class _MealPlanDialog extends ConsumerStatefulWidget {
  const _MealPlanDialog({this.plan});

  /// The meal plan to edit, or null to create one.
  final MealPlan? plan;

  @override
  ConsumerState<_MealPlanDialog> createState() => _MealPlanDialogState();
}

class _MealPlanDialogState extends ConsumerState<_MealPlanDialog> {
  late final _name = TextEditingController(text: widget.plan?.name);

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.admin.mealPlans;

    return AdminFormDialog(
      title: widget.plan == null ? t.add : t.edit,
      onSave: _save,
      children: [
        RequiredTextField(
          controller: _name,
          label: context.t.common.name,
          autofocus: true,
        ),
      ],
    );
  }

  Future<void> _save() async {
    final endpoint = ref.read(serverpodClientProvider).mealPlan;
    final plan = MealPlan(id: widget.plan?.id, name: _name.text.trim());
    await (plan.id == null ? endpoint.add(plan) : endpoint.update(plan));
  }
}
