import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/panels/admin/admin_widgets.dart';
import 'package:logbuch_flutter/providers/age_groups_provider.dart';
import 'package:logbuch_flutter/providers/client_provider.dart';
import 'package:yaru/yaru.dart';

extension AgeGroupX on AgeGroup {
  /// The ages of the group in words, like "3 to 11 years".
  String rangeLabel(BuildContext context) {
    final t = context.t.admin.ageGroups;
    final maxAge = this.maxAge;
    if (maxAge == null) return t.openRange(min: minAge);
    if (maxAge == minAge) return t.singleAge(n: minAge);
    return t.range(min: minAge, max: maxAge);
  }
}

class AgeGroupsSection extends ConsumerWidget {
  const AgeGroupsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.admin.ageGroups;

    return AdminListSection<AgeGroup>(
      value: ref.watch(ageGroupsProvider),
      onRetry: () => ref.refresh(ageGroupsProvider.future),
      emptyText: t.empty,
      addLabel: t.add,
      onAdd: () => _edit(context, ref),
      itemBuilder: (context, group) => AdminTile(
        icon: YaruIcons.users,
        title: group.name,
        subtitle: group.rangeLabel(context),
        onEdit: () => _edit(context, ref, group),
        onDelete: () async {
          final deleted = await confirmAndDelete(
            context,
            name: group.name,
            hint: t.deleteHint,
            delete: () =>
                ref.read(serverpodClientProvider).ageGroup.delete(group.id!),
          );
          if (deleted) ref.invalidate(ageGroupsProvider);
        },
      ),
    );
  }

  Future<void> _edit(
    BuildContext context,
    WidgetRef ref, [
    AgeGroup? group,
  ]) async {
    if (await showAdminDialog(context, _AgeGroupDialog(group: group))) {
      ref.invalidate(ageGroupsProvider);
    }
  }
}

class _AgeGroupDialog extends ConsumerStatefulWidget {
  const _AgeGroupDialog({this.group});

  /// The age group to edit, or null to create one.
  final AgeGroup? group;

  @override
  ConsumerState<_AgeGroupDialog> createState() => _AgeGroupDialogState();
}

class _AgeGroupDialogState extends ConsumerState<_AgeGroupDialog> {
  AgeGroup? get _group => widget.group;

  late final _name = TextEditingController(text: _group?.name);
  late final _minAge = TextEditingController(text: _group?.minAge.toString());
  late final _maxAge = TextEditingController(text: _group?.maxAge?.toString());

  @override
  void dispose() {
    _name.dispose();
    _minAge.dispose();
    _maxAge.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.admin.ageGroups;

    return AdminFormDialog(
      title: _group == null ? t.add : t.edit,
      onSave: _save,
      children: [
        RequiredTextField(
          controller: _name,
          label: context.t.common.name,
          autofocus: true,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: IntField(controller: _minAge, label: t.minAge),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: IntField(
                controller: _maxAge,
                label: t.maxAge,
                optional: true,
                helperText: t.maxAgeHint,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _save() async {
    final endpoint = ref.read(serverpodClientProvider).ageGroup;
    final group = AgeGroup(
      id: _group?.id,
      name: _name.text.trim(),
      minAge: int.parse(_minAge.text.trim()),
      maxAge: int.tryParse(_maxAge.text.trim()),
    );
    await (group.id == null ? endpoint.add(group) : endpoint.update(group));
  }
}
