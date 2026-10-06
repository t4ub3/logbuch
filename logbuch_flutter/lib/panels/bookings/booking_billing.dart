import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/components/open_file.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/panels/admin/admin_formats.dart';
import 'package:logbuch_flutter/panels/admin/admin_widgets.dart';
import 'package:logbuch_flutter/panels/bookings/amount_row.dart';
import 'package:logbuch_flutter/panels/bookings/booking_card.dart';
import 'package:logbuch_flutter/panels/bookings/booking_price.dart';
import 'package:logbuch_flutter/panels/contacts/contacts_section.dart';
import 'package:logbuch_flutter/providers/client_provider.dart';
import 'package:logbuch_flutter/providers/current_user_provider.dart';
import 'package:logbuch_flutter/providers/folios_provider.dart';
import 'package:yaru/yaru.dart';

extension FolioX on Folio {
  int get charged => [...?charges].fold(0, (sum, charge) => sum + charge.total);

  int get paid =>
      [...?payments].fold(0, (sum, payment) => sum + payment.amount);

  int get donated => [
    for (final payment in payments ?? <Payment>[]) ...?payment.donations,
  ].fold(0, (sum, donation) => sum + donation.amount);

  /// What was paid beyond the charges and the donations; negative while
  /// money is still owed.
  int get overpaid => paid - donated - charged;

  bool get isInvoiced => invoiceNumber != null;
}

extension PaymentMethodX on PaymentMethod {
  String label(BuildContext context) {
    final t = context.t.bookings.paymentMethods;
    return switch (this) {
      PaymentMethod.cash => t.cash,
      PaymentMethod.bankTransfer => t.bankTransfer,
      PaymentMethod.card => t.card,
      PaymentMethod.other => t.other,
    };
  }
}

/// What to do with money that was paid beyond what is owed.
enum _Overpayment { donation, refund, credit }

/// The folios of a booking: one account per payer with the charges, the
/// payments and what is still owed.
class BookingBillingCard extends ConsumerWidget {
  const BookingBillingCard({super.key, required this.bookingId});

  final int bookingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.bookings;
    final theme = Theme.of(context);
    final folios = ref.watch(foliosProvider(bookingId));

    return BookingCard(
      title: t.billing,
      // Without a folio there is nothing to invoice or to pay.
      onEdit: ref.watch(canEditProvider) && (folios.value?.isNotEmpty ?? false)
          ? () => showBookingOverlay(
              context,
              ref,
              bookingId: bookingId,
              overlay: BookingBillingEditor(bookingId: bookingId),
            )
          : null,
      child: switch (folios) {
        AsyncError(:final error) => CardNote(
          context.t.common.loadFailed(error: error),
        ),
        AsyncValue(value: final folios?) =>
          folios.isEmpty
              ? CardNote(t.noFolios)
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (final (index, folio) in folios.indexed) ...[
                      if (index > 0) const Divider(height: 24),
                      DefaultTextStyle.merge(
                        style: theme.textTheme.titleSmall,
                        child: _FolioHeader(folio: folio),
                      ),
                      const SizedBox(height: 4),
                      _FolioBody(folio: folio, readOnly: true),
                    ],
                  ],
                ),
        _ => const CardLoading(),
      },
    );
  }
}

/// The overlay in which the folios of a booking are invoiced and paid, and
/// charges are added to them by hand. Every change is saved at once.
class BookingBillingEditor extends ConsumerWidget {
  const BookingBillingEditor({super.key, required this.bookingId});

  final int bookingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BookingOverlay(
      title: context.t.bookings.billing,
      width: 720,
      height: 720,
      child: switch (ref.watch(foliosProvider(bookingId))) {
        AsyncError(:final error) => Center(
          child: Text(context.t.common.loadFailed(error: error)),
        ),
        AsyncValue(value: final folios?) =>
          folios.isEmpty
              ? Center(
                  child: Text(
                    context.t.bookings.noFolios,
                    textAlign: TextAlign.center,
                  ),
                )
              : ListView(
                  children: [
                    for (final folio in folios)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: YaruSection(
                          headline: _FolioHeader(folio: folio),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: _FolioBody(folio: folio, readOnly: false),
                          ),
                        ),
                      ),
                  ],
                ),
        _ => const CardLoading(),
      },
    );
  }
}

