import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/panels/admin/admin_widgets.dart';
import 'package:logbuch_flutter/panels/bookings/booking_extensions.dart';
import 'package:logbuch_flutter/providers/booking_categories_provider.dart';
import 'package:logbuch_flutter/providers/bookings_provider.dart';
import 'package:logbuch_flutter/providers/client_provider.dart';
import 'package:logbuch_flutter/providers/current_user_provider.dart';
import 'package:yaru/yaru.dart';

/// The categories that bookings are sorted into. They are also created
/// from the form of a booking.
class BookingCategoriesSection extends ConsumerWidget {
  const BookingCategoriesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.admin.bookingCategories;
    final canEdit = ref.watch(canEditProvider);

    return AdminListSection<BookingCategory>(
      value: ref.watch(bookingCategoriesProvider),
      onRetry: () => ref.refresh(bookingCategoriesProvider.future),
      emptyText: t.empty,
      addLabel: t.add,
      onAdd: () => _edit(context, ref),
      // Not an AdminTile, which could not show the icon in its color.
      itemBuilder: (context, category) => YaruListTile(
        leading: Icon(category.icon.data, color: category.color.color),
        titleText: category.name,
        onTap: canEdit ? () => _edit(context, ref, category) : null,
        trailing: !canEdit
            ? null
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    tooltip: context.t.common.edit,
                    icon: const Icon(YaruIcons.pen),
                    onPressed: () => _edit(context, ref, category),
                  ),
                  IconButton(
                    tooltip: context.t.common.delete,
                    icon: const Icon(YaruIcons.trash),
                    onPressed: () async {
                      final deleted = await confirmAndDelete(
                        context,
                        name: category.name,
                        delete: () => ref
                            .read(serverpodClientProvider)
                            .bookingCategory
                            .delete(category.id!),
                      );
                      if (deleted) ref.invalidate(bookingCategoriesProvider);
                    },
                  ),
                ],
              ),
      ),
    );
  }

  Future<void> _edit(
    BuildContext context,
    WidgetRef ref, [
    BookingCategory? category,
  ]) async {
    final dialog = BookingCategoryDialog(category: category);
    if (await showAdminDialog(context, dialog)) {
      ref.invalidate(bookingCategoriesProvider);
      // The bookings come with their category.
      ref.invalidate(bookingsProvider);
    }
  }
}

/// Creates a category, or changes [category]. [onSaved] gets the category
/// as the server stored it.
class BookingCategoryDialog extends ConsumerStatefulWidget {
  const BookingCategoryDialog({super.key, this.category, this.onSaved});

  final BookingCategory? category;
  final ValueChanged<BookingCategory>? onSaved;

  @override
  ConsumerState<BookingCategoryDialog> createState() =>
      _BookingCategoryDialogState();
}

class _BookingCategoryDialogState extends ConsumerState<BookingCategoryDialog> {
  late final _name = TextEditingController(text: widget.category?.name);
  late var _icon = widget.category?.icon ?? BookingCategoryIcon.calendar;
  late var _color = widget.category?.color ?? BookingCategoryColor.blue;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.admin.bookingCategories;
    final theme = Theme.of(context);

    return AdminFormDialog(
      title: widget.category == null ? t.add : t.edit,
      onSave: _save,
      children: [
        RequiredTextField(
          controller: _name,
          label: context.t.common.name,
          autofocus: true,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(t.icon, style: theme.textTheme.bodySmall),
            const SizedBox(height: 4),
            Wrap(
              children: [
                for (final icon in BookingCategoryIcon.values)
                  IconButton(
                    isSelected: icon == _icon,
                    icon: Icon(icon.data),
                    selectedIcon: Icon(icon.data, color: _color.color),
                    style: IconButton.styleFrom(
                      side: icon == _icon
                          ? BorderSide(color: _color.color, width: 2)
                          : null,
                    ),
                    onPressed: () => setState(() => _icon = icon),
                  ),
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(t.color, style: theme.textTheme.bodySmall),
            const SizedBox(height: 4),
            Wrap(
              children: [
                for (final color in BookingCategoryColor.values)
                  YaruColorDisk(
                    color: color.color,
                    selected: color == _color,
                    onPressed: () => setState(() => _color = color),
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _save() async {
    final endpoint = ref.read(serverpodClientProvider).bookingCategory;
    final category = BookingCategory(
      id: widget.category?.id,
      name: _name.text.trim(),
      icon: _icon,
      color: _color,
    );
    final saved = await (category.id == null
        ? endpoint.add(category)
        : endpoint.update(category));
    widget.onSaved?.call(saved);
  }
}
