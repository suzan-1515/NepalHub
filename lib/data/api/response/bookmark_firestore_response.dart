import 'package:samachar_hub/data/api/response/news_api_response.dart';

class BookmarkFirestoreResponse extends FeedApiResponse {
  final String timestamp;
  final String userid;

  BookmarkFirestoreResponse(
      String id,
      FeedSourceApiResponse source,
      FeedCategoryApiResponse category,
      String author,
      String title,
      String description,
      String link,
      String image,
      String publishedAt,
      String content,
      String uuid,
      this.userid,
      this.timestamp)
      : super(id, source, category, author, title, description, link, image,
            publishedAt, content, null, uuid);

  factory BookmarkFirestoreResponse.fromJson(Map<String, dynamic> json) =>
      BookmarkFirestoreResponse(
        json['id'] as String,
        json['source'] == null
            ? null
            : FeedSourceApiResponse.fromJson(
                json['source'] as Map<String, dynamic>),
        json['category'] == null
            ? null
            : FeedCategoryApiResponse.fromJson(
                json['category'] as Map<String, dynamic>),
        json['author'] as String,
        json['title'] as String,
        json['description'] as String,
        json['link'] as String,
        json['image'] as String,
        json['pub_date'] as String,
        json['content'] as String,
        json['uuid'] as String,
        json['user_id'],
        json['timestamp'],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': this.id,
        'source': this.source.toJson(),
        'category': this.category.toJson(),
        'author': this.author,
        'title': this.title,
        'description': this.description,
        'link': this.link,
        'image': this.image,
        'pub_date': this.publishedAt,
        'content': this.content,
        'uuid': this.uuid,
        'timestamp': this.timestamp,
        'user_id': this.userid,
      };
}