/// Who pays a folio, and whether it was invoiced.
class _FolioHeader extends StatelessWidget {
  const _FolioHeader({required this.folio});

  final Folio folio;

  @override
  Widget build(BuildContext context) {
    final t = context.t.bookings;

    return Row(
      children: [
        Expanded(child: Text(folio.payer?.fullName ?? '')),
        Text(
          switch (folio.invoiceNumber) {
            final number? => t.folioInvoiced(
              number: number,
              date: formatDate(context, folio.invoicedAt!),
            ),
            null => t.folioOpen,
          },
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}

/// The charges and payments of a folio and what is still owed. Unless it is
/// [readOnly], it has the buttons to change the folio as well.
class _FolioBody extends ConsumerWidget {
  const _FolioBody({required this.folio, required this.readOnly});

  final Folio folio;
  final bool readOnly;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.bookings;
    final theme = Theme.of(context);
    final canEdit = !readOnly;
    final billing = ref.read(serverpodClientProvider).billing;
    final overpaid = folio.overpaid;
    final total = theme.textTheme.titleSmall;

    void refresh() => ref.invalidate(foliosProvider(folio.bookingId));

    Future<void> remove(
      String name,
      Future<void> Function() delete, {
      String? hint,
    }) async {
      final deleted = await confirmAndDelete(
        context,
        name: name,
        hint: hint,
        delete: delete,
      );
      if (deleted) refresh();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final charge in folio.charges ?? <Charge>[])
          AmountRow(
            label: '${charge.type.label(context)} · ${charge.description}',
            detail:
                '${charge.quantity} × '
                '${formatMoney(context, charge.unitPrice)}',
            amount: charge.total,
            onDelete: canEdit && !folio.isInvoiced && charge.isByHand
                ? () => remove(
                    charge.description,
                    () => billing.deleteCharge(charge.id!),
                  )
                : null,
          ),
        const Divider(),
        for (final payment in folio.payments ?? <Payment>[]) ...[
          AmountRow(
            label: [
              payment.amount < 0 ? t.refund : t.payment,
              formatDate(context, payment.date),
              payment.method.label(context),
              ?payment.reference,
            ].join(' · '),
            amount: payment.amount,
            onDelete: canEdit
                ? () => remove(
                    formatMoney(context, payment.amount),
                    () => billing.deletePayment(payment.id!),
                    hint: t.removePaymentHint,
                  )
                : null,
          ),
          for (final donation in payment.donations ?? <Donation>[])
            AmountRow(
              label: t.donation,
              amount: donation.amount,
              onDelete: canEdit
                  ? () => remove(
                      t.donation,
                      () => billing.deleteDonation(donation.id!),
                      hint: t.removeDonationHint,
                    )
                  : null,
            ),
        ],
        const SizedBox(height: 4),
        if (overpaid < 0)
          AmountRow(label: t.stillToPay, amount: -overpaid, style: total)
        else if (overpaid == 0)
          Text(t.paidInFull, style: total)
        else
          Row(
            children: [
              Expanded(
                child: AmountRow(
                  label: t.overpaid,
                  amount: overpaid,
                  style: total,
                ),
              ),
              if (canEdit) ...[
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: () => _settleOverpayment(context, ref, folio),
                  child: Text(t.decide),
                ),
              ],
            ],
          ),
        if (folio.isInvoiced)
          Wrap(
            alignment: WrapAlignment.end,
            spacing: 8,
            children: [
              if (canEdit)
                TextButton(
                  onPressed: () => _renewInvoice(context, ref),
                  child: Text(t.renewInvoice),
                ),
              TextButton.icon(
                icon: const Icon(Icons.picture_as_pdf_outlined),
                label: Text(t.openInvoice),
                onPressed: () => _openInvoice(context, ref),
              ),
            ],
          ),
        if (canEdit) ...[
          const SizedBox(height: 12),
          Wrap(
            alignment: WrapAlignment.end,
            spacing: 8,
            runSpacing: 8,
            children: [
              if (!folio.isInvoiced) ...[
                TextButton(
                  onPressed: () async {
                    final dialog = _ChargeDialog(folio: folio);
                    if (await showAdminDialog(context, dialog)) refresh();
                  },
                  child: Text(t.addCharge),
                ),
                OutlinedButton(
                  onPressed: () => _invoice(context, ref),
                  child: Text(t.createInvoice),
                ),
              ],
              ElevatedButton(
                onPressed: () => _recordPayment(context, ref),
                child: Text(t.recordPayment),
              ),
            ],
          ),
        ],
        const SizedBox(height: 4),
      ],
    );
  }

