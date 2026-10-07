import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/panels/admin/admin_formats.dart';
import 'package:logbuch_flutter/panels/admin/admin_widgets.dart';
import 'package:logbuch_flutter/panels/bookings/booking_card.dart';
import 'package:logbuch_flutter/panels/contacts/contacts_section.dart';
import 'package:logbuch_flutter/panels/contacts/households_section.dart';
import 'package:logbuch_flutter/providers/age_groups_provider.dart';
import 'package:logbuch_flutter/providers/client_provider.dart';
import 'package:logbuch_flutter/providers/contacts_provider.dart';
import 'package:logbuch_flutter/providers/current_user_provider.dart';
import 'package:logbuch_flutter/providers/guest_groups_provider.dart';
import 'package:logbuch_flutter/providers/households_provider.dart';
import 'package:logbuch_flutter/providers/status_provider.dart';
import 'package:yaru/yaru.dart';

extension GuestX on Guest {
  String get name => contact?.fullName ?? '';

  /// Whether neither a birth date nor an age group says how old the guest
  /// is, so that the guest cannot be priced.
  bool get ageUnknown =>
      ageGroupOverrideId == null && contact?.birthDate == null;
}

/// What is known about the age of [guest].
String _age(BuildContext context, Guest guest, List<AgeGroup> ageGroups) {
  final override = ageGroups
      .where((group) => group.id == guest.ageGroupOverrideId)
      .firstOrNull;
  if (override != null) return override.name;
  if (guest.contact?.birthDate case final birthDate?) {
    return formatDate(context, birthDate);
  }
  return context.t.bookings.ageUnknown;
}

/// What is said about [guest] next to the name: the age, a crib, dietary
/// needs, and the days of arrival and departure if they are not those of
/// the booking.
String _guestDetails(
  BuildContext context,
  Guest guest,
  List<AgeGroup> ageGroups,
) {
  final t = context.t.bookings;
  return [
    _age(context, guest, ageGroups),
    if (guest.needsCrib) t.crib,
    ?guest.dietaryNotes,
    if (guest.arrivalOverride case final arrival?)
      '${t.arrivalOverride} ${formatDate(context, arrival)}',
    if (guest.departureOverride case final departure?)
      '${t.departureOverride} ${formatDate(context, departure)}',
  ].join(' · ');
}

/// The guests of a booking in their groups, such as families.
class BookingGuestsCard extends ConsumerWidget {
  const BookingGuestsCard({super.key, required this.bookingId});

  final int bookingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.bookings;
    final theme = Theme.of(context);
    final ageGroups = ref.watch(ageGroupsProvider).value ?? [];

    return BookingCard(
      title: t.guests,
      onEdit: ref.watch(canEditProvider)
          ? () => showBookingOverlay(
              context,
              ref,
              bookingId: bookingId,
              overlay: BookingGuestsEditor(bookingId: bookingId),
            )
          : null,
      child: switch (ref.watch(guestGroupsProvider(bookingId))) {
        AsyncError(:final error) => CardNote(
          context.t.common.loadFailed(error: error),
        ),
        AsyncValue(value: final groups?) =>
          groups.isEmpty
              ? CardNote(t.noGroups)
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (final (index, group) in groups.indexed) ...[
                      if (index > 0) const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(
                          '${group.name} · '
                          '${t.guestCount(n: group.guests?.length ?? 0)}',
                          style: theme.textTheme.titleSmall,
                        ),
                      ),
                      for (final guest in group.guests ?? <Guest>[])
                        CardRow(
                          label: guest.name,
                          detail: _guestDetails(context, guest, ageGroups),
                          // Without an age the guest cannot be priced.
                          warn: guest.ageUnknown,
                        ),
                    ],
                  ],
                ),
        _ => const CardLoading(),
      },
    );
  }
}

/// The overlay in which the guests of a booking and their groups are added,
/// changed and removed. Every change is saved at once.
class BookingGuestsEditor extends ConsumerWidget {
  const BookingGuestsEditor({super.key, required this.bookingId});

  final int bookingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.bookings;
    final ageGroups = ref.watch(ageGroupsProvider).value ?? [];

