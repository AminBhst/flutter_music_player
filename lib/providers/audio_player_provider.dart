import 'dart:io';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:palette_generator/palette_generator.dart';

import '../model/player/audio_track.dart';

//TODO make vars private
class AudioPlayerProvider with ChangeNotifier {
  List<AudioTrack> playlist = [];
  List<AudioTrack> sourcePlaylist = [];
  String? playlistName = "";
  int? _index;
  PlayerState? playerState;
  Duration currentPosition = Duration.zero;
  Duration duration = Duration.zero;
  bool isPlaying = false;
  bool showRemaining = false;
  AudioPlayer? audioPlayer;
  Source? source;
  bool shuffle = false;
  bool repeat = false;
  bool _reachedEnd = false;
  Uint8List? _albumCoverPlaceHolder;
  bool extractAlbumCoverDominantColor;
  Color dominantColor = Colors.transparent;
  Uint8List? nextAlbumCover;
  Uint8List? currentAlbumCover;
  Uint8List? previousAlbumCover;

  AudioPlayerProvider({this.extractAlbumCoverDominantColor = true});

  double get max {
    return duration.inSeconds.toDouble() + 2;
  }

  int get queueLength {
    return playlist.length - _index! - 1;
  }

  int? get index {
    return _index;
  }

  String get positionTime {
    return formatTime(currentPosition.inSeconds.toInt());
  }

  String get timeRemainingOrDuration {
    return showRemaining
        ? formatTime(
            duration.inSeconds.toInt() + 2 - currentPosition.inSeconds.toInt())
        : formatTime(duration.inSeconds.toInt());
  }

  double get progressBarValue {
    return duration.inSeconds.toDouble() != 0
        ? currentPosition.inSeconds.toDouble() / duration.inSeconds.toDouble()
        : 0;
  }

  AudioTrack get audioTrack {
    return playlist[index!];
  }

  Widget get albumCoverImageMinimized {
    return currentAlbumCover != null
        ? Image(image: MemoryImage(currentAlbumCover!))
        : Container();
  }

  void setAlbumCoverPlaceHolder(Uint8List albumCoverPlaceHolder) {
    _albumCoverPlaceHolder = albumCoverPlaceHolder;
  }

  void setExtractAlbumCoverDominantColor(bool value) {
    extractAlbumCoverDominantColor = value;
  }

  void extractDominantColor() async {
    if (!extractAlbumCoverDominantColor) return;
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(
            MemoryImage(currentAlbumCover!));
    dominantColor = paletteGenerator.dominantColor!.color;
  }

  void _decideSource() {
    String? filePath = audioTrack.filePath;
    String? networkUrl = audioTrack.networkUrl;
    if (filePath != null) {
      source = DeviceFileSource(filePath);
    } else if (networkUrl != null) {
      source = UrlSource(networkUrl);
    } else {
      throw Exception(
          'Either filePath or networkUrl has to be set for AudioTrack');
    }
  }

