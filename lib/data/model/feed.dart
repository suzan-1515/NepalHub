import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:samachar_hub/data/model/sources.dart';
import 'package:samachar_hub/util/helper.dart';

part 'feed.g.dart';

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
  final String uuid;
  @JsonKey(required: false)
  final List<Feed> related;

  Feed(
      this.id,
      this.source,
      this.category,
      this.author,
      this.title,
      this.description,
      this.link,
      this.image,
      this.publishedAt,
      this.content,
      this.related,
      this.uuid,);

  String getAuthor() =>
      author == null || author.isEmpty ? formatedSource() : author;

  String formatedPublishedDate() {
    var fomattedDate = publishedAt;
    try {
      fomattedDate = publishedAt.isEmpty
          ? 'N/A'
          : relativeTimeString(DateTime.parse(publishedAt));
    } catch (e) {
      fomattedDate = publishedAt;
    }
    return fomattedDate;
  }

  String formatedSource() =>
      source == null || source.name == null || source.name.isEmpty
          ? 'N/A'
          : source.name;

  String formatedCategory() =>
      category == null || category.name == null || category.name.isEmpty
          ? 'N/A'
          : category.name;

  factory Feed.fromJson(Map<String, dynamic> json, Sources sources) {
    return Feed(
      json['id'] as String,
      json['source'] == null
          ? null
          : FeedSource.fromJson(json['source'] as Map<String, dynamic>),
      json['category'] == null
          ? null
          : FeedCategory.fromJson(json['category'] as Map<String, dynamic>),
      json['author'] as String,
      json['title'] as String,
      json['description'] as String,
      json['link'] as String,
      json['image'] as String,
      json['pub_date'] as String,
      json['content'] as String,
      (json['related'] as List)?.map((e) {
        if (e == null) return null;
        var feed = e as Map<String, dynamic>;
        if (json.containsKey('source')) {
          try {
            var source = sources.sources
                .where((source) =>
                    source.code != null &&
                    source.code == (feed['source'] as String))
                .first;
            feed.update('source', (update) => source.toJson());
          } catch (e) {
            feed.update(
                'source',
                (update) => Map<String, dynamic>.from(
                    {'name': feed['source'], 'code': feed['source']}));
          }
        }
        if (feed.containsKey('category')) {
          try {
            var category = sources.categories
                .where((category) =>
                    category.code != null &&
                    category.code == feed['category'] as String)
                .first;
            feed.update('category', (update) => category.toJson());
          } catch (e) {
            feed.update(
                'category',
                (update) => Map<String, dynamic>.from(
                    {'name': feed['category'], 'code': feed['category']}));
          }
        }
        return Feed.fromJson(e as Map<String, dynamic>, sources);
      })?.toList(),
      json['uuid'] as String,
    );
  }
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
        'related': this.related?.map((e) {
          if (e == null) return [];
          return e.toJson();
        })?.toList(),
        'uuid': this.uuid,
      };

  factory Feed.fromSnapshot(Map<String, dynamic> json) {
    return Feed(
      json['id'] as String,
      json['source'] == null
          ? null
          : FeedSource.fromJson(json['source'] as Map<String, dynamic>),
      json['category'] == null
          ? null
          : FeedCategory.fromJson(json['category'] as Map<String, dynamic>),
      json['author'] as String,
      json['title'] as String,
      json['description'] as String,
      json['link'] as String,
      json['image'] as String,
      json['pub_date'] as String,
      json['content'] as String,
      (json['related'] as List)?.map((e) {
        if (e == null) return null;
        return Feed.fromSnapshot(e as Map<String, dynamic>);
      })?.toList(),
      json['uuid'] as String,
    );
  }
}

@JsonSerializable()
class FeedSource {
  final int id;
  final String name;
  final String code;
  final String icon;
  final int priority;
  final String favicon;

  FeedSource(
      this.id, this.name, this.code, this.icon, this.priority, this.favicon);

  String getFavicon() {
    if (favicon == null) return '';
    return favicon;
  }

  factory FeedSource.fromJson(Map<String, dynamic> json) =>
      _$FeedSourceFromJson(json);
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

  factory FeedCategory.fromJson(Map<String, dynamic> json) =>
      _$FeedCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$FeedCategoryToJson(this);
}
