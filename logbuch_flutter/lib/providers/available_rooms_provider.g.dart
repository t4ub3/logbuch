// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'available_rooms_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The rooms that are free for the nights from [arrival] to [departure],
/// including those that the booking [exceptBookingId] holds itself.

@ProviderFor(availableRooms)
final availableRoomsProvider = AvailableRoomsFamily._();

/// The rooms that are free for the nights from [arrival] to [departure],
/// including those that the booking [exceptBookingId] holds itself.

final class AvailableRoomsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Room>>,
          List<Room>,
          FutureOr<List<Room>>
        >
    with $FutureModifier<List<Room>>, $FutureProvider<List<Room>> {
  /// The rooms that are free for the nights from [arrival] to [departure],
  /// including those that the booking [exceptBookingId] holds itself.
  AvailableRoomsProvider._({
    required AvailableRoomsFamily super.from,
    required ({DateTime arrival, DateTime departure, int? exceptBookingId})
    super.argument,
  }) : super(
         retry: null,
         name: r'availableRoomsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$availableRoomsHash();

  @override
  String toString() {
    return r'availableRoomsProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<Room>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Room>> create(Ref ref) {
    final argument =
        this.argument
            as ({DateTime arrival, DateTime departure, int? exceptBookingId});
    return availableRooms(
      ref,
      arrival: argument.arrival,
      departure: argument.departure,
      exceptBookingId: argument.exceptBookingId,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AvailableRoomsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$availableRoomsHash() => r'69a3ae91ece80c4c74beddf9c54b3a13eba42bbb';

/// The rooms that are free for the nights from [arrival] to [departure],
/// including those that the booking [exceptBookingId] holds itself.

final class AvailableRoomsFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<Room>>,
          ({DateTime arrival, DateTime departure, int? exceptBookingId})
        > {
  AvailableRoomsFamily._()
    : super(
        retry: null,
        name: r'availableRoomsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The rooms that are free for the nights from [arrival] to [departure],
  /// including those that the booking [exceptBookingId] holds itself.

  AvailableRoomsProvider call({
    required DateTime arrival,
    required DateTime departure,
    int? exceptBookingId,
  }) => AvailableRoomsProvider._(
    argument: (
      arrival: arrival,
      departure: departure,
      exceptBookingId: exceptBookingId,
    ),
    from: this,
  );

  @override
  String toString() => r'availableRoomsProvider';
}