  Future<void> _invoice(BuildContext context, WidgetRef ref) async {
    final t = context.t;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(t.bookings.createInvoice),
        content: Text(t.bookings.createInvoiceHint),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(t.common.cancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(t.bookings.createInvoice),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;
    await _run(
      context,
      ref,
      () => ref.read(serverpodClientProvider).billing.invoice(folio.id!),
    );
  }

  /// Records a payment and, if more was paid than owed, asks what happens
  /// with the rest.
  Future<void> _recordPayment(BuildContext context, WidgetRef ref) async {
    final saved = await showAdminDialog(context, _PaymentDialog(folio: folio));
    if (!saved) return;
    final folios = await ref.refresh(foliosProvider(folio.bookingId).future);
    final current = folios.where((f) => f.id == folio.id).firstOrNull;
    if (current != null && current.overpaid > 0 && context.mounted) {
      await _settleOverpayment(context, ref, current);
    }
  }

  /// Asks what happens with the money that was overpaid on [folio]. It only
  /// becomes a donation if the user says that the payer wants that.
  Future<void> _settleOverpayment(
    BuildContext context,
    WidgetRef ref,
    Folio folio,
  ) async {
    final t = context.t.bookings;
    final overpaid = folio.overpaid;
    // The money came with the last payment.
    final payment = folio.payments!.lastWhere((payment) => payment.amount > 0);
    final choice = await showDialog<_Overpayment>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(t.overpaidTitle(amount: formatMoney(context, overpaid))),
        content: Text(t.overpaidText(name: folio.payer?.fullName ?? '')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, _Overpayment.credit),
            child: Text(t.asCredit),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, _Overpayment.refund),
            child: Text(t.asRefund),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, _Overpayment.donation),
            child: Text(t.asDonation),
          ),
        ],
      ),
    );
    if (!context.mounted) return;
    final billing = ref.read(serverpodClientProvider).billing;
    switch (choice) {
      case _Overpayment.donation:
        await _run(context, ref, () => billing.donate(payment.id!, overpaid));
      case _Overpayment.refund:
        await _run(
          context,
          ref,
          () => billing.addPayment(
            Payment(
              folioId: folio.id!,
              payerId: payment.payerId,
              amount: -overpaid,
              date: toUtcDate(DateTime.now()),
              method: payment.method,
            ),
          ),
        );
      case _Overpayment.credit || null:
        break;
    }
  }

  /// Opens the invoice as a PDF. The server produces it the first time and
  /// keeps it as it is from then on.
  Future<void> _openInvoice(
    BuildContext context,
    WidgetRef ref, {
    bool renew = false,
  }) async {
    try {
      final billing = ref.read(serverpodClientProvider).billing;
      final pdf = renew
          ? await billing.renewInvoicePdf(folio.id!)
          : await billing.getInvoicePdf(folio.id!);
      await ref.read(fileOpenerProvider)(
        'Rechnung-${folio.invoiceNumber}.pdf',
        // The bytes may be a part of a larger buffer.
        pdf.buffer.asUint8List(pdf.offsetInBytes, pdf.lengthInBytes),
      );
    } catch (error) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            validationMessage(context, error) ??
                context.t.bookings.openInvoiceFailed(error: error),
          ),
        ),
      );
    }
  }

  /// Replaces the stored invoice with one made from the current details,
  /// after asking, and opens it.
  Future<void> _renewInvoice(BuildContext context, WidgetRef ref) async {
    final t = context.t;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(t.bookings.renewInvoice),
        content: Text(t.bookings.renewInvoiceHint),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(t.common.cancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(t.bookings.renewInvoice),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;
    await _openInvoice(context, ref, renew: true);
  }

  /// Runs a change of the folio, shows why it failed if it did, and loads
  /// the folios again.
  Future<void> _run(
    BuildContext context,
    WidgetRef ref,
    Future<void> Function() change,
  ) async {
    try {
      await change();
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              validationMessage(context, error) ??
                  context.t.common.saveFailed(error: error),
            ),
          ),
        );
      }
    }
    ref.invalidate(foliosProvider(folio.bookingId));
  }
}

