import 'package:flutter/material.dart';
import 'package:flutter_music_player/providers/audio_player_provider.dart';
import 'package:provider/provider.dart';

class ShuffleButton extends StatelessWidget {
  const ShuffleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var audioPlayerProvider = Provider.of<AudioPlayerProvider>(context);
    return IconButton(
        padding: const EdgeInsets.all(1),
        onPressed: audioPlayerProvider.toggleShuffle,
        icon: Icon(Icons.shuffle_rounded,
            color: audioPlayerProvider.shuffle
                ? const Color.fromRGBO(20, 255, 236, 100)
                : Colors.white70));
  }
}
