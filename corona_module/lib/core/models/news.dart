import 'package:meta/meta.dart';

class News {
  final String id;
  final String lang;
  final String url;
  final String title;
  final String source;
  final String summary;
  final String imageUrl;
  final DateTime createdAt;

  News({
    @required this.id,
    @required this.lang,
    @required this.url,
    @required this.title,
    @required this.source,
    @required this.summary,
    @required this.imageUrl,
    @required this.createdAt,
  });

  News copyWith({
    String id,
    String lang,
    String url,
    String title,
    String source,
    String summary,
    String imageUrl,
    DateTime createdAt,
  }) {
    return News(
      id: id ?? this.id,
      lang: lang ?? this.lang,
      url: url ?? this.url,
      title: title ?? this.title,
      source: source ?? this.source,
      summary: summary ?? this.summary,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  static News fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return News(
      id: map['_id'],
      lang: map['lang'],
      url: map['url'],
      title: map['title'],
      source: map['source'],
      summary: map['summary'],
      imageUrl: map['image_url'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  @override
  String toString() {
    return 'News(id: $id, lang: $lang, url: $url, title: $title, source: $source, summary: $summary, imageUrl: $imageUrl, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is News &&
        o.id == id &&
        o.lang == lang &&
        o.url == url &&
        o.title == title &&
        o.source == source &&
        o.summary == summary &&
        o.imageUrl == imageUrl &&
        o.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        lang.hashCode ^
        url.hashCode ^
        title.hashCode ^
        source.hashCode ^
        summary.hashCode ^
        imageUrl.hashCode ^
        createdAt.hashCode;
  }
}
