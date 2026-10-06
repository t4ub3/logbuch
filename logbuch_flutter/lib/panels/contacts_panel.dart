import 'package:flutter/material.dart';
import 'package:logbuch_flutter/components/inset_divider.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/panels/contacts/contacts_section.dart';
import 'package:logbuch_flutter/panels/contacts/households_section.dart';
import 'package:logbuch_flutter/panels/contacts/organizations_section.dart';
import 'package:yaru/yaru.dart';

enum _ContactsView { people, organizations, households }

/// The people known to the house, the organizations they belong to and the
/// households they travel in.
class ContactsPanel extends StatefulWidget {
  const ContactsPanel({super.key});

  @override
  State<ContactsPanel> createState() => _ContactsPanelState();
}

class _ContactsPanelState extends State<ContactsPanel> {
  _ContactsView _view = _ContactsView.people;

  @override
  Widget build(BuildContext context) {
    final t = context.t.contacts;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // The views do not fit next to each other in a narrow window.
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(8),
          child: SegmentedButton<_ContactsView>(
            segments: [
              ButtonSegment(
                value: _ContactsView.people,
                label: Text(t.people),
                icon: const Icon(YaruIcons.user),
              ),
              ButtonSegment(
                value: _ContactsView.organizations,
                label: Text(t.organizations),
                icon: const Icon(Icons.apartment),
              ),
              ButtonSegment(
                value: _ContactsView.households,
                label: Text(t.households),
                icon: const Icon(YaruIcons.users),
              ),
            ],
            selected: {_view},
            showSelectedIcon: false,
            onSelectionChanged: (selection) =>
                setState(() => _view = selection.single),
          ),
        ),
        const InsetDivider(),
        Expanded(
          child: switch (_view) {
            _ContactsView.people => const ContactsSection(),
            _ContactsView.organizations => const OrganizationsSection(),
            _ContactsView.households => const HouseholdsSection(),
          },
        ),
      ],
    );
  }
}
