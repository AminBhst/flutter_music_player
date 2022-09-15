import 'package:flutter/material.dart';
import 'package:flutter_music_player/widgets/single_line_drag_handle.dart';
import 'package:flutter_music_player/widgets/song_queue_item.dart';
import 'package:provider/provider.dart';

import '../providers/audio_player_provider.dart';

class ReorderableSongQueue extends StatefulWidget {
  @override
  State<ReorderableSongQueue> createState() => _ReorderableSongQueueState();
}

class _ReorderableSongQueueState extends State<ReorderableSongQueue> {
  late AudioPlayerProvider playerProvider;

  @override
  Widget build(BuildContext context) {
    playerProvider = Provider.of<AudioPlayerProvider>(context);
    final mediaQuery = MediaQuery.of(context);
    return DraggableScrollableSheet(
      maxChildSize: 0.9,
      builder: (_, ScrollController scrollController) =>
          ListView(controller: scrollController, children: [
        Container(
          height: mediaQuery.size.height * 0.05,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20),
            ),
            color: Color.fromRGBO(21, 21, 21, 1)
          ),
          child: const Center(
            child: SingleLineDragHandle(width: 35),
          ),
        ),
        Container(
          color: const Color.fromRGBO(21, 21, 21, 1),
          padding: const EdgeInsets.only(top: 30),
          height: mediaQuery.size.height * 0.85,
          width: mediaQuery.size.width - 5,
          child: Theme(
            data: ThemeData(canvasColor: Colors.transparent),
            child: ReorderableListView.builder(
              padding: const EdgeInsets.only(top: 1),
              buildDefaultDragHandles: false,
              itemCount: playerProvider.queueLength,
              itemBuilder: (context, index) {
                var queueIndex = index + playerProvider.index! + 1;
                return Dismissible(
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.all(10),
                    color: const Color.fromRGBO(163, 41, 16, 100),
                    child: const Icon(
                      Icons.delete_rounded,
                      color: Colors.white,
                    ),
                  ),
                  key: ValueKey(playerProvider.playlist[queueIndex].id),
                  onDismissed: (direction) =>
                      playerProvider.playlist.removeAt(queueIndex),
                  child: SongQueueItem(
                    audioTrack: playerProvider.playlist[queueIndex],
                    index: index,
                    key: ValueKey(playerProvider.playlist[queueIndex].id),
                  ),
                );
              },
              onReorder: (oldIndex, newIndex) => playerProvider.reorderQueue(oldIndex, newIndex),
            ),
          ),
        ),
      ]),
    );
  }
}
