import 'package:flutter/material.dart';

class ContactsPanel extends StatelessWidget {
  const ContactsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Contact Panel',
        style: Theme.of(context).textTheme.displaySmall,
      ),
    );
  }
}
