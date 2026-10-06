import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/panels/admin/admin_widgets.dart';
import 'package:logbuch_flutter/panels/contacts/contacts_section.dart';
import 'package:logbuch_flutter/providers/client_provider.dart';
import 'package:logbuch_flutter/providers/contacts_provider.dart';
import 'package:logbuch_flutter/providers/households_provider.dart';
import 'package:yaru/yaru.dart';

extension HouseholdX on Household {
  /// The contacts in the household.
  List<Contact> get contacts => [
    for (final member in members ?? <HouseholdMember>[]) ?member.contact,
  ];

  /// The names of the members in one line, or null without members.
  String? get memberNames => contacts.isEmpty
      ? null
      : contacts.map((contact) => contact.fullName).join(', ');
}

/// Contacts who usually travel together, such as families. A household is
/// added to a booking as a guest group in one step.
class HouseholdsSection extends ConsumerWidget {
  const HouseholdsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.contacts;

    return AdminListSection<Household>(
      value: ref.watch(householdsProvider),
      onRetry: () => ref.refresh(householdsProvider.future),
      emptyText: t.noHouseholds,
      addLabel: t.addHousehold,
      onAdd: () => _edit(context, ref),
      itemBuilder: (context, household) => AdminTile(
        icon: YaruIcons.users,
        title: household.name,
        subtitle: household.memberNames ?? t.noMembers,
        onEdit: () => _edit(context, ref, household),
        onDelete: () async {
          final deleted = await confirmAndDelete(
            context,
            name: household.name,
            hint: t.deleteHouseholdHint,
            delete: () => ref
                .read(serverpodClientProvider)
                .household
                .delete(household.id!),
          );
          if (deleted) ref.invalidate(householdsProvider);
        },
      ),
    );
  }

  Future<void> _edit(
    BuildContext context,
    WidgetRef ref, [
    Household? household,
  ]) async {
    final dialog = _HouseholdDialog(household: household);
    if (await showAdminDialog(context, dialog)) {
      ref.invalidate(householdsProvider);
    }
  }
}

class _HouseholdDialog extends ConsumerStatefulWidget {
  const _HouseholdDialog({this.household});

  /// The household to edit, or null to create one.
  final Household? household;

  @override
  ConsumerState<_HouseholdDialog> createState() => _HouseholdDialogState();
}

class _HouseholdDialogState extends ConsumerState<_HouseholdDialog> {
  late final _name = TextEditingController(text: widget.household?.name);
  late List<Contact> _members = widget.household?.contacts ?? [];

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.contacts;
    final contacts = ref.watch(contactsProvider).value ?? [];
    final memberIds = {for (final member in _members) member.id};

    return AdminFormDialog(
      title: widget.household == null ? t.addHousehold : t.editHousehold,
      onSave: _save,
      children: [
        RequiredTextField(
          controller: _name,
          label: context.t.common.name,
          autofocus: true,
        ),
        DropdownMenu<Contact>(
          // A new field after every member, so that it is empty again.
          key: ValueKey(_members.length),
          label: Text(t.addMember),
          expandedInsets: EdgeInsets.zero,
          enableFilter: true,
          requestFocusOnTap: true,
          onSelected: (contact) {
            if (contact == null) return;
            setState(() => _members = [..._members, contact]);
          },
          dropdownMenuEntries: [
            for (final contact in contacts)
              if (!memberIds.contains(contact.id))
                DropdownMenuEntry(value: contact, label: contact.fullName),
          ],
        ),
        if (_members.isEmpty)
          Text(t.noMembers, style: Theme.of(context).textTheme.bodySmall)
        else
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              for (final member in _members)
                InputChip(
                  label: Text(member.fullName),
                  onDeleted: () => setState(
                    () => _members = [
                      for (final other in _members)
                        if (other.id != member.id) other,
                    ],
                  ),
                ),
            ],
          ),
      ],
    );
  }

  Future<void> _save() async {
    await ref.read(serverpodClientProvider).household.save(
      Household(id: widget.household?.id, name: _name.text.trim()),
      [for (final member in _members) member.id!],
    );
  }
}
