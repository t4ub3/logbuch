// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'households_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// All households with their members.

@ProviderFor(households)
final householdsProvider = HouseholdsProvider._();

/// All households with their members.

final class HouseholdsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Household>>,
          List<Household>,
          FutureOr<List<Household>>
        >
    with $FutureModifier<List<Household>>, $FutureProvider<List<Household>> {
  /// All households with their members.
  HouseholdsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'householdsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$householdsHash();

  @$internal
  @override
  $FutureProviderElement<List<Household>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Household>> create(Ref ref) {
    return households(ref);
  }
}

String _$householdsHash() => r'3c46e1fa023f14fa595ee6c415634f2e5774dc71';
