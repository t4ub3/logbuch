// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_lists_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The price lists by their first day.

@ProviderFor(priceLists)
final priceListsProvider = PriceListsProvider._();

/// The price lists by their first day.

final class PriceListsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<PriceList>>,
          List<PriceList>,
          FutureOr<List<PriceList>>
        >
    with $FutureModifier<List<PriceList>>, $FutureProvider<List<PriceList>> {
  /// The price lists by their first day.
  PriceListsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'priceListsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$priceListsHash();

  @$internal
  @override
  $FutureProviderElement<List<PriceList>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<PriceList>> create(Ref ref) {
    return priceLists(ref);
  }
}

String _$priceListsHash() => r'4f8d0843b9f91fbefefd943e87cbf859bda5cd54';
