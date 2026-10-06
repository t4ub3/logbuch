import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/panels/admin/admin_formats.dart';
import 'package:logbuch_flutter/panels/admin/admin_widgets.dart';
import 'package:logbuch_flutter/providers/client_provider.dart';
import 'package:logbuch_flutter/providers/contacts_provider.dart';
import 'package:logbuch_flutter/providers/organizations_provider.dart';

/// Schools, parishes, clubs and others that book repeatedly.
class OrganizationsSection extends ConsumerWidget {
  const OrganizationsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.contacts;

    return AdminListSection<Organization>(
      value: ref.watch(organizationsProvider),
      onRetry: () => ref.refresh(organizationsProvider.future),
      emptyText: t.noOrganizations,
      addLabel: t.addOrganization,
      onAdd: () => _edit(context, ref),
      itemBuilder: (context, organization) => AdminTile(
        icon: Icons.apartment,
        title: organization.name,
        subtitle: [
          ?organization.street,
          [?organization.zip, ?organization.city].join(' '),
          ?organization.country,
        ].where((part) => part.isNotEmpty).join(' · '),
        onEdit: () => _edit(context, ref, organization),
        onDelete: () async {
          final deleted = await confirmAndDelete(
            context,
            name: organization.name,
            hint: t.deleteOrganizationHint,
            delete: () => ref
                .read(serverpodClientProvider)
                .organization
                .delete(organization.id!),
          );
          if (deleted) _refresh(ref);
        },
      ),
    );
  }

  Future<void> _edit(
    BuildContext context,
    WidgetRef ref, [
    Organization? organization,
  ]) async {
    final dialog = _OrganizationDialog(organization: organization);
    if (await showAdminDialog(context, dialog)) _refresh(ref);
  }

  /// Contacts carry the name of their organization.
  void _refresh(WidgetRef ref) {
    ref.invalidate(organizationsProvider);
    ref.invalidate(contactsProvider);
  }
}

class _OrganizationDialog extends ConsumerStatefulWidget {
  const _OrganizationDialog({this.organization});

  /// The organization to edit, or null to create one.
  final Organization? organization;

  @override
  ConsumerState<_OrganizationDialog> createState() =>
      _OrganizationDialogState();
}

class _OrganizationDialogState extends ConsumerState<_OrganizationDialog> {
  Organization? get _organization => widget.organization;

  late final _name = TextEditingController(text: _organization?.name);
  late final _street = TextEditingController(text: _organization?.street);
  late final _zip = TextEditingController(text: _organization?.zip);
  late final _city = TextEditingController(text: _organization?.city);
  late final _country = TextEditingController(text: _organization?.country);

  @override
  void dispose() {
    for (final controller in [_name, _street, _zip, _city, _country]) {
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

    return AdminFormDialog(
      title: _organization == null ? t.addOrganization : t.editOrganization,
      onSave: _save,
      children: [
        RequiredTextField(
          controller: _name,
          label: context.t.common.name,
          autofocus: true,
        ),
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
      ],
    );
  }

  Future<void> _save() async {
    final endpoint = ref.read(serverpodClientProvider).organization;
    final organization = Organization(
      id: _organization?.id,
      name: _name.text.trim(),
      street: nullIfBlank(_street.text),
      zip: nullIfBlank(_zip.text),
      city: nullIfBlank(_city.text),
      country: nullIfBlank(_country.text),
    );
    await (organization.id == null
        ? endpoint.add(organization)
        : endpoint.update(organization));
  }
}
