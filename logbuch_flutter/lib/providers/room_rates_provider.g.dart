// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_rates_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The room rates of one season.

@ProviderFor(roomRates)
final roomRatesProvider = RoomRatesFamily._();

/// The room rates of one season.

final class RoomRatesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<RoomRate>>,
          List<RoomRate>,
          FutureOr<List<RoomRate>>
        >
    with $FutureModifier<List<RoomRate>>, $FutureProvider<List<RoomRate>> {
  /// The room rates of one season.
  RoomRatesProvider._({
    required RoomRatesFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'roomRatesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$roomRatesHash();

  @override
  String toString() {
    return r'roomRatesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<RoomRate>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<RoomRate>> create(Ref ref) {
    final argument = this.argument as int;
    return roomRates(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is RoomRatesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$roomRatesHash() => r'8a388fb62a85d4497b1b007ce8ecf1b29f6789aa';

/// The room rates of one season.

final class RoomRatesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<RoomRate>>, int> {
  RoomRatesFamily._()
    : super(
        retry: null,
        name: r'roomRatesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The room rates of one season.

  RoomRatesProvider call(int seasonId) =>
      RoomRatesProvider._(argument: seasonId, from: this);

  @override
  String toString() => r'roomRatesProvider';
}
