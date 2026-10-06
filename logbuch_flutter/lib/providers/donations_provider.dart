import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/providers/client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'donations_provider.g.dart';

/// The donations made in a year, with their donors and receipts.
@riverpod
Future<List<Donation>> donations(Ref ref, int year) {
  return ref.watch(serverpodClientProvider).donation.getByYear(year);
}

/// The receipts issued for the donations of a year.
@riverpod
Future<List<DonationReceipt>> donationReceipts(Ref ref, int year) {
  return ref.watch(serverpodClientProvider).donation.getReceipts(year);
}

/// The receipts that would be issued for a year now.
@riverpod
Future<List<ReceiptPreview>> receiptPreviews(Ref ref, int year) {
  return ref.watch(serverpodClientProvider).donation.previewReceipts(year);
}
