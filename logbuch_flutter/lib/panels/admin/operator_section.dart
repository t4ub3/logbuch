import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/panels/admin/admin_formats.dart';
import 'package:logbuch_flutter/panels/admin/admin_widgets.dart';
import 'package:logbuch_flutter/providers/client_provider.dart';
import 'package:logbuch_flutter/providers/current_user_provider.dart';
import 'package:logbuch_flutter/providers/operator_provider.dart';
import 'package:logbuch_flutter/providers/status_provider.dart';
import 'package:yaru/yaru.dart';

/// The details of the organisation that runs the house, as they are printed
/// on invoices and donation receipts.
class OperatorSection extends ConsumerWidget {
  const OperatorSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return switch (ref.watch(operatorProvider)) {
      AsyncError(:final error) => Center(
        child: Text(context.t.common.loadFailed(error: error)),
      ),
      // There is no operator before the form was saved for the first time.
      AsyncData(value: final operator) => _OperatorForm(operator: operator),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }
}

class _OperatorForm extends ConsumerStatefulWidget {
  const _OperatorForm({required this.operator});

  final Operator? operator;

  @override
  ConsumerState<_OperatorForm> createState() => _OperatorFormState();
}

class _OperatorFormState extends ConsumerState<_OperatorForm> {
  Operator? get _operator => widget.operator;

  late final _name = TextEditingController(text: _operator?.name);
  late final _street = TextEditingController(text: _operator?.street);
  late final _zip = TextEditingController(text: _operator?.zip);
  late final _city = TextEditingController(text: _operator?.city);
  late final _taxOffice = TextEditingController(text: _operator?.taxOffice);
  late final _taxNumber = TextEditingController(text: _operator?.taxNumber);
  late final _assessmentPeriod = TextEditingController(
    text: _operator?.assessmentPeriod,
  );
  late final _purposes = TextEditingController(text: _operator?.purposes);
  late final _purposesObject = TextEditingController(
    text: _operator?.purposesObject,
  );
  late final _place = TextEditingController(text: _operator?.place);
  late final _signatory = TextEditingController(text: _operator?.signatory);
  late final _accountHolder = TextEditingController(
    text: _operator?.accountHolder,
  );
  late final _iban = TextEditingController(text: _operator?.iban);
  late final _bic = TextEditingController(text: _operator?.bic);
  late final _bankName = TextEditingController(text: _operator?.bankName);
  late final _paymentTerms = TextEditingController(
    text: _operator?.paymentTerms,
  );
  late final _confirmationNote = TextEditingController(
    text: _operator?.confirmationNote,
  );
  late TaxNoticeType _noticeType =
      _operator?.noticeType ?? TaxNoticeType.statutoryCompliance;
  late DateTime? _noticeDate = switch (_operator?.noticeDate) {
    final date? => toLocalDate(date),
    null => null,
  };
  bool _saving = false;
  Object? _error;

