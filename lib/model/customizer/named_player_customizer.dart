import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_music_player/model/customizer/player_customizer.dart';

class NamedPlayerCustomizer extends PlayerCustomizer {
  Widget? songTitleRowLeft;
  Widget? songTitleRowRight;
  Widget? midRowLeft;
  Widget? midRowFarLeft;
  Widget? midRowRight;
  Widget? midRowFarRight;
  Widget? secondMidRowFarLeft;
  Widget? secondMidRowLeft;
  Widget? secondMidRowFarRight;
  Widget? secondMidRowRight;
  Widget? playButtonRowLeft;
  Widget? playButtonRowRight;
  Widget? bottomFarLeft;
  Widget? bottomLeft;
  Widget? bottomFarRight;
  Widget? bottomRight;

  NamedPlayerCustomizer({
    this.songTitleRowLeft,
    this.songTitleRowRight,
    this.midRowLeft,
    this.midRowFarLeft,
    this.midRowRight,
    this.midRowFarRight,
    this.secondMidRowFarLeft,
    this.secondMidRowLeft,
    this.secondMidRowFarRight,
    this.secondMidRowRight,
    this.playButtonRowLeft,
    this.playButtonRowRight,
    this.bottomFarLeft,
    this.bottomLeft,
    this.bottomFarRight,
    this.bottomRight,
  });

  @override
  Widget? get row1col1 => songTitleRowLeft;

  @override
  Widget? get row1col2 => songTitleRowRight;

  @override
  Widget? get row2col1 => midRowFarLeft;

  @override
  Widget? get row2col2 => midRowLeft;

  @override
  Widget? get row2col3 => midRowRight;

  @override
  Widget? get row2col4 => midRowFarRight;

  @override
  Widget? get row3col1 => secondMidRowFarLeft;

  @override
  Widget? get row3col2 => secondMidRowLeft;

  @override
  Widget? get row3col3 => secondMidRowRight;

  @override
  Widget? get row3col4 => secondMidRowFarRight;

  @override
  Widget? get row4col1 => playButtonRowLeft;

  @override
  Widget? get row4col2 => playButtonRowRight;

  @override
  Widget? get row5col1 => bottomFarLeft;

  @override
  Widget? get row5col2 => bottomLeft;

  @override
  Widget? get row5col3 => bottomRight;

  @override
  Widget? get row5col4 => bottomFarRight;
}
