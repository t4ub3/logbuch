import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:logbuch_flutter/panels/admin/admin_widgets.dart';
import 'package:logbuch_flutter/providers/client_provider.dart';
import 'package:logbuch_flutter/providers/price_categories_provider.dart';
import 'package:yaru/yaru.dart';

class PriceCategoriesSection extends ConsumerWidget {
  const PriceCategoriesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.admin.priceCategories;
    final categories = ref.watch(priceCategoriesProvider);

    return AdminListSection<PriceCategory>(
      value: categories,
      onRetry: () => ref.refresh(priceCategoriesProvider.future),
      emptyText: t.empty,
      addLabel: t.add,
      // New categories go to the end of the list.
      onAdd: () => _edit(
        context,
        ref,
        _PriceCategoryDialog(
          sortOrder: (categories.value ?? []).fold(
            0,
            (next, c) => c.sortOrder >= next ? c.sortOrder + 1 : next,
          ),
        ),
      ),
      itemBuilder: (context, category) => AdminTile(
        icon: YaruIcons.tag,
        title: category.name,
        onEdit: () => _edit(
          context,
          ref,
          _PriceCategoryDialog(
            category: category,
            sortOrder: category.sortOrder,
          ),
        ),
        onDelete: () async {
          final deleted = await confirmAndDelete(
            context,
            name: category.name,
            hint: t.deleteHint,
            delete: () => ref
                .read(serverpodClientProvider)
                .priceCategory
                .delete(category.id!),
          );
          if (deleted) ref.invalidate(priceCategoriesProvider);
        },
      ),
    );
  }

  Future<void> _edit(
    BuildContext context,
    WidgetRef ref,
    _PriceCategoryDialog dialog,
  ) async {
    if (await showAdminDialog(context, dialog)) {
      ref.invalidate(priceCategoriesProvider);
    }
  }
}

class _PriceCategoryDialog extends ConsumerStatefulWidget {
  const _PriceCategoryDialog({this.category, required this.sortOrder});

  /// The category to edit, or null to create one.
  final PriceCategory? category;

  /// The sort order the form starts with.
  final int sortOrder;

  @override
  ConsumerState<_PriceCategoryDialog> createState() =>
      _PriceCategoryDialogState();
}

class _PriceCategoryDialogState extends ConsumerState<_PriceCategoryDialog> {
  late final _name = TextEditingController(text: widget.category?.name);
  late final _sortOrder = TextEditingController(text: '${widget.sortOrder}');

  @override
  void dispose() {
    _name.dispose();
    _sortOrder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.admin.priceCategories;

    return AdminFormDialog(
      title: widget.category == null ? t.add : t.edit,
      onSave: _save,
      children: [
        RequiredTextField(
          controller: _name,
          label: context.t.common.name,
          autofocus: true,
        ),
        IntField(controller: _sortOrder, label: t.sortOrder),
      ],
    );
  }

  Future<void> _save() async {
    final endpoint = ref.read(serverpodClientProvider).priceCategory;
    final category = PriceCategory(
      id: widget.category?.id,
      name: _name.text.trim(),
      sortOrder: int.parse(_sortOrder.text.trim()),
    );
    await (category.id == null
        ? endpoint.add(category)
        : endpoint.update(category));
  }
}
