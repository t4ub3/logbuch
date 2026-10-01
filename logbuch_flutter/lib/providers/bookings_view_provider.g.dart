// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookings_view_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The view currently shown in the bookings panel.

@ProviderFor(SelectedBookingsView)
final selectedBookingsViewProvider = SelectedBookingsViewProvider._();

/// The view currently shown in the bookings panel.
final class SelectedBookingsViewProvider
    extends $NotifierProvider<SelectedBookingsView, BookingsView> {
  /// The view currently shown in the bookings panel.
  SelectedBookingsViewProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedBookingsViewProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedBookingsViewHash();

  @$internal
  @override
  SelectedBookingsView create() => SelectedBookingsView();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BookingsView value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BookingsView>(value),
    );
  }
}

String _$selectedBookingsViewHash() =>
    r'e911f00279d14ffc4a9c47050fa47cd5802b8ea3';

/// The view currently shown in the bookings panel.

abstract class _$SelectedBookingsView extends $Notifier<BookingsView> {
  BookingsView build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<BookingsView, BookingsView>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<BookingsView, BookingsView>,
              BookingsView,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// The month shown in the monthly calendar, as the first day of that month.

@ProviderFor(DisplayedMonth)
final displayedMonthProvider = DisplayedMonthProvider._();

/// The month shown in the monthly calendar, as the first day of that month.
final class DisplayedMonthProvider
    extends $NotifierProvider<DisplayedMonth, DateTime> {
  /// The month shown in the monthly calendar, as the first day of that month.
  DisplayedMonthProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'displayedMonthProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$displayedMonthHash();

  @$internal
  @override
  DisplayedMonth create() => DisplayedMonth();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateTime value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateTime>(value),
    );
  }
}

String _$displayedMonthHash() => r'42ccddd10e3b8624400a817db1be498b3ae8206d';

/// The month shown in the monthly calendar, as the first day of that month.

abstract class _$DisplayedMonth extends $Notifier<DateTime> {
  DateTime build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<DateTime, DateTime>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DateTime, DateTime>,
              DateTime,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
