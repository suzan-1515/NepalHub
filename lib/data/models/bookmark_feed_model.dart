import 'package:samachar_hub/data/api/api.dart';

class BookmarkFeedModel {
  final BookmarkFirestoreResponse rawData;
  final String id;
  final String source;
  final String sourceFavicon;
  final String category;
  final String author;
  final String title;
  final String description;
  final String link;
  final String image;
  final String publishedAt;
  final String content;
  final String uuid;
  final String userId;
  final String timestamp;

  BookmarkFeedModel(
      this.rawData,
      {
      this.id,
      this.source,
      this.sourceFavicon,
      this.category,
      this.author,
      this.title,
      this.description,
      this.link,
      this.image,
      this.publishedAt,
      this.content,
      this.uuid,
      this.userId,
      this.timestamp});

  Map<String, dynamic> toJson() => rawData.toJson();
}
