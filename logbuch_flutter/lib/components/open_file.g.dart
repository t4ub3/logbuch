// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'open_file.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// How files are opened. Tests replace it, so that nothing opens for real.

@ProviderFor(fileOpener)
final fileOpenerProvider = FileOpenerProvider._();

/// How files are opened. Tests replace it, so that nothing opens for real.

final class FileOpenerProvider
    extends $FunctionalProvider<FileOpener, FileOpener, FileOpener>
    with $Provider<FileOpener> {
  /// How files are opened. Tests replace it, so that nothing opens for real.
  FileOpenerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fileOpenerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fileOpenerHash();

  @$internal
  @override
  $ProviderElement<FileOpener> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FileOpener create(Ref ref) {
    return fileOpener(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FileOpener value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FileOpener>(value),
    );
  }
}

String _$fileOpenerHash() => r'5898db21d6299a8ca88c1f84f46678222393aaee';
