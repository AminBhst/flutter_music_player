import 'package:flutter/material.dart';
import 'package:flutter_music_player/widgets/reorderable_song_queue.dart';

class QueueButton extends StatelessWidget {
  const QueueButton({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              backgroundColor: Colors.transparent,
              context: context,
              builder: (context) => ReorderableSongQueue());
        },
        icon: const Icon(
          Icons.queue_music_rounded,
          color: Colors.white70,
        ));
  }
}
