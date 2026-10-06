// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'age_groups_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ageGroups)
final ageGroupsProvider = AgeGroupsProvider._();

final class AgeGroupsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<AgeGroup>>,
          List<AgeGroup>,
          FutureOr<List<AgeGroup>>
        >
    with $FutureModifier<List<AgeGroup>>, $FutureProvider<List<AgeGroup>> {
  AgeGroupsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ageGroupsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ageGroupsHash();

  @$internal
  @override
  $FutureProviderElement<List<AgeGroup>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<AgeGroup>> create(Ref ref) {
    return ageGroups(ref);
  }
}

String _$ageGroupsHash() => r'346059f7b799e15f953e2f0e3c5dc2ee7607e16f';
