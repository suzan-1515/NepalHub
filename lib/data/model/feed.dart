import 'package:json_annotation/json_annotation.dart';

part 'feed.g.dart';

@JsonSerializable()
class Feed {
  final String id;
  final FeedSource source;
  final FeedCategory category;
  final String author;
  final String title;
  final String description;
  final String link;
  final String image;
  @JsonKey(name: "pub_date")
  final String publishedAt;
  final String content;
  @JsonKey(required: false)
  final List<Feed> related;

  Feed(this.id, this.source, this.category, this.author, 
  this.title, this.description, this.link, this.image, 
  this.publishedAt, this.content,this.related);

  factory Feed.fromJson(Map<String, dynamic> json) => _$FeedFromJson(json);
  Map<String, dynamic> toJson() => _$FeedToJson(this);
}

@JsonSerializable()
class FeedSource {
  final int id;
  final String name;
  final String code;
  final String icon;
  final int priority;
  final String favicon;

  FeedSource(this.id, this.name, this.code, this.icon, this.priority, this.favicon);

  factory FeedSource.fromJson(Map<String, dynamic> json) => _$FeedSourceFromJson(json);
  Map<String, dynamic> toJson() => _$FeedSourceToJson(this);
}

@JsonSerializable()
class FeedCategory {
  final int id;
  final String name;
  @JsonKey(name: "name_np")
  final String nameNp;
  final String code;
  final String icon;
  final int priority;
  final String enable;

  FeedCategory(this.id, this.name, this.nameNp, this.code, this.icon, 
  this.priority, this.enable);

  factory FeedCategory.fromJson(Map<String, dynamic> json) => _$FeedCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$FeedCategoryToJson(this);
}
