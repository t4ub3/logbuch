// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// What the status bar shows. Loading is reported by [StatusObserver]; what
/// the user did is reported where it is done, once it has worked.

@ProviderFor(Status)
final statusProvider = StatusProvider._();

/// What the status bar shows. Loading is reported by [StatusObserver]; what
/// the user did is reported where it is done, once it has worked.
final class StatusProvider extends $NotifierProvider<Status, StatusState> {
  /// What the status bar shows. Loading is reported by [StatusObserver]; what
  /// the user did is reported where it is done, once it has worked.
  StatusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'statusProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$statusHash();

  @$internal
  @override
  Status create() => Status();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StatusState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StatusState>(value),
    );
  }
}

String _$statusHash() => r'12f45028d18725c03b242217567a4d13b7a91da5';

/// What the status bar shows. Loading is reported by [StatusObserver]; what
/// the user did is reported where it is done, once it has worked.

abstract class _$Status extends $Notifier<StatusState> {
  StatusState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<StatusState, StatusState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<StatusState, StatusState>,
              StatusState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
