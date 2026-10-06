// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fees_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(fees)
final feesProvider = FeesProvider._();

final class FeesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Fee>>,
          List<Fee>,
          FutureOr<List<Fee>>
        >
    with $FutureModifier<List<Fee>>, $FutureProvider<List<Fee>> {
  FeesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'feesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$feesHash();

  @$internal
  @override
  $FutureProviderElement<List<Fee>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Fee>> create(Ref ref) {
    return fees(ref);
  }
}

String _$feesHash() => r'1cda76bd0e7a5ee7b909a274d99b51321e328af9';
