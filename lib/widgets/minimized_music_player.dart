import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/maximized_music_player.dart';
import '../providers/audio_player_provider.dart';
import 'buttons/minimized_player_play_pause_button.dart';

class MinimizedMusicPlayer extends StatefulWidget {
  Widget? playPauseButton;
  Widget? nextButton;
  Widget? previousButton;
  BorderRadius borderRadius;
  Color color;
  TextStyle songTitleTextStyle;
  TextStyle artistNameTextStyle;
  Color progressBarBackgroundColor;
  Color progressBarColor;
  VoidCallback onTab;


  MinimizedMusicPlayer({
    this.playPauseButton = const MinimizedPlayerPlayPauseButton(),
    this.nextButton,
    this.previousButton,
    this.borderRadius = BorderRadius.zero,
    this.color = Colors.black12,
    this.songTitleTextStyle = const TextStyle(color: Colors.white),
    this.artistNameTextStyle = const TextStyle(color: Color.fromRGBO(235, 253, 255, 1)),
    this.progressBarBackgroundColor = Colors.white10,
    this.progressBarColor = Colors.white,
    required this.onTab,
  });

  @override
  State<MinimizedMusicPlayer> createState() => _MinimizedMusicPlayerState();
}

class _MinimizedMusicPlayerState extends State<MinimizedMusicPlayer> {
  late AudioPlayerProvider audioPlayerProvider;
  MaximizedMusicPlayer? maximizedMusicPlayer;
  var hide = false;

  @override
  void didChangeDependencies() {
    audioPlayerProvider = Provider.of<AudioPlayerProvider>(context);
    audioPlayerProvider.listenToAllEvents();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return hide
        ? Container()
        : GestureDetector(
            onTap: widget.onTab,
            child: AnimatedContainer(
              decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: widget.borderRadius),
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ListTile(
                      dense: true,
                      contentPadding:
                          const EdgeInsets.only(left: 10, right: 4),
                      leading: CircleAvatar(
                          backgroundColor:
                              const Color.fromRGBO(10, 14, 23, 100),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            child: audioPlayerProvider.albumCoverImageMinimized,
                          )),
                      title: Text(
                        audioPlayerProvider.audioTrack.title,
                        style: widget.songTitleTextStyle,
                      ),
                      subtitle: Text(
                        audioPlayerProvider.audioTrack.artist,
                        style: widget.artistNameTextStyle,
                      ),
                      trailing: SizedBox(
                        width: 150,
                        child: Row(
                          children: [
                            if (widget.previousButton == null)
                              const Spacer(),
                            Container(child: widget.previousButton),
                            Container(child: widget.playPauseButton),
                            Container(child: widget.nextButton)
                          ],
                        ),
                      )),
                  SizedBox(
                    child: LinearProgressIndicator(
                      value: audioPlayerProvider.progressBarValue,
                      color: widget.progressBarColor,
                      backgroundColor: widget.progressBarBackgroundColor,
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
