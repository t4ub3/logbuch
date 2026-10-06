// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_user_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The signed-in user with their role.

@ProviderFor(currentUser)
final currentUserProvider = CurrentUserProvider._();

/// The signed-in user with their role.

final class CurrentUserProvider
    extends $FunctionalProvider<AsyncValue<AppUser>, AppUser, FutureOr<AppUser>>
    with $FutureModifier<AppUser>, $FutureProvider<AppUser> {
  /// The signed-in user with their role.
  CurrentUserProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentUserProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentUserHash();

  @$internal
  @override
  $FutureProviderElement<AppUser> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<AppUser> create(Ref ref) {
    return currentUser(ref);
  }
}

String _$currentUserHash() => r'99d0357a3c30b8bd9b10b47f6637b10ac7b9681a';

/// Whether the signed-in user may change data. Viewers can only read, so
/// everything that adds, edits or deletes is hidden from them.

@ProviderFor(canEdit)
final canEditProvider = CanEditProvider._();

/// Whether the signed-in user may change data. Viewers can only read, so
/// everything that adds, edits or deletes is hidden from them.

final class CanEditProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// Whether the signed-in user may change data. Viewers can only read, so
  /// everything that adds, edits or deletes is hidden from them.
  CanEditProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'canEditProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$canEditHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return canEdit(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$canEditHash() => r'5b16ce3a4be89d557a3020ef3a240e8a6e216fab';
