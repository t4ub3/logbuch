// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tabs_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Tabs)
final tabsProvider = TabsProvider._();

final class TabsProvider extends $NotifierProvider<Tabs, OpenTabs> {
  TabsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tabsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tabsHash();

  @$internal
  @override
  Tabs create() => Tabs();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OpenTabs value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OpenTabs>(value),
    );
  }
}

String _$tabsHash() => r'f700656aadb7a5cd7f17509d335323edd3e79cad';

abstract class _$Tabs extends $Notifier<OpenTabs> {
  OpenTabs build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<OpenTabs, OpenTabs>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<OpenTabs, OpenTabs>,
              OpenTabs,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
