import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/audio_player_provider.dart';

class MaximizedAlbumCover extends StatelessWidget {
  final BorderRadius borderRadius;

  const MaximizedAlbumCover({
    Key? key,
    this.borderRadius = BorderRadius.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isDesktop = mediaQuery.size.width > 800;
    var height = mediaQuery.size.height;
    var width = mediaQuery.size.width;
    var audioTrackPlayer = Provider.of<AudioPlayerProvider>(context);
    return ClipRRect(
            borderRadius: borderRadius,
            child: Container(
              width: isDesktop
                  ? height * 0.5
                  : width * 0.7 / (mediaQuery.size.aspectRatio * 2),
              height: isDesktop
                  ? height * 0.5
                  : width * 0.7 / (mediaQuery.size.aspectRatio * 2),
              decoration: BoxDecoration(
                image: DecorationImage(
                  scale: 0.5,
                  image: MemoryImage(audioTrackPlayer.currentAlbumCover!),
                ),
              ),
            ),
          );
  }
}
