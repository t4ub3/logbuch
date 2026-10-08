// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit_types_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(unitTypes)
final unitTypesProvider = UnitTypesProvider._();

final class UnitTypesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<UnitType>>,
          List<UnitType>,
          FutureOr<List<UnitType>>
        >
    with $FutureModifier<List<UnitType>>, $FutureProvider<List<UnitType>> {
  UnitTypesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'unitTypesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$unitTypesHash();

  @$internal
  @override
  $FutureProviderElement<List<UnitType>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<UnitType>> create(Ref ref) {
    return unitTypes(ref);
  }
}

String _$unitTypesHash() => r'e300e73aef5045f61d49def5bc43904b9e24780f';
