import 'package:flutter/material.dart';
import 'package:flutter_music_player/providers/audio_player_provider.dart';
import 'package:provider/provider.dart';


class MaximizedNextButton extends StatelessWidget {

  const MaximizedNextButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var audioPlayerProvider = Provider.of<AudioPlayerProvider>(context);
    return SizedBox(
      height: 50,
      width: 50,
      child: IconButton(
        onPressed: audioPlayerProvider.next,
        icon: Image.asset('assets/image/next.png'),
      ),
    );
  }
}
