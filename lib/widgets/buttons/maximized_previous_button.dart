import 'package:flutter/material.dart';
import 'package:flutter_music_player/providers/audio_player_provider.dart';
import 'package:provider/provider.dart';

class MaximizedPreviousButton extends StatelessWidget {

  const MaximizedPreviousButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var audioPlayerProvider = Provider.of<AudioPlayerProvider>(context);
    return SizedBox(
      height: 50,
      width: 50,
      child: IconButton(
        onPressed: audioPlayerProvider.previous,
        icon: Image.asset('assets/image/previous.png'),
      ),
    );
  }
}
