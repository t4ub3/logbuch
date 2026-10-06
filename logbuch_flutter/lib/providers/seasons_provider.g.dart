// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seasons_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(seasons)
final seasonsProvider = SeasonsProvider._();

final class SeasonsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Season>>,
          List<Season>,
          FutureOr<List<Season>>
        >
    with $FutureModifier<List<Season>>, $FutureProvider<List<Season>> {
  SeasonsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'seasonsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$seasonsHash();

  @$internal
  @override
  $FutureProviderElement<List<Season>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Season>> create(Ref ref) {
    return seasons(ref);
  }
}

String _$seasonsHash() => r'4c1beb44172b9f552f863d6e8f0740a6ec720b1e';
