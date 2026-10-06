// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_categories_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(priceCategories)
final priceCategoriesProvider = PriceCategoriesProvider._();

final class PriceCategoriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<PriceCategory>>,
          List<PriceCategory>,
          FutureOr<List<PriceCategory>>
        >
    with
        $FutureModifier<List<PriceCategory>>,
        $FutureProvider<List<PriceCategory>> {
  PriceCategoriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'priceCategoriesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$priceCategoriesHash();

  @$internal
  @override
  $FutureProviderElement<List<PriceCategory>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<PriceCategory>> create(Ref ref) {
    return priceCategories(ref);
  }
}

String _$priceCategoriesHash() => r'2e004bce1949389d7dccbd04781e5349de4a1ea6';
