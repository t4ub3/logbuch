import 'package:flutter/material.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';

class BookingsYearView extends StatelessWidget {
  const BookingsYearView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        context.t.bookings.yearlyView,
        style: Theme.of(context).textTheme.displaySmall,
      ),
    );
  }
}