extension on Charge {
  /// Whether the charge was added by hand and not worked out from the
  /// booking.
  bool get isByHand => type == ChargeType.manual || type == ChargeType.discount;
}

class _PaymentDialog extends ConsumerStatefulWidget {
  const _PaymentDialog({required this.folio});

  final Folio folio;

  @override
  ConsumerState<_PaymentDialog> createState() => _PaymentDialogState();
}

class _PaymentDialogState extends ConsumerState<_PaymentDialog> {
  final _amount = TextEditingController();
  final _reference = TextEditingController();
  DateTime? _date = DateUtils.dateOnly(DateTime.now());
  PaymentMethod _method = PaymentMethod.bankTransfer;
  bool _filled = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Suggests what is still owed. Amounts are formatted for the current
    // language, which is not available in initState yet.
    if (_filled) return;
    _filled = true;
    final owed = -widget.folio.overpaid;
    if (owed > 0) _amount.text = formatHundredths(context, owed);
  }

  @override
  void dispose() {
    _amount.dispose();
    _reference.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.bookings;

    return AdminFormDialog(
      title: t.recordPayment,
      onSave: _save,
      children: [
        AmountField(controller: _amount, label: t.amount, suffixText: '€'),
        FormField<DateTime>(
          validator: (_) => _date == null ? context.t.common.required : null,
          builder: (field) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DateField(
                label: t.date,
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
        DropdownButtonFormField<PaymentMethod>(
          isExpanded: true,
          initialValue: _method,
          decoration: InputDecoration(labelText: t.paymentMethod),
          items: [
            for (final method in PaymentMethod.values)
              DropdownMenuItem(
                value: method,
                child: Text(method.label(context)),
              ),
          ],
          onChanged: (method) => setState(() => _method = method ?? _method),
        ),
        TextFormField(
          controller: _reference,
          decoration: InputDecoration(labelText: t.reference),
        ),
      ],
    );
  }

  Future<void> _save() async {
    await ref
        .read(serverpodClientProvider)
        .billing
        .addPayment(
          Payment(
            folioId: widget.folio.id!,
            payerId: widget.folio.payerId,
            amount: parseHundredths(_amount.text)!,
            date: toUtcDate(_date!),
            method: _method,
            reference: nullIfBlank(_reference.text),
          ),
        );
  }
}

/// Adds a charge by hand, such as something extra or a discount.
class _ChargeDialog extends ConsumerStatefulWidget {
  const _ChargeDialog({required this.folio});

  final Folio folio;

  @override
  ConsumerState<_ChargeDialog> createState() => _ChargeDialogState();
}

class _ChargeDialogState extends ConsumerState<_ChargeDialog> {
  final _description = TextEditingController();
  final _quantity = TextEditingController(text: '1');
  final _unitPrice = TextEditingController();
  final _taxRate = TextEditingController(text: '7');
  bool _isDiscount = false;

  @override
  void dispose() {
    _description.dispose();
    _quantity.dispose();
    _unitPrice.dispose();
    _taxRate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.bookings;

    return AdminFormDialog(
      title: t.addCharge,
      onSave: _save,
      children: [
        RequiredTextField(
          controller: _description,
          label: t.description,
          autofocus: true,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
              child: IntField(controller: _quantity, label: t.quantity),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: AmountField(
                controller: _unitPrice,
                label: t.unitPrice,
                suffixText: '€',
              ),
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: 110,
              child: AmountField(
                controller: _taxRate,
                label: t.taxRate,
                suffixText: '%',
              ),
            ),
          ],
        ),
        YaruSwitchListTile(
          title: Text(t.isDiscount),
          value: _isDiscount,
          onChanged: (value) => setState(() => _isDiscount = value),
        ),
      ],
    );
  }

  Future<void> _save() async {
    final price = parseHundredths(_unitPrice.text)!;
    await ref
        .read(serverpodClientProvider)
        .billing
        .addCharge(
          Charge(
            folioId: widget.folio.id!,
            type: _isDiscount ? ChargeType.discount : ChargeType.manual,
            description: _description.text.trim(),
            quantity: int.parse(_quantity.text.trim()),
            // A discount is a charge with a negative price.
            unitPrice: _isDiscount ? -price : price,
            // The server works out the total.
            total: 0,
            taxRate: parseHundredths(_taxRate.text)!,
          ),
        );
  }
}
