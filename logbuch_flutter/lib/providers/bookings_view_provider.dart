import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bookings_view_provider.g.dart';

enum BookingsView { agenda, month, year }

/// The view currently shown in the bookings panel.
@Riverpod(keepAlive: true)
class SelectedBookingsView extends _$SelectedBookingsView {
  @override
  BookingsView build() => BookingsView.agenda;

  void select(BookingsView view) => state = view;
}

/// The month shown in the monthly calendar, as the first day of that month.
@Riverpod(keepAlive: true)
class DisplayedMonth extends _$DisplayedMonth {
  @override
  DateTime build() => _firstOfMonth(DateTime.now());

  void previous() => state = DateTime(state.year, state.month - 1);

  void next() => state = DateTime(state.year, state.month + 1);

  void today() => state = _firstOfMonth(DateTime.now());

  void show(DateTime month) => state = _firstOfMonth(month);

  static DateTime _firstOfMonth(DateTime date) =>
      DateTime(date.year, date.month);
}

/// The year shown in the yearly calendar.
@Riverpod(keepAlive: true)
class DisplayedYear extends _$DisplayedYear {
  @override
  int build() => DateTime.now().year;

  void previous() => state--;

  void next() => state++;

  void today() => state = DateTime.now().year;
}
