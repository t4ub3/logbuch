// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crowded_rooms_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The shared rooms of a booking that more than two bookings hold during
/// one of its nights.

@ProviderFor(crowdedRooms)
final crowdedRoomsProvider = CrowdedRoomsFamily._();

/// The shared rooms of a booking that more than two bookings hold during
/// one of its nights.

final class CrowdedRoomsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Room>>,
          List<Room>,
          FutureOr<List<Room>>
        >
    with $FutureModifier<List<Room>>, $FutureProvider<List<Room>> {
  /// The shared rooms of a booking that more than two bookings hold during
  /// one of its nights.
  CrowdedRoomsProvider._({
    required CrowdedRoomsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'crowdedRoomsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$crowdedRoomsHash();

  @override
  String toString() {
    return r'crowdedRoomsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Room>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Room>> create(Ref ref) {
    final argument = this.argument as int;
    return crowdedRooms(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CrowdedRoomsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$crowdedRoomsHash() => r'434f2f1ecfc5f56c41ac9ad5592fb9f4204b3ee1';

/// The shared rooms of a booking that more than two bookings hold during
/// one of its nights.

final class CrowdedRoomsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Room>>, int> {
  CrowdedRoomsFamily._()
    : super(
        retry: null,
        name: r'crowdedRoomsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The shared rooms of a booking that more than two bookings hold during
  /// one of its nights.

  CrowdedRoomsProvider call(int bookingId) =>
      CrowdedRoomsProvider._(argument: bookingId, from: this);

  @override
  String toString() => r'crowdedRoomsProvider';
}
