// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operator_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The details of the organisation that runs the house, or null if none
/// were entered yet.

@ProviderFor(operator)
final operatorProvider = OperatorProvider._();

/// The details of the organisation that runs the house, or null if none
/// were entered yet.

final class OperatorProvider
    extends
        $FunctionalProvider<
          AsyncValue<Operator?>,
          Operator?,
          FutureOr<Operator?>
        >
    with $FutureModifier<Operator?>, $FutureProvider<Operator?> {
  /// The details of the organisation that runs the house, or null if none
  /// were entered yet.
  OperatorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'operatorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$operatorHash();

  @$internal
  @override
  $FutureProviderElement<Operator?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Operator?> create(Ref ref) {
    return operator(ref);
  }
}

String _$operatorHash() => r'2ac4261f6f627e3264647bd6362634320008d55b';
