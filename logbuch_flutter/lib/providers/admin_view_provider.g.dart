// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_view_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The section currently shown in the admin panel.

@ProviderFor(SelectedAdminSection)
final selectedAdminSectionProvider = SelectedAdminSectionProvider._();

/// The section currently shown in the admin panel.
final class SelectedAdminSectionProvider
    extends $NotifierProvider<SelectedAdminSection, AdminSection> {
  /// The section currently shown in the admin panel.
  SelectedAdminSectionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedAdminSectionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedAdminSectionHash();

  @$internal
  @override
  SelectedAdminSection create() => SelectedAdminSection();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AdminSection value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AdminSection>(value),
    );
  }
}

String _$selectedAdminSectionHash() =>
    r'a335c40da516a969132db9ece5a15df693ee7e63';

/// The section currently shown in the admin panel.

abstract class _$SelectedAdminSection extends $Notifier<AdminSection> {
  AdminSection build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AdminSection, AdminSection>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AdminSection, AdminSection>,
              AdminSection,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
