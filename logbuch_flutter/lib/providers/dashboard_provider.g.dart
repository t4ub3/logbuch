// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// What the start screen shows about today and the days ahead. It is loaded
/// anew whenever the start screen is opened.

@ProviderFor(dashboard)
final dashboardProvider = DashboardProvider._();

/// What the start screen shows about today and the days ahead. It is loaded
/// anew whenever the start screen is opened.

final class DashboardProvider
    extends
        $FunctionalProvider<
          AsyncValue<Dashboard>,
          Dashboard,
          FutureOr<Dashboard>
        >
    with $FutureModifier<Dashboard>, $FutureProvider<Dashboard> {
  /// What the start screen shows about today and the days ahead. It is loaded
  /// anew whenever the start screen is opened.
  DashboardProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dashboardProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dashboardHash();

  @$internal
  @override
  $FutureProviderElement<Dashboard> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Dashboard> create(Ref ref) {
    return dashboard(ref);
  }
}

String _$dashboardHash() => r'07bd0ca8db479f0646a79a52a3e460643743d600';
