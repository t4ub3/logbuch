// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guest_groups_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The guests of a booking in their groups.

@ProviderFor(guestGroups)
final guestGroupsProvider = GuestGroupsFamily._();

/// The guests of a booking in their groups.

final class GuestGroupsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<GuestGroup>>,
          List<GuestGroup>,
          FutureOr<List<GuestGroup>>
        >
    with $FutureModifier<List<GuestGroup>>, $FutureProvider<List<GuestGroup>> {
  /// The guests of a booking in their groups.
  GuestGroupsProvider._({
    required GuestGroupsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'guestGroupsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$guestGroupsHash();

  @override
  String toString() {
    return r'guestGroupsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<GuestGroup>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<GuestGroup>> create(Ref ref) {
    final argument = this.argument as int;
    return guestGroups(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is GuestGroupsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$guestGroupsHash() => r'24a0a5a52e3ebe8a99169876c06993bc1cba7795';

/// The guests of a booking in their groups.

final class GuestGroupsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<GuestGroup>>, int> {
  GuestGroupsFamily._()
    : super(
        retry: null,
        name: r'guestGroupsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The guests of a booking in their groups.

  GuestGroupsProvider call(int bookingId) =>
      GuestGroupsProvider._(argument: bookingId, from: this);

  @override
  String toString() => r'guestGroupsProvider';
}