    void refresh() => ref.invalidate(guestGroupsProvider(bookingId));

    return BookingOverlay(
      title: t.guests,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Wrap(
            alignment: WrapAlignment.end,
            spacing: 8,
            runSpacing: 8,
            children: [
              OutlinedButton(
                onPressed: () => _addHousehold(context, ref),
                child: Text(t.addHousehold),
              ),
              ElevatedButton.icon(
                icon: const Icon(YaruIcons.plus),
                label: Text(t.addGroup),
                onPressed: () async {
                  final dialog = _GroupDialog(bookingId: bookingId);
                  if (await showAdminDialog(context, dialog)) refresh();
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: switch (ref.watch(guestGroupsProvider(bookingId))) {
              AsyncError(:final error) => Center(
                child: Text(context.t.common.loadFailed(error: error)),
              ),
              AsyncValue(value: final groups?) =>
                groups.isEmpty
                    ? Center(
                        child: Text(t.noGroups, textAlign: TextAlign.center),
                      )
                    : ListView(
                        children: [
                          for (final group in groups)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: _GroupSection(
                                group: group,
                                ageGroups: ageGroups,
                                onChanged: refresh,
                              ),
                            ),
                        ],
                      ),
              _ => const Center(child: CircularProgressIndicator()),
            },
          ),
        ],
      ),
    );
  }

  /// Adds the members of a household the user picks as a new group.
  Future<void> _addHousehold(BuildContext context, WidgetRef ref) async {
    final household = await showDialog<Household>(
      context: context,
      builder: (context) => const _HouseholdChooser(),
    );
    if (household == null) return;
    try {
      await ref
          .read(serverpodClientProvider)
          .guest
          .addHousehold(bookingId, household.id!);
      ref.read(statusProvider.notifier).saved();
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              validationMessage(context, error) ??
                  context.t.common.saveFailed(error: error),
            ),
          ),
        );
      }
    }
    ref.invalidate(guestGroupsProvider(bookingId));
  }
}

/// Lets the user pick one of the households to add to a booking.
class _HouseholdChooser extends ConsumerWidget {
  const _HouseholdChooser();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;

    return SimpleDialog(
      title: Text(t.bookings.addHousehold),
      children: switch (ref.watch(householdsProvider)) {
        AsyncError(:final error) => [
          _padded(Text(t.common.loadFailed(error: error))),
        ],
        AsyncValue(value: final households?) when households.isEmpty => [
          _padded(Text(t.bookings.noHouseholdsYet)),
        ],
        AsyncValue(value: final households?) => [
          for (final household in households)
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, household),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(household.name),
                  Text(
                    household.memberNames ?? t.contacts.noMembers,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
        ],
        _ => [const Center(child: CircularProgressIndicator())],
      },
    );
  }

  Widget _padded(Widget child) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
    child: child,
  );
}

/// A group with its guests and the buttons to change both.
class _GroupSection extends ConsumerWidget {
  const _GroupSection({
    required this.group,
    required this.ageGroups,
    required this.onChanged,
  });

  final GuestGroup group;
  final List<AgeGroup> ageGroups;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.bookings;
    final guests = group.guests ?? [];
    final endpoint = ref.read(serverpodClientProvider).guest;

    Future<void> edit(Widget dialog) async {
      if (await showAdminDialog(context, dialog)) onChanged();
    }

