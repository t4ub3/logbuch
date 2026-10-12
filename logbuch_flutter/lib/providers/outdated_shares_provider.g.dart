// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outdated_shares_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The invoices, of a booking and of those it shares a room with, that
/// charge that room for another split than the bookings share it now.

@ProviderFor(outdatedShares)
final outdatedSharesProvider = OutdatedSharesFamily._();

/// The invoices, of a booking and of those it shares a room with, that
/// charge that room for another split than the bookings share it now.

final class OutdatedSharesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<OutdatedShare>>,
          List<OutdatedShare>,
          FutureOr<List<OutdatedShare>>
        >
    with
        $FutureModifier<List<OutdatedShare>>,
        $FutureProvider<List<OutdatedShare>> {
  /// The invoices, of a booking and of those it shares a room with, that
  /// charge that room for another split than the bookings share it now.
  OutdatedSharesProvider._({
    required OutdatedSharesFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'outdatedSharesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$outdatedSharesHash();

  @override
  String toString() {
    return r'outdatedSharesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<OutdatedShare>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<OutdatedShare>> create(Ref ref) {
    final argument = this.argument as int;
    return outdatedShares(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is OutdatedSharesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$outdatedSharesHash() => r'c9def4f6149774d834dd5230fb78c265f7ade2c7';

/// The invoices, of a booking and of those it shares a room with, that
/// charge that room for another split than the bookings share it now.

final class OutdatedSharesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<OutdatedShare>>, int> {
  OutdatedSharesFamily._()
    : super(
        retry: null,
        name: r'outdatedSharesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The invoices, of a booking and of those it shares a room with, that
  /// charge that room for another split than the bookings share it now.

  OutdatedSharesProvider call(int bookingId) =>
      OutdatedSharesProvider._(argument: bookingId, from: this);

  @override
  String toString() => r'outdatedSharesProvider';
}
