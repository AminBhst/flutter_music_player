import 'package:flutter/material.dart';
import 'package:flutter_music_player/providers/audio_player_provider.dart';
import 'package:provider/provider.dart';

class MinimizedPlayerPlayPauseButton extends StatelessWidget {
  const MinimizedPlayerPlayPauseButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var audioPlayerProvider = Provider.of<AudioPlayerProvider>(context);
    return IconButton(
      onPressed: audioPlayerProvider.play,
      icon: audioPlayerProvider.isPlaying
          ? const Icon(
        Icons.pause,
        color: Colors.white,
      )
          : const Icon(
        Icons.play_arrow_rounded,
        color: Colors.white,
      ),
    );
  }
}
