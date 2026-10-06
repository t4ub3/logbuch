// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'folios_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The folios of a booking with their charges, payments and donations. The
/// server brings the charges up to date whenever they are read.

@ProviderFor(folios)
final foliosProvider = FoliosFamily._();

/// The folios of a booking with their charges, payments and donations. The
/// server brings the charges up to date whenever they are read.

final class FoliosProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Folio>>,
          List<Folio>,
          FutureOr<List<Folio>>
        >
    with $FutureModifier<List<Folio>>, $FutureProvider<List<Folio>> {
  /// The folios of a booking with their charges, payments and donations. The
  /// server brings the charges up to date whenever they are read.
  FoliosProvider._({
    required FoliosFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'foliosProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$foliosHash();

  @override
  String toString() {
    return r'foliosProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Folio>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Folio>> create(Ref ref) {
    final argument = this.argument as int;
    return folios(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is FoliosProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$foliosHash() => r'721a7720d899cfaf6f554d39d406602f50213414';

/// The folios of a booking with their charges, payments and donations. The
/// server brings the charges up to date whenever they are read.

final class FoliosFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Folio>>, int> {
  FoliosFamily._()
    : super(
        retry: null,
        name: r'foliosProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The folios of a booking with their charges, payments and donations. The
  /// server brings the charges up to date whenever they are read.

  FoliosProvider call(int bookingId) =>
      FoliosProvider._(argument: bookingId, from: this);

  @override
  String toString() => r'foliosProvider';
}
