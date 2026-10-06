import 'package:flutter/material.dart';
import 'package:logbuch_flutter/components/inset_divider.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/panels/contacts/contacts_section.dart';
import 'package:logbuch_flutter/panels/contacts/organizations_section.dart';
import 'package:yaru/yaru.dart';

/// The people known to the house and the organizations they belong to.
class ContactsPanel extends StatefulWidget {
  const ContactsPanel({super.key});

  @override
  State<ContactsPanel> createState() => _ContactsPanelState();
}

class _ContactsPanelState extends State<ContactsPanel> {
  bool _organizations = false;

  @override
  Widget build(BuildContext context) {
    final t = context.t.contacts;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: SegmentedButton<bool>(
              segments: [
                ButtonSegment(
                  value: false,
                  label: Text(t.people),
                  icon: const Icon(YaruIcons.user),
                ),
                ButtonSegment(
                  value: true,
                  label: Text(t.organizations),
                  icon: const Icon(Icons.apartment),
                ),
              ],
              selected: {_organizations},
              showSelectedIcon: false,
              onSelectionChanged: (selection) =>
                  setState(() => _organizations = selection.single),
            ),
          ),
        ),
        const InsetDivider(),
        Expanded(
          child: _organizations
              ? const OrganizationsSection()
              : const ContactsSection(),
        ),
      ],
    );
  }
}
