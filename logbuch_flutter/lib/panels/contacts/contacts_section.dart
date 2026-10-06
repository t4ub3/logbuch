import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/panels/admin/admin_formats.dart';
import 'package:logbuch_flutter/panels/admin/admin_widgets.dart';
import 'package:logbuch_flutter/providers/client_provider.dart';
import 'package:logbuch_flutter/providers/contacts_provider.dart';
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
      onAdd: () => _edit(context),
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
        onEdit: () => _edit(context, contact),
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

  Future<void> _edit(BuildContext context, [Contact? contact]) async {
    if (await showAdminDialog(context, _ContactDialog(contact: contact))) {
      ref.invalidate(contactsProvider);
    }
  }
}

class _ContactDialog extends ConsumerStatefulWidget {
  const _ContactDialog({this.contact});

  /// The contact to edit, or null to create one.
  final Contact? contact;

  @override
  ConsumerState<_ContactDialog> createState() => _ContactDialogState();
}

class _ContactDialogState extends ConsumerState<_ContactDialog> {
  Contact? get _contact => widget.contact;

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

  Widget _text(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.contacts;
    final organizations = ref.watch(organizationsProvider).value ?? [];

    return AdminFormDialog(
      title: _contact == null ? t.add : t.edit,
      onSave: _save,
      children: [
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
          onChanged: (date) => setState(() => _birthDate = date),
        ),
        _text(_mail, t.email),
        _text(_phone, t.phone),
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
          onChanged: (id) => setState(() => _organizationId = id),
        ),
        TextFormField(
          controller: _notes,
          minLines: 2,
          maxLines: 4,
          decoration: InputDecoration(labelText: t.notes),
        ),
        YaruSwitchListTile(
          title: Text(t.privacyConsent),
          value: _privacyConsentAt != null,
          // Keeps the time of a consent that was given before.
          onChanged: (given) => setState(
            () => _privacyConsentAt = given
                ? _contact?.privacyConsentAt ?? DateTime.now()
                : null,
          ),
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
