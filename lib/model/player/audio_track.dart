import 'dart:typed_data';

class AudioTrack {
  final Object id;
  final String title;
  final String artist;
  final Duration duration;
  String? networkUrl;
  String? filePath;
  Uint8List? albumCover;

  AudioTrack(
    this.id, {
    required this.title,
    required this.artist,
    required this.duration,
    this.networkUrl,
    this.filePath,
  });
}
