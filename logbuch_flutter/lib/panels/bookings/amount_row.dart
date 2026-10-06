import 'package:flutter/material.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/panels/admin/admin_formats.dart';
import 'package:yaru/yaru.dart';

/// A label with an amount of money at the end of the row.
class AmountRow extends StatelessWidget {
  const AmountRow({
    super.key,
    required this.label,
    required this.amount,
    this.detail,
    this.style,
    this.onDelete,
  });

  final String label;

  /// How the amount comes about, shown in front of it.
  final String? detail;

  /// In cents.
  final int amount;
  final TextStyle? style;

  /// Adds a button to remove what the row stands for.
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(label, style: style, overflow: TextOverflow.ellipsis),
        ),
        if (detail case final detail?) ...[
          const SizedBox(width: 12),
          Text(detail, style: Theme.of(context).textTheme.bodySmall),
        ],
        const SizedBox(width: 12),
        SizedBox(
          width: 96,
          child: Text(
            formatMoney(context, amount),
            style: style,
            textAlign: TextAlign.end,
          ),
        ),
        if (onDelete != null)
          IconButton(
            tooltip: context.t.common.delete,
            icon: const Icon(YaruIcons.trash, size: 16),
            visualDensity: VisualDensity.compact,
            onPressed: onDelete,
          ),
      ],
    );
  }
}
