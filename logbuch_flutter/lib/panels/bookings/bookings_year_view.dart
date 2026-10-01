import 'package:flutter/material.dart';

class BookingsYearView extends StatelessWidget {
  const BookingsYearView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Yearly view',
        style: Theme.of(context).textTheme.displaySmall,
      ),
    );
  }
}
