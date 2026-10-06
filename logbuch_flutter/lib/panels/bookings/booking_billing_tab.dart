import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/panels/admin/admin_formats.dart';
import 'package:logbuch_flutter/panels/admin/admin_widgets.dart';
import 'package:logbuch_flutter/panels/bookings/amount_row.dart';
import 'package:logbuch_flutter/panels/bookings/booking_price_tab.dart';
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
class BookingBillingTab extends ConsumerWidget {
  const BookingBillingTab({super.key, required this.bookingId});

  final int bookingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return switch (ref.watch(foliosProvider(bookingId))) {
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
                      child: _FolioCard(folio: folio),
                    ),
                ],
              ),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }
}

class _FolioCard extends ConsumerWidget {
  const _FolioCard({required this.folio});

  final Folio folio;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.bookings;
    final theme = Theme.of(context);
    final canEdit = ref.watch(canEditProvider);
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

    return YaruSection(
      headline: Row(
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
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
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
                  FilledButton(
                    onPressed: () => _recordPayment(context, ref),
                    child: Text(t.recordPayment),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 4),
          ],
        ),
      ),
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
          FilledButton(
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
          FilledButton(
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
