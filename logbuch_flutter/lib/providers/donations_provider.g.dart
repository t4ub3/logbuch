// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'donations_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The donations made in a year, with their donors and receipts.

@ProviderFor(donations)
final donationsProvider = DonationsFamily._();

/// The donations made in a year, with their donors and receipts.

final class DonationsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Donation>>,
          List<Donation>,
          FutureOr<List<Donation>>
        >
    with $FutureModifier<List<Donation>>, $FutureProvider<List<Donation>> {
  /// The donations made in a year, with their donors and receipts.
  DonationsProvider._({
    required DonationsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'donationsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$donationsHash();

  @override
  String toString() {
    return r'donationsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Donation>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Donation>> create(Ref ref) {
    final argument = this.argument as int;
    return donations(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is DonationsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$donationsHash() => r'86513af817b59915dec4b59729c53a631bb0d502';

/// The donations made in a year, with their donors and receipts.

final class DonationsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Donation>>, int> {
  DonationsFamily._()
    : super(
        retry: null,
        name: r'donationsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The donations made in a year, with their donors and receipts.

  DonationsProvider call(int year) =>
      DonationsProvider._(argument: year, from: this);

  @override
  String toString() => r'donationsProvider';
}

/// The receipts issued for the donations of a year.

@ProviderFor(donationReceipts)
final donationReceiptsProvider = DonationReceiptsFamily._();

/// The receipts issued for the donations of a year.

final class DonationReceiptsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<DonationReceipt>>,
          List<DonationReceipt>,
          FutureOr<List<DonationReceipt>>
        >
    with
        $FutureModifier<List<DonationReceipt>>,
        $FutureProvider<List<DonationReceipt>> {
  /// The receipts issued for the donations of a year.
  DonationReceiptsProvider._({
    required DonationReceiptsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'donationReceiptsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$donationReceiptsHash();

  @override
  String toString() {
    return r'donationReceiptsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<DonationReceipt>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<DonationReceipt>> create(Ref ref) {
    final argument = this.argument as int;
    return donationReceipts(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is DonationReceiptsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$donationReceiptsHash() => r'92c49cc4b8cbb8b538121f3d885ab7e573318a16';

/// The receipts issued for the donations of a year.

final class DonationReceiptsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<DonationReceipt>>, int> {
  DonationReceiptsFamily._()
    : super(
        retry: null,
        name: r'donationReceiptsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The receipts issued for the donations of a year.

  DonationReceiptsProvider call(int year) =>
      DonationReceiptsProvider._(argument: year, from: this);

  @override
  String toString() => r'donationReceiptsProvider';
}

/// The receipts that would be issued for a year now.

@ProviderFor(receiptPreviews)
final receiptPreviewsProvider = ReceiptPreviewsFamily._();

/// The receipts that would be issued for a year now.

final class ReceiptPreviewsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ReceiptPreview>>,
          List<ReceiptPreview>,
          FutureOr<List<ReceiptPreview>>
        >
    with
        $FutureModifier<List<ReceiptPreview>>,
        $FutureProvider<List<ReceiptPreview>> {
  /// The receipts that would be issued for a year now.
  ReceiptPreviewsProvider._({
    required ReceiptPreviewsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'receiptPreviewsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$receiptPreviewsHash();

  @override
  String toString() {
    return r'receiptPreviewsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<ReceiptPreview>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ReceiptPreview>> create(Ref ref) {
    final argument = this.argument as int;
    return receiptPreviews(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ReceiptPreviewsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$receiptPreviewsHash() => r'25131a62218fe3bb76b46fb2f1af3fb58f74cab5';

/// The receipts that would be issued for a year now.

final class ReceiptPreviewsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<ReceiptPreview>>, int> {
  ReceiptPreviewsFamily._()
    : super(
        retry: null,
        name: r'receiptPreviewsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The receipts that would be issued for a year now.

  ReceiptPreviewsProvider call(int year) =>
      ReceiptPreviewsProvider._(argument: year, from: this);

  @override
  String toString() => r'receiptPreviewsProvider';
}