    return YaruSection(
      headline: Row(
        children: [
          Expanded(
            child: Text(
              '${group.name} · ${t.guestCount(n: guests.length)}',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            tooltip: t.addGuest,
            icon: const Icon(YaruIcons.plus),
            onPressed: () => edit(_GuestDialog(groupId: group.id!)),
          ),
          IconButton(
            tooltip: t.editGroup,
            icon: const Icon(YaruIcons.pen),
            onPressed: () =>
                edit(_GroupDialog(bookingId: group.bookingId, group: group)),
          ),
          IconButton(
            tooltip: context.t.common.delete,
            icon: const Icon(YaruIcons.trash),
            onPressed: () async {
              final deleted = await confirmAndDelete(
                context,
                name: group.name,
                hint: t.deleteGroupHint,
                delete: () => endpoint.deleteGroup(group.id!),
              );
              if (deleted) onChanged();
            },
          ),
        ],
      ),
      child: Column(
        children: [
          for (final guest in guests)
            AdminTile(
              icon: guest.needsCrib ? Icons.crib : YaruIcons.user,
              title: guest.name,
              subtitle: _guestDetails(context, guest, ageGroups),
              onEdit: () =>
                  edit(_GuestDialog(groupId: group.id!, guest: guest)),
              onDelete: () async {
                final deleted = await confirmAndDelete(
                  context,
                  name: guest.name,
                  hint: t.removeGuestHint,
                  delete: () => endpoint.deleteGuest(guest.id!),
                );
                if (deleted) onChanged();
              },
            ),
        ],
      ),
    );
  }
}

class _GroupDialog extends ConsumerStatefulWidget {
  const _GroupDialog({required this.bookingId, this.group});

  final int bookingId;

  /// The group to edit, or null to create one.
  final GuestGroup? group;

  @override
  ConsumerState<_GroupDialog> createState() => _GroupDialogState();
}

class _GroupDialogState extends ConsumerState<_GroupDialog> {
  late final _name = TextEditingController(text: widget.group?.name);
  late int? _payerId = widget.group?.payerId;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.bookings;
    final contacts = ref.watch(contactsProvider).value ?? [];

    return AdminFormDialog(
      title: widget.group == null ? t.addGroup : t.editGroup,
      onSave: _save,
      children: [
        RequiredTextField(
          controller: _name,
          label: context.t.common.name,
          autofocus: true,
        ),
        // "None" is the null entry.
        DropdownButtonFormField<int?>(
          isExpanded: true,
          initialValue: contacts.any((c) => c.id == _payerId) ? _payerId : null,
          decoration: InputDecoration(labelText: t.payer),
          items: [
            DropdownMenuItem(value: null, child: Text(context.t.common.none)),
            for (final contact in contacts)
              DropdownMenuItem(
                value: contact.id,
                child: Text(contact.fullName),
              ),
          ],
          onChanged: (id) => setState(() => _payerId = id),
        ),
      ],
    );
  }

  Future<void> _save() async {
    final endpoint = ref.read(serverpodClientProvider).guest;
    final group = GuestGroup(
      id: widget.group?.id,
      bookingId: widget.bookingId,
      name: _name.text.trim(),
      payerId: _payerId,
      sortOrder: widget.group?.sortOrder,
    );
    await (group.id == null
        ? endpoint.addGroup(group)
        : endpoint.updateGroup(group));
  }
}

class _GuestDialog extends ConsumerStatefulWidget {
  const _GuestDialog({required this.groupId, this.guest});

  final int groupId;

  /// The guest to edit, or null to add one.
  final Guest? guest;

  @override
  ConsumerState<_GuestDialog> createState() => _GuestDialogState();
}

class _GuestDialogState extends ConsumerState<_GuestDialog> {
  Guest? get _guest => widget.guest;

  /// Whether the guest to add is created as a contact along the way.
  bool _newContact = false;
  Contact? _contact;
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  DateTime? _birthDate;

  late bool _needsCrib = _guest?.needsCrib ?? false;
  late int? _ageGroupId = _guest?.ageGroupOverrideId;
  late final _dietaryNotes = TextEditingController(text: _guest?.dietaryNotes);
  late DateTime? _arrival = _local(_guest?.arrivalOverride);
  late DateTime? _departure = _local(_guest?.departureOverride);

  static DateTime? _local(DateTime? date) =>
      date == null ? null : toLocalDate(date);

  static DateTime? _utc(DateTime? date) =>
      date == null ? null : toUtcDate(date);

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _dietaryNotes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.bookings;
    final ageGroups = ref.watch(ageGroupsProvider).value ?? [];