  String formatTime(int seconds) {
    int sec = seconds % 60;
    int min = (seconds / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute : $second";
  }

  void toggleShowRemaining() {
    showRemaining = !showRemaining;
    notifyListeners();
  }

  void listenOnPositionChanged() {
    audioPlayer?.onPositionChanged.listen((pos) {
      currentPosition = pos;
      notifyListeners();
    });
  }

  void listenOnDurationChanged() {
    audioPlayer?.onDurationChanged.listen((duration) {
      this.duration = duration;
    });
  }

  void listenOnPlayerComplete() {
    audioPlayer?.onPlayerComplete.listen((event) {
      currentPosition = Duration(seconds: duration.inSeconds.toInt() + 2);
      notifyListeners();
    });
  }

  void setCurrentPosition(double currentPosition) {
    this.currentPosition = Duration(seconds: currentPosition.toInt());
  }

  void seek(double position) {
    setCurrentPosition(position);
    audioPlayer?.seek(currentPosition);
    if (playerState == PlayerState.stopped) {
      audioPlayer?.resume();
      isPlaying = true;
    }
    notifyListeners();
  }

  void setAudioSource(List<AudioTrack> playlist, int index) {
    this.playlist = [...playlist];
    _index = index;
    sourcePlaylist = playlist;
    notifyListeners();
  }

  void reorderQueue(int oldQueueIndex, int newQueueIndex) {
    oldQueueIndex = oldQueueIndex + _index! + 1;
    newQueueIndex = newQueueIndex + _index! + 1;
    if (newQueueIndex > oldQueueIndex) newQueueIndex--;
    var item = playlist.removeAt(oldQueueIndex);
    playlist.insert(newQueueIndex, item);
  }

  // Convenience method for setting up the audioPlayer with a single audio track
  void setSingleAudioSource(AudioTrack audio) {
    playlist = [audio];
    _index = 0;
  }

  void togglePlay() {
    isPlaying = !isPlaying;
  }

  void toggleShuffle() {
    var currentSongId = audioTrack.id;
    shuffle = !shuffle;
    if (shuffle) {
      playlist.shuffle();
      var shuffledSongIndex =
          playlist.indexWhere((song) => song.id == currentSongId);
      var currentSong = playlist.removeAt(shuffledSongIndex);
      playlist.insert(0, currentSong);
      _index = 0;
    } else {
      playlist = [...sourcePlaylist];
      _index = playlist.indexWhere((song) => song.id == currentSongId);
    }
    notifyListeners();
  }

  void toggleRepeat() {
    repeat = !repeat;
    notifyListeners();
  }

  void listenOnPlayerStateChanged() {
    audioPlayer?.onPlayerStateChanged.listen((playerState) {
      this.playerState = playerState;
      isPlaying = playerState == PlayerState.playing ? true : false;
      if (_reachedEnd && !repeat) isPlaying = false;
    });
  }

  void listenToAllEvents() {
    listenOnPlayerStateChanged();
    listenOnDurationChanged();
    listenOnPlayerComplete();
    listenOnPositionChanged();
  }

  void stopAndReleaseAudioPlayer() async {
    await audioPlayer?.stop();
    await audioPlayer?.release();
    playerState = PlayerState.stopped;
  }

  Future<Uint8List> extractAlbumCover(AudioTrack audioTrack) async {
    var filePath = audioTrack.filePath;
    var networkUrl = audioTrack.networkUrl;
    Uint8List? albumCover;
    if (filePath != null) {
      var metadata = await MetadataRetriever.fromFile(File(filePath));
      albumCover = metadata.albumArt;
    } else if (networkUrl != null) {
      albumCover = _albumCoverPlaceHolder;
    }
    albumCover ??=
        (await rootBundle.load('assets/image/album_cover_placeholder.png'))
            .buffer
            .asUint8List();
    return albumCover;
  }

  void next() async {
    stopAndReleaseAudioPlayer();
    if (playlist.length > index! + 1) {
      _index = index! + 1;
      previousAlbumCover = currentAlbumCover;
      currentAlbumCover = await extractAlbumCover(audioTrack);
      if (_index! + 1 < playlist.length) {
        nextAlbumCover = await extractAlbumCover(playlist[index! + 1]);
      }
    } else {
      _index = 0;
      playlist = [...sourcePlaylist];
      playerState = PlayerState.stopped;
      _reachedEnd = true;
      currentAlbumCover = await extractAlbumCover(audioTrack);
    }
    extractDominantColor();
    isPlaying = false;
    play();
  }

  void previous() async {
    if (currentPosition.inSeconds.toInt() - 2 > 0) {
      seek(0);
    } else if (index! > 0) {
      stopAndReleaseAudioPlayer();
      _index = index! - 1;
      nextAlbumCover = currentAlbumCover;
      currentAlbumCover = await extractAlbumCover(audioTrack);
      if (index! > 0) {
        previousAlbumCover = await extractAlbumCover(playlist[index! - 1]);
      }
      isPlaying = false;
      play();
    } else {
      seek(0);
    }
    extractDominantColor();
    notifyListeners();
  }

  void play() async {
    audioPlayer ??= AudioPlayer();
    _decideSource();
    listenOnDurationChanged();
    if (playerState == PlayerState.playing) {
      await audioPlayer?.pause();
    } else if (playerState == PlayerState.paused) {
      await audioPlayer?.resume();
    } else if (_reachedEnd && repeat || !_reachedEnd && !isPlaying) {
      await audioPlayer?.play(source!);
    }
    togglePlay();
    if (_reachedEnd && !repeat) isPlaying = false;
    _reachedEnd = false;
    notifyListeners();
  }

  void playSong() async {
    audioPlayer ??= AudioPlayer();
    _decideSource();
    listenOnDurationChanged();
    if (audioPlayer?.state == PlayerState.playing) {
      await audioPlayer?.stop();
    }
    currentAlbumCover = await extractAlbumCover(audioTrack);
    await audioPlayer?.play(source!);
    extractDominantColor();
    togglePlay();
    notifyListeners();
  }
}
