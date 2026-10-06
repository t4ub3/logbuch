// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kitchen_overview_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The guests of a booking summed up for the kitchen, by the server.

@ProviderFor(kitchenOverview)
final kitchenOverviewProvider = KitchenOverviewFamily._();

/// The guests of a booking summed up for the kitchen, by the server.

final class KitchenOverviewProvider
    extends
        $FunctionalProvider<
          AsyncValue<KitchenOverview>,
          KitchenOverview,
          FutureOr<KitchenOverview>
        >
    with $FutureModifier<KitchenOverview>, $FutureProvider<KitchenOverview> {
  /// The guests of a booking summed up for the kitchen, by the server.
  KitchenOverviewProvider._({
    required KitchenOverviewFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'kitchenOverviewProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$kitchenOverviewHash();

  @override
  String toString() {
    return r'kitchenOverviewProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<KitchenOverview> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<KitchenOverview> create(Ref ref) {
    final argument = this.argument as int;
    return kitchenOverview(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is KitchenOverviewProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$kitchenOverviewHash() => r'd7f597fa2bc56303bf2cf3b98e5f361324bcef57';

/// The guests of a booking summed up for the kitchen, by the server.

final class KitchenOverviewFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<KitchenOverview>, int> {
  KitchenOverviewFamily._()
    : super(
        retry: null,
        name: r'kitchenOverviewProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The guests of a booking summed up for the kitchen, by the server.

  KitchenOverviewProvider call(int bookingId) =>
      KitchenOverviewProvider._(argument: bookingId, from: this);

  @override
  String toString() => r'kitchenOverviewProvider';
}
