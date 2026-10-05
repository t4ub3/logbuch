import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tabs_provider.g.dart';

/// A tab of the main screen. Tabs are immutable; an updated tab keeps the
/// [key] of the tab it replaces, which also keeps its widget state.
sealed class AppTab {
  AppTab({Key? key}) : key = key ?? UniqueKey();

  final Key key;
}

/// The always open tab with the menu and its panels.
class HomeTab extends AppTab {}

/// Shows [booking], or creates a new one if null.
class BookingTab extends AppTab {
  BookingTab({this.booking, bool? editing, super.key})
    : editing = editing ?? booking == null;

  final Booking? booking;

  /// Whether the booking form is shown instead of the details. New bookings
  /// always start in the form.
  final bool editing;

  BookingTab copyWith({Booking? booking, bool? editing}) => BookingTab(
    booking: booking ?? this.booking,
    editing: editing ?? this.editing,
    key: key,
  );
}

class OpenTabs {
  const OpenTabs({required this.tabs, required this.selected});

  /// The open tabs; the first one is always the [HomeTab].
  final List<AppTab> tabs;
  final int selected;
}

@Riverpod(keepAlive: true)
class Tabs extends _$Tabs {
  @override
  OpenTabs build() => OpenTabs(tabs: [HomeTab()], selected: 0);

  void select(int index) => state = OpenTabs(tabs: state.tabs, selected: index);

  /// Opens a tab to create a new booking, or to edit [booking]. A booking
  /// that is already open in a tab is not opened twice.
  void openBooking([Booking? booking]) {
    if (booking?.id case final id?) {
      final index = state.tabs.indexWhere(
        (tab) => tab is BookingTab && tab.booking?.id == id,
      );
      if (index != -1) return select(index);
    }
    state = OpenTabs(
      tabs: [
        ...state.tabs,
        BookingTab(booking: booking),
      ],
      selected: state.tabs.length,
    );
  }

  /// Replaces the tab with the same key as [tab].
  void update(AppTab tab) {
    final index = _indexOf(tab);
    if (index == -1) return;
    state = OpenTabs(
      tabs: [...state.tabs]..[index] = tab,
      selected: state.selected,
    );
  }

  /// Closes [tab] and selects its left neighbor if it was selected. The
  /// home tab cannot be closed.
  void close(AppTab tab) {
    final index = _indexOf(tab);
    if (tab is HomeTab || index == -1) return;
    final selected = state.selected;
    state = OpenTabs(
      tabs: [...state.tabs]..removeAt(index),
      selected: index <= selected && selected > 0 ? selected - 1 : selected,
    );
  }

  int _indexOf(AppTab tab) => state.tabs.indexWhere((t) => t.key == tab.key);
}

/// Opens a booking tab from widgets without a [WidgetRef].
void openBookingTab(BuildContext context, [Booking? booking]) {
  ProviderScope.containerOf(
    context,
    listen: false,
  ).read(tabsProvider.notifier).openBooking(booking);
}
