import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/components/async_list_view.dart';
import 'package:logbuch_flutter/providers/rooms_provider.dart';
import 'package:yaru/yaru.dart';

class RoomsPanel extends ConsumerWidget {
  const RoomsPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncListView<Room>(
      value: ref.watch(roomsProvider),
      onRetry: () => ref.refresh(roomsProvider.future),
      emptyText: 'No rooms',
      itemBuilder: (context, room) => YaruListTile(
        leading: const Icon(Icons.bed),
        titleText: 'Room ${room.roomNumber}',
        subtitleText:
            '${room.bedAmount} ${room.bedAmount == 1 ? 'bed' : 'beds'}',
      ),
    );
  }
}
