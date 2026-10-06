// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organizations_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(organizations)
final organizationsProvider = OrganizationsProvider._();

final class OrganizationsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Organization>>,
          List<Organization>,
          FutureOr<List<Organization>>
        >
    with
        $FutureModifier<List<Organization>>,
        $FutureProvider<List<Organization>> {
  OrganizationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'organizationsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$organizationsHash();

  @$internal
  @override
  $FutureProviderElement<List<Organization>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Organization>> create(Ref ref) {
    return organizations(ref);
  }
}

String _$organizationsHash() => r'cdf86da28fe1f92ecf8b1c60072906197badfd9a';
