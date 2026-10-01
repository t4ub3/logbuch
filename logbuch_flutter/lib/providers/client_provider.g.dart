// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Exposes the global Serverpod client so providers can depend on it and
/// tests can override it.

@ProviderFor(serverpodClient)
final serverpodClientProvider = ServerpodClientProvider._();

/// Exposes the global Serverpod client so providers can depend on it and
/// tests can override it.

final class ServerpodClientProvider
    extends $FunctionalProvider<Client, Client, Client>
    with $Provider<Client> {
  /// Exposes the global Serverpod client so providers can depend on it and
  /// tests can override it.
  ServerpodClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'serverpodClientProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$serverpodClientHash();

  @$internal
  @override
  $ProviderElement<Client> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Client create(Ref ref) {
    return serverpodClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Client value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Client>(value),
    );
  }
}

String _$serverpodClientHash() => r'd9fdb8b2cb79ffbfa6879830d1850f2c9e393794';
