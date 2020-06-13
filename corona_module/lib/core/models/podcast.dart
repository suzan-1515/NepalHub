import 'package:meta/meta.dart';

class Podcast {
  final String title;
  final String source;
  final String summary;
  final String imageUrl;
  final String audioUrl;

  const Podcast({
    @required this.title,
    @required this.source,
    @required this.summary,
    @required this.imageUrl,
    @required this.audioUrl,
  })  : assert(title != null),
        assert(source != null),
        assert(summary != null),
        assert(imageUrl != null),
        assert(audioUrl != null);

  Podcast copyWith({
    String title,
    String source,
    String summary,
    String imageUrl,
    String audioUrl,
  }) {
    return Podcast(
      title: title ?? this.title,
      source: source ?? this.source,
      summary: summary ?? this.summary,
      imageUrl: imageUrl ?? this.imageUrl,
      audioUrl: audioUrl ?? this.audioUrl,
    );
  }

  static Podcast fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Podcast(
      title: map['title'],
      source: map['source'],
      summary: map['summary'],
      imageUrl: map['image_url'],
      audioUrl: map['audio_url'],
    );
  }

  @override
  String toString() {
    return 'Podcast(title: $title, source: $source, summary: $summary, imageUrl: $imageUrl, audioUrl: $audioUrl)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Podcast &&
        o.title == title &&
        o.source == source &&
        o.summary == summary &&
        o.imageUrl == imageUrl &&
        o.audioUrl == audioUrl;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        source.hashCode ^
        summary.hashCode ^
        imageUrl.hashCode ^
        audioUrl.hashCode;
  }
}
