import 'package:flutter/material.dart';

import '../model/player/audio_track.dart';

class SongQueueItem extends StatelessWidget {
  final AudioTrack audioTrack;
  final int index;

  const SongQueueItem(
      {required this.audioTrack, required this.index, required Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        key: key,
        leading: const Icon(Icons.music_note_sharp, color: Colors.white),
        title: Text(
          audioTrack.title,
          style: const TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          audioTrack.artist,
          style: const TextStyle(color: Colors.grey, fontSize: 11),
        ),
        trailing: ReorderableDragStartListener(
          index: index,
          child: const Icon(Icons.reorder, color: Colors.white),
        ));
  }
}
