import 'package:flutter/material.dart';

class BookingsPanel extends StatelessWidget {
  const BookingsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Booking Panel',
        style: Theme.of(context).textTheme.displaySmall,
      ),
    );
  }
}