  @override
  void dispose() {
    for (final controller in [
      _name,
      _street,
      _zip,
      _city,
      _taxOffice,
      _taxNumber,
      _assessmentPeriod,
      _purposes,
      _purposesObject,
      _place,
      _signatory,
      _accountHolder,
      _iban,
      _bic,
      _bankName,
      _paymentTerms,
      _confirmationNote,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.admin.operator;
    final theme = Theme.of(context);
    final canEdit = ref.watch(canEditProvider);

    Widget text(
      TextEditingController controller,
      String label, {
      String? hint,
    }) {
      return TextFormField(
        controller: controller,
        readOnly: !canEdit,
        canRequestFocus: canEdit,
        mouseCursor: canEdit ? null : SystemMouseCursors.basic,
        decoration: InputDecoration(labelText: label, helperText: hint),
      );
    }

    final fields = [
      text(_name, context.t.common.name),
      text(_street, t.street),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 130, child: text(_zip, t.zip)),
          const SizedBox(width: 16),
          Expanded(child: text(_city, t.city)),
        ],
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: text(_taxOffice, t.taxOffice)),
          const SizedBox(width: 16),
          Expanded(child: text(_taxNumber, t.taxNumber)),
        ],
      ),
      DropdownButtonFormField<TaxNoticeType>(
        isExpanded: true,
        initialValue: _noticeType,
        decoration: InputDecoration(labelText: t.noticeType),
        items: [
          DropdownMenuItem(
            value: TaxNoticeType.statutoryCompliance,
            child: Text(t.statutoryCompliance),
          ),
          DropdownMenuItem(
            value: TaxNoticeType.exemptionNotice,
            child: Text(t.exemptionNotice),
          ),
        ],
        onChanged: canEdit
            ? (type) => setState(() => _noticeType = type ?? _noticeType)
            : null,
      ),
      DateField(
        label: t.noticeDate,
        date: _noticeDate,
        firstDate: DateTime(2000),
        readOnly: !canEdit,
        onChanged: (date) => setState(() => _noticeDate = date),
      ),
      // Each kind of notice is cited with something the other does not need.
      if (_noticeType == TaxNoticeType.exemptionNotice)
        text(_assessmentPeriod, t.assessmentPeriod),
      text(_purposes, t.purposes, hint: t.purposesHint),
      if (_noticeType == TaxNoticeType.statutoryCompliance)
        text(_purposesObject, t.purposesObject, hint: t.purposesObjectHint),
      text(_place, t.place),
      text(_signatory, t.signatory),
      Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Text(t.bankHint, style: theme.textTheme.bodySmall),
      ),
      text(_accountHolder, t.accountHolder),
      text(_iban, t.iban),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 180, child: text(_bic, t.bic)),
          const SizedBox(width: 16),
          Expanded(child: text(_bankName, t.bankName)),
        ],
      ),
      TextFormField(
        controller: _paymentTerms,
        readOnly: !canEdit,
        canRequestFocus: canEdit,
        mouseCursor: canEdit ? null : SystemMouseCursors.basic,
        minLines: 2,
        maxLines: 5,
        decoration: InputDecoration(
          labelText: t.paymentTerms,
          helperText: t.paymentTermsHint,
        ),
      ),
      TextFormField(
        controller: _confirmationNote,
        readOnly: !canEdit,
        canRequestFocus: canEdit,
        mouseCursor: canEdit ? null : SystemMouseCursors.basic,
        minLines: 2,
        maxLines: 8,
        decoration: InputDecoration(
          labelText: t.confirmationNote,
          helperText: t.confirmationNoteHint,
        ),
      ),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(kYaruPagePadding),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(t.hint, style: theme.textTheme.bodySmall),
              for (final field in fields) ...[
                const SizedBox(height: 16),
                field,
              ],
              if (_error case final error?) ...[
                const SizedBox(height: 16),
                Text(
                  validationMessage(context, error) ??
                      context.t.common.saveFailed(error: error),
                  style: TextStyle(color: theme.colorScheme.error),
                ),
              ],
              if (canEdit) ...[
                const SizedBox(height: 24),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: ElevatedButton.icon(
                    icon: const Icon(YaruIcons.save),
                    label: Text(context.t.common.save),
                    onPressed: _saving ? null : _save,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _save() async {
    final noticeDate = _noticeDate;
    final operator = Operator(
      name: _name.text.trim(),
      street: _street.text.trim(),
      zip: _zip.text.trim(),
      city: _city.text.trim(),
      taxOffice: _taxOffice.text.trim(),
      taxNumber: _taxNumber.text.trim(),
      noticeType: _noticeType,
      noticeDate: noticeDate == null ? null : toUtcDate(noticeDate),
      assessmentPeriod: nullIfBlank(_assessmentPeriod.text),
      purposes: _purposes.text.trim(),
      purposesObject: nullIfBlank(_purposesObject.text),
      place: _place.text.trim(),
      signatory: nullIfBlank(_signatory.text),
      accountHolder: nullIfBlank(_accountHolder.text),
      iban: nullIfBlank(_iban.text),
      bic: nullIfBlank(_bic.text),
      bankName: nullIfBlank(_bankName.text),
      paymentTerms: nullIfBlank(_paymentTerms.text),
      confirmationNote: nullIfBlank(_confirmationNote.text),
    );

    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      await ref.read(serverpodClientProvider).operator.save(operator);
      ref.invalidate(operatorProvider);
      ref.read(statusProvider.notifier).saved();
    } catch (error) {
      if (mounted) setState(() => _error = error);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}
