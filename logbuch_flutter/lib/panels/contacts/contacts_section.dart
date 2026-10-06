import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/panels/admin/admin_formats.dart';
import 'package:logbuch_flutter/panels/admin/admin_widgets.dart';
import 'package:logbuch_flutter/providers/client_provider.dart';
import 'package:logbuch_flutter/providers/contacts_provider.dart';
import 'package:logbuch_flutter/providers/current_user_provider.dart';
import 'package:logbuch_flutter/providers/organizations_provider.dart';
import 'package:yaru/yaru.dart';

extension ContactX on Contact {
  /// First and last name; one of them may be missing.
  String get fullName => '$firstName $lastName'.trim();

  /// Whether the contact matches the words of a search, in its names, its
  /// organization, its email address or its city.
  bool matches(String query) {
    final text = [
      firstName,
      lastName,
      ?organization?.name,
      ?mail,
      ?city,
    ].join(' ').toLowerCase();
    return query.toLowerCase().split(' ').every(text.contains);
  }
}

class ContactsSection extends ConsumerStatefulWidget {
  const ContactsSection({super.key});

  @override
  ConsumerState<ContactsSection> createState() => _ContactsSectionState();
}

class _ContactsSectionState extends ConsumerState<ContactsSection> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final t = context.t.contacts;
    final contacts = ref.watch(contactsProvider);
    final query = _query.trim();

    return AdminListSection<Contact>(
      value: contacts.whenData(
        (list) => [
          for (final contact in list)
            if (contact.matches(query)) contact,
        ],
      ),
      onRetry: () => ref.refresh(contactsProvider.future),
      emptyText: query.isEmpty ? t.empty : t.noMatches,
      addLabel: t.add,
      onAdd: () => _show(context),
      toolbar: Align(
        alignment: AlignmentDirectional.centerStart,
        child: SizedBox(
          width: 320,
          child: TextField(
            decoration: InputDecoration(
              hintText: t.searchHint,
              prefixIcon: const Icon(YaruIcons.search),
              isDense: true,
            ),
            onChanged: (value) => setState(() => _query = value),
          ),
        ),
      ),
      itemBuilder: (context, contact) => AdminTile(
        icon: YaruIcons.user,
        title: contact.fullName,
        subtitle: [
          ?contact.organization?.name,
          ?contact.mail,
          ?contact.phone,
          ?contact.city,
        ].join(' · '),
        onOpen: () => _show(context, contact: contact),
        onEdit: () => _show(context, contact: contact, editing: true),
        onDelete: () async {
          final deleted = await confirmAndDelete(
            context,
            name: contact.fullName,
            delete: () =>
                ref.read(serverpodClientProvider).contact.delete(contact.id!),
          );
          if (deleted) ref.invalidate(contactsProvider);
        },
      ),
    );
  }

  /// Shows the details of the contact, ready to be edited if [editing], or
  /// the empty form for a new contact.
  Future<void> _show(
    BuildContext context, {
    Contact? contact,
    bool editing = false,
  }) async {
    final dialog = _ContactDialog(contact: contact, editing: editing);
    if (await showAdminDialog(context, dialog)) {
      ref.invalidate(contactsProvider);
    }
  }
}

/// The details of a contact. They are only shown at first; those who may
/// change data can switch to editing them. A new contact starts out editable.
class _ContactDialog extends ConsumerStatefulWidget {
  const _ContactDialog({this.contact, this.editing = false});

  /// The contact to show, or null to create one.
  final Contact? contact;

  /// Whether the fields can be edited right away.
  final bool editing;

  @override
  ConsumerState<_ContactDialog> createState() => _ContactDialogState();
}

class _ContactDialogState extends ConsumerState<_ContactDialog> {
  Contact? get _contact => widget.contact;

  late bool _editing = widget.editing || _contact == null;
  late final _firstName = TextEditingController(text: _contact?.firstName);
  late final _lastName = TextEditingController(text: _contact?.lastName);
  late final _mail = TextEditingController(text: _contact?.mail);
  late final _phone = TextEditingController(text: _contact?.phone);
  late final _street = TextEditingController(text: _contact?.street);
  late final _zip = TextEditingController(text: _contact?.zip);
  late final _city = TextEditingController(text: _contact?.city);
  late final _country = TextEditingController(text: _contact?.country);
  late final _notes = TextEditingController(text: _contact?.notes);
  late DateTime? _birthDate = switch (_contact?.birthDate) {
    final birthDate? => toLocalDate(birthDate),
    null => null,
  };
  late int? _organizationId = _contact?.organizationId;
  late DateTime? _privacyConsentAt = _contact?.privacyConsentAt;

