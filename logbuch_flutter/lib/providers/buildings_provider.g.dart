// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buildings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(buildings)
final buildingsProvider = BuildingsProvider._();

final class BuildingsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Building>>,
          List<Building>,
          FutureOr<List<Building>>
        >
    with $FutureModifier<List<Building>>, $FutureProvider<List<Building>> {
  BuildingsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'buildingsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$buildingsHash();

  @$internal
  @override
  $FutureProviderElement<List<Building>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Building>> create(Ref ref) {
    return buildings(ref);
  }
}

String _$buildingsHash() => r'f9bff0b1cf46078703fd179ec951f28f495682d4';
