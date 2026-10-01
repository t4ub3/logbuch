// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contacts_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(contacts)
final contactsProvider = ContactsProvider._();

final class ContactsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Contact>>,
          List<Contact>,
          FutureOr<List<Contact>>
        >
    with $FutureModifier<List<Contact>>, $FutureProvider<List<Contact>> {
  ContactsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'contactsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$contactsHash();

  @$internal
  @override
  $FutureProviderElement<List<Contact>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Contact>> create(Ref ref) {
    return contacts(ref);
  }
}

String _$contactsHash() => r'0bd67b7f399ffed1f7cabe39d7b944ead4821f12';