    return AdminFormDialog(
      title: _guest == null ? t.addGuest : t.editGuest,
      onSave: _save,
      children: [
        if (_guest case final guest?)
          InputDecorator(
            decoration: InputDecoration(labelText: t.contact),
            child: Text(guest.name),
          )
        else ...[
          SegmentedButton<bool>(
            segments: [
              ButtonSegment(value: false, label: Text(t.existingContact)),
              ButtonSegment(value: true, label: Text(t.newContact)),
            ],
            selected: {_newContact},
            showSelectedIcon: false,
            onSelectionChanged: (selection) =>
                setState(() => _newContact = selection.single),
          ),
          if (_newContact) ..._newContactFields(context) else _contactField(),
        ],
        // "By date of birth" is the null entry.
        DropdownButtonFormField<int?>(
          isExpanded: true,
          initialValue: ageGroups.any((g) => g.id == _ageGroupId)
              ? _ageGroupId
              : null,
          decoration: InputDecoration(labelText: t.ageGroup),
          items: [
            DropdownMenuItem(value: null, child: Text(t.ageByBirthDate)),
            for (final group in ageGroups)
              DropdownMenuItem(value: group.id, child: Text(group.name)),
          ],
          onChanged: (id) => setState(() => _ageGroupId = id),
        ),
        YaruSwitchListTile(
          title: Text(t.needsCrib),
          value: _needsCrib,
          onChanged: (value) => setState(() => _needsCrib = value),
        ),
        TextFormField(
          controller: _dietaryNotes,
          decoration: InputDecoration(labelText: t.dietaryNotes),
        ),
        DateField(
          label: t.arrivalOverride,
          date: _arrival,
          onChanged: (date) => setState(() => _arrival = date),
        ),
        DateField(
          label: t.departureOverride,
          date: _departure,
          onChanged: (date) => setState(() => _departure = date),
        ),
      ],
    );
  }

  Widget _contactField() {
    final t = context.t;
    final contacts = ref.watch(contactsProvider).value ?? [];

    return FormField<Contact>(
      validator: (_) => _contact == null ? t.common.required : null,
      builder: (field) => DropdownMenu<Contact>(
        label: Text(t.bookings.contact),
        errorText: field.errorText,
        expandedInsets: EdgeInsets.zero,
        enableFilter: true,
        requestFocusOnTap: true,
        onSelected: (contact) => setState(() => _contact = contact),
        dropdownMenuEntries: [
          for (final contact in contacts)
            DropdownMenuEntry(value: contact, label: contact.fullName),
        ],
      ),
    );
  }

  List<Widget> _newContactFields(BuildContext context) {
    final t = context.t.contacts;

    return [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextFormField(
              controller: _firstName,
              autofocus: true,
              decoration: InputDecoration(labelText: t.firstName),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: TextFormField(
              controller: _lastName,
              decoration: InputDecoration(labelText: t.lastName),
              validator: (_) =>
                  _firstName.text.trim().isEmpty &&
                      _lastName.text.trim().isEmpty
                  ? t.nameRequired
                  : null,
            ),
          ),
        ],
      ),
      DateField(
        label: t.birthDate,
        date: _birthDate,
        firstDate: DateTime(1900),
        onChanged: (date) => setState(() => _birthDate = date),
      ),
    ];
  }

  Future<void> _save() async {
    final endpoint = ref.read(serverpodClientProvider).guest;
    final existing = _guest;
    final guest = Guest(
      id: existing?.id,
      groupId: widget.groupId,
      // The server fills in the contact it creates for a new guest.
      contactId: existing?.contactId ?? _contact?.id ?? 0,
      bookingRoomId: existing?.bookingRoomId,
      needsCrib: _needsCrib,
      ageGroupOverrideId: _ageGroupId,
      arrivalOverride: _utc(_arrival),
      departureOverride: _utc(_departure),
      dietaryNotes: nullIfBlank(_dietaryNotes.text),
    );

    if (existing != null) {
      await endpoint.updateGuest(guest);
    } else if (_newContact) {
      await endpoint.addNewGuest(
        guest,
        Contact(
          firstName: _firstName.text.trim(),
          lastName: _lastName.text.trim(),
          birthDate: _utc(_birthDate),
        ),
      );
      ref.invalidate(contactsProvider);
    } else {
      await endpoint.addGuest(guest);
    }
  }
}
