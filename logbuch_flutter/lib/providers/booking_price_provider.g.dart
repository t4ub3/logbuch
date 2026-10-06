// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_price_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// What a booking costs by the current rates, calculated by the server.

@ProviderFor(bookingPrice)
final bookingPriceProvider = BookingPriceFamily._();

/// What a booking costs by the current rates, calculated by the server.

final class BookingPriceProvider
    extends
        $FunctionalProvider<
          AsyncValue<BookingPrice>,
          BookingPrice,
          FutureOr<BookingPrice>
        >
    with $FutureModifier<BookingPrice>, $FutureProvider<BookingPrice> {
  /// What a booking costs by the current rates, calculated by the server.
  BookingPriceProvider._({
    required BookingPriceFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'bookingPriceProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$bookingPriceHash();

  @override
  String toString() {
    return r'bookingPriceProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<BookingPrice> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<BookingPrice> create(Ref ref) {
    final argument = this.argument as int;
    return bookingPrice(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is BookingPriceProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$bookingPriceHash() => r'1f93eb617a32df76b6a33f3a9d1e8a11225f1898';

/// What a booking costs by the current rates, calculated by the server.

final class BookingPriceFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<BookingPrice>, int> {
  BookingPriceFamily._()
    : super(
        retry: null,
        name: r'bookingPriceProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// What a booking costs by the current rates, calculated by the server.

  BookingPriceProvider call(int bookingId) =>
      BookingPriceProvider._(argument: bookingId, from: this);

  @override
  String toString() => r'bookingPriceProvider';
}
