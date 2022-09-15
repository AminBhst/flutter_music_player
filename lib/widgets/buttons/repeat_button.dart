import 'package:flutter/material.dart';
import 'package:flutter_music_player/providers/audio_player_provider.dart';
import 'package:provider/provider.dart';

class RepeatButton extends StatelessWidget {
  const RepeatButton({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var audioPlayerProvider = Provider.of<AudioPlayerProvider>(context);
    return IconButton(
        onPressed: audioPlayerProvider.toggleRepeat,
        icon: Icon(
          Icons.repeat,
          color: audioPlayerProvider.repeat
              ? const Color.fromRGBO(20, 255, 236, 100)
              : Colors.white70,
        ));
  }
}
