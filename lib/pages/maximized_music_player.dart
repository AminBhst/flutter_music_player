import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:flutter_music_player/providers/audio_player_provider.dart';
import 'package:flutter_music_player/widgets/buttons/maximized_next_button.dart';
import 'package:flutter_music_player/widgets/buttons/maximized_play_button.dart';
import 'package:flutter_music_player/widgets/buttons/maximized_previous_button.dart';
import 'package:flutter_music_player/widgets/maximized_album_cover.dart';
import 'package:flutter_music_player/widgets/maximized_music_player_app_bar.dart';
import 'package:flutter_music_player/widgets/player_slider.dart';
import 'package:provider/provider.dart';

import '../model/customizer/player_customizer.dart';

class MaximizedMusicPlayer extends StatefulWidget {
  final PlayerCustomizer playerCustomizer;
  final Widget playPauseButton;
  final Widget nextButton;
  final Widget previousButton;
  final Widget albumCover;
  final Decoration backgroundDecoration;
  final Widget playerSlider;
  final PreferredSizeWidget appbar;
  final TextStyle songTitleTextStyle;
  final TextStyle artistNameTextStyle;
  final TextStyle songDurationTextStyle;
  final TextStyle songPositionTextStyle;

  @override
  State<MaximizedMusicPlayer> createState() => _MaximizedMusicPlayerState();

  const MaximizedMusicPlayer(
      {Key? key,
      required this.playerCustomizer,
      this.playPauseButton = const MaximizedPlayButton(),
      this.nextButton = const MaximizedNextButton(),
      this.previousButton = const MaximizedPreviousButton(),
      this.albumCover = const MaximizedAlbumCover(),
      this.appbar = const MaximizedMusicPlayerAppBar(),
      this.playerSlider = const PlayerSlider(),
      this.artistNameTextStyle = const TextStyle(color: Colors.white),
      this.backgroundDecoration = const BoxDecoration(
        color: Color.fromRGBO(32, 32, 32, 1),
      ),
      this.songTitleTextStyle = const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      this.songDurationTextStyle = const TextStyle(
        color: Colors.grey,
        fontSize: 13,
      ),
      this.songPositionTextStyle = const TextStyle(
        color: Colors.grey,
        fontSize: 13,
      )})
      : super(key: key);
}

class _MaximizedMusicPlayerState extends State<MaximizedMusicPlayer> {
  late AudioPlayerProvider audioPlayerProvider;

  @override
  void didChangeDependencies() {
    audioPlayerProvider = Provider.of<AudioPlayerProvider>(context);
    audioPlayerProvider.listenToAllEvents();
    super.didChangeDependencies();
  }

  Widget _buildSongTitle(String title) {
    return title.length > 17
        ? Container(
            width: 180,
            height: 50,
            alignment: Alignment.center,
            margin: const EdgeInsets.all(1),
            child: Marquee(
              text: title,
              style: widget.songTitleTextStyle,
              blankSpace: 90,
            ))
        : Text(title, style: widget.songTitleTextStyle);
  }

  Widget _buildArtistName(String artist) {
    return artist.length > 36
        ? Container(
            width: 180,
            height: 15,
            alignment: Alignment.center,
            margin: const EdgeInsets.all(1),
            child: Marquee(
              text: artist,
              style: widget.artistNameTextStyle,
              blankSpace: 90,
            ))
        : Container(
            margin: const EdgeInsets.all(1),
            child: Text(
              artist,
              style: widget.artistNameTextStyle,
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return AnimatedContainer(
      decoration: widget.backgroundDecoration,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
      child: Scaffold(
        appBar: widget.appbar,
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.albumCover,
                    const SizedBox(height: 15),
                    SizedBox(
                      width: mediaQuery.size.width * 0.88,
                      height: 30,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Align(
                              alignment: Alignment.center,
                              child: _buildSongTitle(
                                audioPlayerProvider.audioTrack.title,
                              )),
                          Align(
                            alignment: Alignment.centerRight,
                            child: widget.playerCustomizer.row1col2,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: widget.playerCustomizer.row1col1,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 3),
                    Align(
                      alignment: Alignment.center,
                      child: _buildArtistName(
                          audioPlayerProvider.audioTrack.artist),
                    ),
                    mediaQuery.size.height > 870
                        ? SizedBox(height: mediaQuery.size.height * 0.02)
                        : const SizedBox(height: 10),
                    SizedBox(
                      width: mediaQuery.size.width * 0.88,
                      child: Row(
                        children: [
                          Container(child: widget.playerCustomizer.row2col1),
                          const SizedBox(width: 1),
                          Container(child: widget.playerCustomizer.row2col2),
                          const Spacer(),
                          Container(child: widget.playerCustomizer.row2col3),
                          const SizedBox(width: 1),
                          Container(child: widget.playerCustomizer.row2col4)
                        ],
                      ),
                    ),
                    widget.playerCustomizer.row3Exists
                        ? SizedBox(
                            width: mediaQuery.size.width * 0.88,
                            height: 60,
                            child: Row(
                              children: [
                                Container(
                                    child: widget.playerCustomizer.row3col1),
                                const SizedBox(width: 1),
                                Container(
                                    child: widget.playerCustomizer.row3col2),
                                const Spacer(),
                                Container(
                                    child: widget.playerCustomizer.row3col3),
                                const SizedBox(width: 1),
                                Container(
                                    child: widget.playerCustomizer.row3col4)
                              ],
                            ),
                          )
                        : const SizedBox(height: 10),
                    Container(
                      margin:
                          EdgeInsets.only(top: mediaQuery.size.height * 0.02),
                      child: widget.playerSlider,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: SizedBox(
                          width: mediaQuery.size.width * 0.80,
                          child: Row(
                            children: [
                              Text(
                                audioPlayerProvider.positionTime,
                                style: widget.songPositionTextStyle,
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: audioPlayerProvider.toggleShowRemaining,
                                child: Text(
                                  audioPlayerProvider.timeRemainingOrDuration,
                                  style: widget.songDurationTextStyle,
                                ),
                              ),
                            ],
                          )),
                    ),
                    mediaQuery.size.height < 610
                        ? SizedBox(height: mediaQuery.size.height * 0.01)
                        : SizedBox(height: mediaQuery.size.height * 0.05),
                    SizedBox(
                      width: mediaQuery.size.width * 0.88,
                      height: 80,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Align(
                              alignment: Alignment.center,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  widget.previousButton,
                                  widget.playPauseButton,
                                  widget.nextButton
                                ],
                              )),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: widget.playerCustomizer.row4col1,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: widget.playerCustomizer.row4col2,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: mediaQuery.size.width * 0.88,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(child: widget.playerCustomizer.row5col1),
                      const SizedBox(width: 1),
                      Container(child: widget.playerCustomizer.row5col2),
                      const Spacer(),
                      Container(child: widget.playerCustomizer.row5col3),
                      const SizedBox(width: 1),
                      Container(child: widget.playerCustomizer.row5col4),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
