import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_flutter/components/async_list_view.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/panels/admin/admin_formats.dart';
import 'package:logbuch_flutter/providers/current_user_provider.dart';
import 'package:yaru/yaru.dart';

/// A list of records below a button to add one. Users who may not change
/// data only get the list.
class AdminListSection<T> extends ConsumerWidget {
  const AdminListSection({
    super.key,
    required this.value,
    required this.onRetry,
    required this.emptyText,
    required this.addLabel,
    required this.onAdd,
    required this.itemBuilder,
    this.toolbar,
    this.banner,
  });

  final AsyncValue<List<T>> value;
  final Future<void> Function() onRetry;
  final String emptyText;
  final String addLabel;
  final VoidCallback onAdd;
  final Widget Function(BuildContext context, T item) itemBuilder;

  /// Shown in front of the button, e.g. a search field.
  final Widget? toolbar;

  /// Shown between the button and the list, e.g. for a warning.
  final Widget? banner;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canEdit = ref.watch(canEditProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (canEdit || toolbar != null)
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(child: toolbar ?? const SizedBox.shrink()),
                if (canEdit) ...[
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    icon: const Icon(YaruIcons.plus),
                    label: Text(addLabel),
                    onPressed: onAdd,
                  ),
                ],
              ],
            ),
          ),
        ?banner,
        Expanded(
          child: AsyncListView<T>(
            value: value,
            onRetry: onRetry,
            emptyText: emptyText,
            itemBuilder: itemBuilder,
          ),
        ),
      ],
    );
  }
}

/// A record of an [AdminListSection]. Tapping it edits the record, if the
/// user may change data.
class AdminTile extends ConsumerWidget {
  const AdminTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onEdit,
    required this.onDelete,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.common;
    final canEdit = ref.watch(canEditProvider);

    return YaruListTile(
      leading: Icon(icon),
      titleText: title,
      subtitleText: subtitle,
      onTap: canEdit ? onEdit : null,
      trailing: !canEdit
          ? null
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  tooltip: t.edit,
                  icon: const Icon(YaruIcons.pen),
                  onPressed: onEdit,
                ),
                IconButton(
                  tooltip: t.delete,
                  icon: const Icon(YaruIcons.trash),
                  onPressed: onDelete,
                ),
              ],
            ),
    );
  }
}

/// Shows [dialog], an [AdminFormDialog], and returns whether it was saved.
Future<bool> showAdminDialog(BuildContext context, Widget dialog) async {
  final saved = await showDialog<bool>(
    context: context,
    builder: (context) => dialog,
  );
  return saved ?? false;
}

/// Asks whether the record called [name] should be deleted and runs [delete]
/// if so. Returns whether the record was deleted; a failure is shown in a
/// snack bar.
Future<bool> confirmAndDelete(
  BuildContext context, {
  required String name,
  String? hint,
  required Future<void> Function() delete,
}) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(context.t.admin.deleteTitle(name: name)),
      content: hint == null ? null : Text(hint),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(context.t.common.cancel),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(context.t.common.delete),
        ),
      ],
    ),
  );
  if (confirmed != true) return false;

  try {
    await delete();
    return true;
  } catch (error) {
    if (!context.mounted) return false;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          validationMessage(context, error) ??
              context.t.common.deleteFailed(error: error),
        ),
      ),
    );
    return false;
  }
}

/// A dialog with a form made of [children]. Once the form is valid it is
/// saved with [onSave] and the dialog closes with true; if saving fails the
/// error is shown below the fields.
class AdminFormDialog extends StatefulWidget {
  const AdminFormDialog({
    super.key,
    required this.title,
    required this.children,
    required this.onSave,
  });

  final String title;
  final List<Widget> children;
  final Future<void> Function() onSave;

  @override
  State<AdminFormDialog> createState() => _AdminFormDialogState();
}

class _AdminFormDialogState extends State<AdminFormDialog> {
  final _formKey = GlobalKey<FormState>();
  bool _saving = false;
  Object? _error;

  @override
  Widget build(BuildContext context) {
    final t = context.t.common;

    return AlertDialog(
      title: Text(widget.title),
      content: SizedBox(
        width: 420,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final (index, child) in widget.children.indexed) ...[
                  // Leaves room for the floating label of the first field.
                  SizedBox(height: index == 0 ? 8 : 16),
                  child,
                ],
                if (_error case final error?) ...[
                  const SizedBox(height: 16),
                  Text(
                    validationMessage(context, error) ??
                        t.saveFailed(error: error),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _saving ? null : () => Navigator.pop(context, false),
          child: Text(t.cancel),
        ),
        FilledButton(
          onPressed: _saving ? null : _save,
          child: Text(t.save),
        ),
      ],
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      await widget.onSave();
      if (mounted) Navigator.pop(context, true);
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _saving = false;
        _error = error;
      });
    }
  }
}

/// A required one-line text field.
class RequiredTextField extends StatelessWidget {
  const RequiredTextField({
    super.key,
    required this.controller,
    required this.label,
    this.autofocus = false,
  });

  final TextEditingController controller;
  final String label;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: autofocus,
      decoration: InputDecoration(labelText: label),
      validator: (value) => value == null || value.trim().isEmpty
          ? context.t.common.required
          : null,
    );
  }
}

/// A field for a whole number that is not negative. It may only be left
/// empty if it is [optional].
class IntField extends StatelessWidget {
  const IntField({
    super.key,
    required this.controller,
    required this.label,
    this.optional = false,
    this.helperText,
  });

  final TextEditingController controller;
  final String label;
  final bool optional;
  final String? helperText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(labelText: label, helperText: helperText),
      validator: (value) {
        final text = value?.trim() ?? '';
        if (text.isEmpty) return optional ? null : context.t.common.required;
        return int.tryParse(text) == null
            ? context.t.admin.invalidNumber
            : null;
      },
    );
  }
}

/// A required field for an amount with up to two decimals, read with
/// [parseHundredths].
class AmountField extends StatelessWidget {
  const AmountField({
    super.key,
    required this.controller,
    required this.label,
    required this.suffixText,
  });

  final TextEditingController controller;
  final String label;
  final String suffixText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: label, suffixText: suffixText),
      validator: (value) {
        final text = value?.trim() ?? '';
        if (text.isEmpty) return context.t.common.required;
        return parseHundredths(text) == null
            ? context.t.admin.invalidAmount
            : null;
      },
    );
  }
}

/// A field that picks a single day, kept as a local date. It can be cleared
/// again.
class DateField extends StatelessWidget {
  const DateField({
    super.key,
    required this.label,
    required this.date,
    required this.onChanged,
    this.firstDate,
  });

  final String label;
  final DateTime? date;
  final ValueChanged<DateTime?> onChanged;

  /// The earliest day that can be picked; ten years ago if not given.
  final DateTime? firstDate;

  @override
  Widget build(BuildContext context) {
    final date = this.date;

    return InkWell(
      onTap: () => _pick(context),
      child: InputDecorator(
        isEmpty: date == null,
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: date == null
              ? const Icon(Icons.event)
              : IconButton(
                  tooltip: context.t.common.clear,
                  icon: const Icon(Icons.clear),
                  onPressed: () => onChanged(null),
                ),
        ),
        child: date == null
            ? null
            : Text(MaterialLocalizations.of(context).formatShortDate(date)),
      ),
    );
  }

  Future<void> _pick(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: firstDate ?? DateTime(now.year - 10),
      lastDate: DateTime(now.year + 10),
    );
    if (picked != null) onChanged(picked);
  }
}
