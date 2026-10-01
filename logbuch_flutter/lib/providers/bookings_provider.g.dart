// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(bookings)
final bookingsProvider = BookingsProvider._();

final class BookingsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Booking>>,
          List<Booking>,
          FutureOr<List<Booking>>
        >
    with $FutureModifier<List<Booking>>, $FutureProvider<List<Booking>> {
  BookingsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bookingsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bookingsHash();

  @$internal
  @override
  $FutureProviderElement<List<Booking>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Booking>> create(Ref ref) {
    return bookings(ref);
  }
}

String _$bookingsHash() => r'de0757c92774fd7b9a5e67f7eacdf9ccdcf6218f';
