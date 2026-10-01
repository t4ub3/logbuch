import 'package:flutter/material.dart';

class RoomsPanel extends StatelessWidget {
  const RoomsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Rooms Panel',
        style: Theme.of(context).textTheme.displaySmall,
      ),
    );
  }
}
