import 'package:flutter/material.dart';

class MaximizedMusicPlayerAppBar extends StatelessWidget
    with PreferredSizeWidget {
  final Widget? closeButton;

  const MaximizedMusicPlayerAppBar({
    Key? key,
    this.closeButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      foregroundColor: const Color.fromRGBO(33, 33, 33, 100),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      bottomOpacity: 0.0,
      // title: Column(
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     Text(
      //       'Playing from playlist',
      //       textAlign: TextAlign.center,
      //       style: playingFromTextStyle,
      //     ),
      //     const SizedBox(height: 4),
      //     Consumer<AudioPlayerProvider>(
      //       builder: (context, value, child) =>
      //           Text(value.playlistName!, style: playlistNameTextStyle),
      //     ),
      //   ],
      // ),
      centerTitle: true,
      leading: SizedBox(
        width: 20,
        height: 20,
        child: closeButton ?? IconButton(
          iconSize: 35,
          icon: const Icon(Icons.arrow_drop_down),
          color: Colors.white,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