  @override
  void dispose() {
    for (final controller in [
      _firstName,
      _lastName,
      _mail,
      _phone,
      _street,
      _zip,
      _city,
      _country,
      _notes,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  /// Returns to the details of [contact] as they are stored, dropping
  /// what was entered.
  void _stopEditing(Contact contact) {
    setState(() {
      _editing = false;
      _firstName.text = contact.firstName;
      _lastName.text = contact.lastName;
      _mail.text = contact.mail ?? '';
      _phone.text = contact.phone ?? '';
      _street.text = contact.street ?? '';
      _zip.text = contact.zip ?? '';
      _city.text = contact.city ?? '';
      _country.text = contact.country ?? '';
      _notes.text = contact.notes ?? '';
      _birthDate = switch (contact.birthDate) {
        final birthDate? => toLocalDate(birthDate),
        null => null,
      };
      _organizationId = contact.organizationId;
      _privacyConsentAt = contact.privacyConsentAt;
    });
  }

  /// A text field; [copyable] gives it a button that copies its value.
  Widget _text(
    TextEditingController controller,
    String label, {
    bool copyable = false,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: !_editing,
      canRequestFocus: _editing,
      mouseCursor: _editing ? null : SystemMouseCursors.basic,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: copyable ? CopyButton(controller: controller) : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.contacts;
    final organizations = ref.watch(organizationsProvider).value ?? [];
    final contact = _contact;

    return AdminFormDialog(
      title: contact == null
          ? t.add
          : _editing
          ? t.edit
          : contact.fullName,
      readOnly: !_editing,
      onEdit: ref.watch(canEditProvider)
          ? () => setState(() => _editing = true)
          : null,
      // A new contact has no details to return to.
      onCancel: contact == null ? null : () => _stopEditing(contact),
      onSave: _save,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextFormField(
                controller: _firstName,
                readOnly: !_editing,
                canRequestFocus: _editing,
                mouseCursor: _editing ? null : SystemMouseCursors.basic,
                autofocus: _editing,
                decoration: InputDecoration(labelText: t.firstName),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                controller: _lastName,
                readOnly: !_editing,
                canRequestFocus: _editing,
                mouseCursor: _editing ? null : SystemMouseCursors.basic,
                decoration: InputDecoration(labelText: t.lastName),
                // Guests of large groups are often only known by one name.
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
          readOnly: !_editing,
          onChanged: (date) => setState(() => _birthDate = date),
        ),
        _text(_mail, t.email, copyable: true),
        _text(_phone, t.phone, copyable: true),
        _text(_street, t.street),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 130, child: _text(_zip, t.zip)),
            const SizedBox(width: 16),
            Expanded(child: _text(_city, t.city)),
          ],
        ),
        _text(_country, t.country),
        // "None" is the null entry.
        DropdownButtonFormField<int?>(
          isExpanded: true,
          initialValue: organizations.any((o) => o.id == _organizationId)
              ? _organizationId
              : null,
          decoration: InputDecoration(labelText: t.organization),
          items: [
            DropdownMenuItem(value: null, child: Text(context.t.common.none)),
            for (final organization in organizations)
              DropdownMenuItem(
                value: organization.id,
                child: Text(organization.name),
              ),
          ],
          onChanged: _editing
              ? (id) => setState(() => _organizationId = id)
              : null,
        ),
        TextFormField(
          controller: _notes,
          readOnly: !_editing,
          canRequestFocus: _editing,
          mouseCursor: _editing ? null : SystemMouseCursors.basic,
          minLines: 2,
          maxLines: 4,
          decoration: InputDecoration(labelText: t.notes),
        ),
        YaruSwitchListTile(
          title: Text(t.privacyConsent),
          value: _privacyConsentAt != null,
          // Keeps the time of a consent that was given before.
          onChanged: _editing
              ? (given) => setState(
                  () => _privacyConsentAt = given
                      ? _contact?.privacyConsentAt ?? DateTime.now()
                      : null,
                )
              : null,
        ),
      ],
    );
  }

  Future<void> _save() async {
    final endpoint = ref.read(serverpodClientProvider).contact;
    final contact = Contact(
      id: _contact?.id,
      createdAt: _contact?.createdAt,
      firstName: _firstName.text.trim(),
      lastName: _lastName.text.trim(),
      mail: nullIfBlank(_mail.text),
      phone: nullIfBlank(_phone.text),
      birthDate: switch (_birthDate) {
        final birthDate? => toUtcDate(birthDate),
        null => null,
      },
      street: nullIfBlank(_street.text),
      zip: nullIfBlank(_zip.text),
      city: nullIfBlank(_city.text),
      country: nullIfBlank(_country.text),
      organizationId: _organizationId,
      notes: nullIfBlank(_notes.text),
      privacyConsentAt: _privacyConsentAt,
    );
    await (contact.id == null
        ? endpoint.add(contact)
        : endpoint.update(contact));
  }
}
