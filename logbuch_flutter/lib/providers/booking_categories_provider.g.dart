// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_categories_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(bookingCategories)
final bookingCategoriesProvider = BookingCategoriesProvider._();

final class BookingCategoriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<BookingCategory>>,
          List<BookingCategory>,
          FutureOr<List<BookingCategory>>
        >
    with
        $FutureModifier<List<BookingCategory>>,
        $FutureProvider<List<BookingCategory>> {
  BookingCategoriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bookingCategoriesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bookingCategoriesHash();

  @$internal
  @override
  $FutureProviderElement<List<BookingCategory>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<BookingCategory>> create(Ref ref) {
    return bookingCategories(ref);
  }
}

String _$bookingCategoriesHash() => r'cd950dff5bf8df72227be10908c63f3fa2f4c849';
