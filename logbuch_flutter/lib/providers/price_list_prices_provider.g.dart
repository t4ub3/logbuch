// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_list_prices_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// All prices of one price list.

@ProviderFor(priceListPrices)
final priceListPricesProvider = PriceListPricesFamily._();

/// All prices of one price list.

final class PriceListPricesProvider
    extends
        $FunctionalProvider<
          AsyncValue<PriceListPrices>,
          PriceListPrices,
          FutureOr<PriceListPrices>
        >
    with $FutureModifier<PriceListPrices>, $FutureProvider<PriceListPrices> {
  /// All prices of one price list.
  PriceListPricesProvider._({
    required PriceListPricesFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'priceListPricesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$priceListPricesHash();

  @override
  String toString() {
    return r'priceListPricesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<PriceListPrices> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PriceListPrices> create(Ref ref) {
    final argument = this.argument as int;
    return priceListPrices(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PriceListPricesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$priceListPricesHash() => r'4d50a1f29e98be68ce94ebaf3f472740f86f2d83';

/// All prices of one price list.

final class PriceListPricesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<PriceListPrices>, int> {
  PriceListPricesFamily._()
    : super(
        retry: null,
        name: r'priceListPricesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// All prices of one price list.

  PriceListPricesProvider call(int priceListId) =>
      PriceListPricesProvider._(argument: priceListId, from: this);

  @override
  String toString() => r'priceListPricesProvider';
}
