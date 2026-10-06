import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/components/inset_divider.dart';
import 'package:logbuch_flutter/components/open_file.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/panels/admin/admin_formats.dart';
import 'package:logbuch_flutter/panels/admin/admin_widgets.dart';
import 'package:logbuch_flutter/panels/bookings/amount_row.dart';
import 'package:logbuch_flutter/panels/contacts/contacts_section.dart';
import 'package:logbuch_flutter/providers/client_provider.dart';
import 'package:logbuch_flutter/providers/contacts_provider.dart';
import 'package:logbuch_flutter/providers/current_user_provider.dart';
import 'package:logbuch_flutter/providers/donations_provider.dart';
import 'package:yaru/yaru.dart';

/// The donations of one year and the receipts issued for them.
class DonationsPanel extends ConsumerStatefulWidget {
  const DonationsPanel({super.key});

  @override
  ConsumerState<DonationsPanel> createState() => _DonationsPanelState();
}

class _DonationsPanelState extends ConsumerState<DonationsPanel> {
  int _year = DateTime.now().year;

  void _refresh() {
    ref.invalidate(donationsProvider(_year));
    ref.invalidate(donationReceiptsProvider(_year));
    ref.invalidate(receiptPreviewsProvider(_year));
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final canEdit = ref.watch(canEditProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            children: [
              IconButton(
                tooltip: t.bookings.previousYear,
                icon: const Icon(Icons.chevron_left),
                onPressed: () => setState(() => _year--),
              ),
              IconButton(
                tooltip: t.bookings.nextYear,
                icon: const Icon(Icons.chevron_right),
                onPressed: () => setState(() => _year++),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  t.donations.title(year: _year),
                  style: Theme.of(context).textTheme.titleLarge,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (canEdit) ...[
                OutlinedButton(
                  onPressed: _createReceipts,
                  child: Text(t.donations.createReceipts),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  icon: const Icon(YaruIcons.plus),
                  label: Text(t.donations.add),
                  onPressed: () async {
                    final dialog = _DonationDialog(year: _year);
                    if (await showAdminDialog(context, dialog)) _refresh();
                  },
                ),
              ],
            ],
          ),
        ),
        const InsetDivider(),
        Expanded(
          child: switch ((
            ref.watch(donationsProvider(_year)),
            ref.watch(donationReceiptsProvider(_year)),
          )) {
            (AsyncError(:final error), _) || (_, AsyncError(:final error)) =>
              Center(child: Text(t.common.loadFailed(error: error))),
            (
              AsyncValue(value: final donations?),
              AsyncValue(value: final receipts?),
            ) =>
              donations.isEmpty
                  ? Center(child: Text(t.donations.empty(year: _year)))
                  : _buildLists(context, donations, receipts, canEdit),
            _ => const Center(child: CircularProgressIndicator()),
          },
        ),
      ],
    );
  }

  Widget _buildLists(
    BuildContext context,
    List<Donation> donations,
    List<DonationReceipt> receipts,
    bool canEdit,
  ) {
    final t = context.t.donations;
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.all(kYaruPagePadding),
      children: [
        if (receipts.isNotEmpty) ...[
          YaruSection(
            headline: Text(t.receipts),
            child: Column(
              children: [
                for (final receipt in receipts)
                  YaruListTile(
                    leading: const Icon(YaruIcons.document),
                    titleText: receipt.number,
                    subtitleText: [
                      receipt.contact?.fullName ?? '',
                      formatMoney(context, receipt.total),
                      formatDate(context, receipt.issuedAt),
                    ].join(' · '),
                    trailing: IconButton(
                      tooltip: t.openPdf,
                      icon: const Icon(Icons.picture_as_pdf_outlined),
                      onPressed: () => _open(receipt),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
        YaruSection(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                for (final donation in donations)
                  AmountRow(
                    label: [
                      formatDate(context, donation.date),
                      donation.contact?.fullName ?? '',
                      if (donation.source == DonationSource.overpayment)
                        t.fromPayment,
                    ].join(' · '),
                    detail: donation.receipt?.number ?? t.noReceipt,
                    amount: donation.amount,
                    // What was left over from a payment is taken back in
                    // its booking, and nothing on a receipt changes.
                    onDelete:
                        canEdit &&
                            donation.receiptId == null &&
                            donation.source == DonationSource.direct
                        ? () => _delete(donation)
                        : null,
                  ),
                const Divider(),
                AmountRow(
                  label: t.total,
                  amount: donations.fold(0, (sum, d) => sum + d.amount),
                  style: theme.textTheme.titleSmall,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _delete(Donation donation) async {
    final deleted = await confirmAndDelete(
      context,
      name:
          '${donation.contact?.fullName ?? ''} · '
          '${formatMoney(context, donation.amount)}',
      delete: () =>
          ref.read(serverpodClientProvider).donation.delete(donation.id!),
    );
    if (deleted) _refresh();
  }

  /// Shows what receipts there would be and issues them if confirmed.
  Future<void> _createReceipts() async {
    final t = context.t.donations;
    final year = _year;
    ref.invalidate(receiptPreviewsProvider(year));
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => _ReceiptsDialog(year: year),
    );
    if (confirmed != true || !mounted) return;

    final String message;
    try {
      final created = await ref
          .read(serverpodClientProvider)
          .donation
          .createReceipts(year);
      message = t.created(n: created.length);
    } catch (error) {
      if (!mounted) return;
      _show(
        validationMessage(context, error) ??
            context.t.common.saveFailed(error: error),
      );
      return;
    }
    _refresh();
    if (mounted) _show(message);
  }

  Future<void> _open(DonationReceipt receipt) async {
    try {
      final pdf = await ref
          .read(serverpodClientProvider)
          .donation
          .getReceiptPdf(receipt.id!);
      await ref.read(fileOpenerProvider)(
        '${receipt.number}.pdf',
        // The bytes may be a part of a larger buffer.
        pdf.buffer.asUint8List(pdf.offsetInBytes, pdf.lengthInBytes),
      );
    } catch (error) {
      if (mounted) _show(context.t.donations.openFailed(error: error));
    }
  }

  void _show(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}

/// Lists the receipts that would be issued for a year and asks whether to
/// issue them.
class _ReceiptsDialog extends ConsumerWidget {
  const _ReceiptsDialog({required this.year});

  final int year;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final theme = Theme.of(context);
    final previews = ref.watch(receiptPreviewsProvider(year));
    final ready = [
      for (final preview in previews.value ?? <ReceiptPreview>[])
        if (preview.addressComplete) preview,
    ];

    return AlertDialog(
      title: Text(t.donations.previewTitle(year: year)),
      content: SizedBox(
        width: 460,
        child: switch (previews) {
          AsyncError(:final error) => Text(t.common.loadFailed(error: error)),
          AsyncValue(value: final previews?) when previews.isEmpty => Text(
            t.donations.previewNone(year: year),
          ),
          AsyncValue(value: final previews?) => SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(t.donations.previewHint),
                const SizedBox(height: 16),
                for (final preview in previews)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AmountRow(
                          label: preview.contact.fullName,
                          detail: t.donations.donationCount(
                            n: preview.donationCount,
                          ),
                          amount: preview.total,
                        ),
                        if (!preview.addressComplete)
                          Text(
                            t.donations.addressMissing,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.error,
                            ),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          _ => const SizedBox(
            height: 80,
            child: Center(child: CircularProgressIndicator()),
          ),
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(t.common.cancel),
        ),
        ElevatedButton(
          onPressed: ready.isEmpty ? null : () => Navigator.pop(context, true),
          child: Text(t.donations.createReceipts),
        ),
      ],
    );
  }
}

/// Records a donation that was not left over from a payment.
class _DonationDialog extends ConsumerStatefulWidget {
  const _DonationDialog({required this.year});

  /// The year that is shown; a donation of today goes into the current one.
  final int year;

  @override
  ConsumerState<_DonationDialog> createState() => _DonationDialogState();
}

class _DonationDialogState extends ConsumerState<_DonationDialog> {
  final _amount = TextEditingController();
  Contact? _donor;
  late DateTime? _date = _suggestedDate();

  /// Today, or the last day of the shown year if that is over.
  DateTime _suggestedDate() {
    final today = DateUtils.dateOnly(DateTime.now());
    return widget.year < today.year ? DateTime(widget.year, 12, 31) : today;
  }

  @override
  void dispose() {
    _amount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final contacts = ref.watch(contactsProvider).value ?? [];

    return AdminFormDialog(
      title: t.donations.add,
      onSave: _save,
      children: [
        FormField<Contact>(
          validator: (_) => _donor == null ? t.common.required : null,
          builder: (field) => DropdownMenu<Contact>(
            label: Text(t.donations.donor),
            errorText: field.errorText,
            expandedInsets: EdgeInsets.zero,
            enableFilter: true,
            requestFocusOnTap: true,
            onSelected: (contact) => setState(() => _donor = contact),
            dropdownMenuEntries: [
              for (final contact in contacts)
                DropdownMenuEntry(value: contact, label: contact.fullName),
            ],
          ),
        ),
        AmountField(
          controller: _amount,
          label: t.donations.amount,
          suffixText: '€',
        ),
        FormField<DateTime>(
          validator: (_) => _date == null ? t.common.required : null,
          builder: (field) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DateField(
                label: t.donations.date,
                date: _date,
                onChanged: (date) => setState(() => _date = date),
              ),
              if (field.errorText case final error?)
                Text(
                  error,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _save() async {
    await ref
        .read(serverpodClientProvider)
        .donation
        .addDirect(
          Donation(
            contactId: _donor!.id!,
            amount: parseHundredths(_amount.text)!,
            date: toUtcDate(_date!),
            source: DonationSource.direct,
          ),
        );
  }
}
