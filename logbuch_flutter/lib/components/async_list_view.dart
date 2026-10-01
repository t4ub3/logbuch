import 'package:flutter/material.dart';
import 'package:logbuch_flutter/i18n/strings.g.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Shows a list for the given [value], with loading and error states.
/// [onRetry] is called from the error state and by pull-to-refresh.
class AsyncListView<T> extends StatelessWidget {
  const AsyncListView({
    super.key,
    required this.value,
    required this.itemBuilder,
    required this.onRetry,
    this.emptyText,
  });

  final AsyncValue<List<T>> value;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final Future<void> Function() onRetry;
  final String? emptyText;

  @override
  Widget build(BuildContext context) {
    return switch (value) {
      AsyncData(:final value) when value.isEmpty => Center(
        child: Text(emptyText ?? context.t.common.noEntries),
      ),
      AsyncData(:final value) => RefreshIndicator(
        onRefresh: onRetry,
        child: ListView.builder(
          itemCount: value.length,
          itemBuilder: (context, index) => itemBuilder(context, value[index]),
        ),
      ),
      AsyncError(:final error) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(context.t.common.loadFailed(error: error)),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: onRetry,
              child: Text(context.t.common.retry),
            ),
          ],
        ),
      ),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }
}
