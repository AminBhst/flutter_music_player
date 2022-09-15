import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/audio_player_provider.dart';

class PlayerSlider extends StatelessWidget {
  const PlayerSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var audioPlayerProvider = Provider.of<AudioPlayerProvider>(context);
    final mediaQuery = MediaQuery.of(context);
    return SizedBox(
      width: mediaQuery.size.width * 0.92,
      height: 10,
      child: SliderTheme(
        data: const SliderThemeData(
            thumbShape:
            RoundSliderThumbShape(enabledThumbRadius: 5),
            thumbColor: Colors.teal),
        child: Slider(
            autofocus: true,
            inactiveColor:
            const Color.fromRGBO(100, 131, 135, 100),
            activeColor: Colors.white,
            max: audioPlayerProvider.max,
            min: 0.0,
            value: audioPlayerProvider.currentPosition.inSeconds
                .toDouble(),
            onChanged: (position) =>
                audioPlayerProvider.seek(position)),
      ),
    );
  }
}
