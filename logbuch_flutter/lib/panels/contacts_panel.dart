import 'package:flutter/material.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/components/async_list_view.dart';
import 'package:logbuch_flutter/providers/contacts_provider.dart';
import 'package:yaru/yaru.dart';

class ContactsPanel extends ConsumerWidget {
  const ContactsPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncListView<Contact>(
      value: ref.watch(contactsProvider),
      onRetry: () => ref.refresh(contactsProvider.future),
      emptyText: context.t.contacts.empty,
      itemBuilder: (context, contact) => YaruListTile(
        leading: const Icon(Icons.person),
        titleText: '${contact.firstName} ${contact.lastName}',
        subtitleText: [contact.mail, contact.phone].nonNulls.join(' · '),
      ),
    );
  }
}
