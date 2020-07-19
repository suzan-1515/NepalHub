import 'package:flutter/material.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:uuid/uuid.dart';

class NewsFeedModel {
  final Map<String, dynamic> rawData;
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
  final List<NewsFeedModel> related;
  ValueNotifier<bool> bookmarked = ValueNotifier(false);
  ValueNotifier<bool> liked = ValueNotifier(false);
  String tag = Uuid().v4();

  NewsFeedModel(this.rawData,
      {@required this.id,
      @required this.source,
      @required this.sourceFavicon,
      @required this.category,
      @required this.author,
      @required this.title,
      @required this.description,
      @required this.link,
      @required this.image,
      @required this.publishedAt,
      @required this.content,
      @required this.uuid,
      @required this.related,
      bool bookmarked = false,
      bool liked = false}) {
    this.bookmarked.value = bookmarked;
    this.liked.value = liked;
  }

  Map<String, dynamic> toJson() => this.rawData;
}

class NewsSourceModel {
  final int id;
  final String name;
  final String code;
  final String icon;
  final int priority;
  final String favicon;
  final FeedSourceApiResponse rawData;
  final int followerCount;
  final bool isFollowed;

  NewsSourceModel({
    @required this.id,
    @required this.name,
    @required this.code,
    @required this.icon,
    @required this.priority,
    @required this.favicon,
    @required this.rawData,
    @required this.isFollowed,
    @required this.followerCount,
  });

  NewsSourceModel copyWith({
    int id,
    String name,
    String code,
    String icon,
    int priority,
    String favicon,
    FeedSourceApiResponse rawData,
    int followerCount,
    bool isFollowed,
  }) =>
      NewsSourceModel(
          id: id ?? this.id,
          name: name ?? this.name,
          code: code ?? this.code,
          icon: icon ?? this.icon,
          priority: priority ?? this.priority,
          favicon: favicon ?? this.favicon,
          rawData: rawData ?? this.rawData,
          followerCount: followerCount ?? this.followerCount,
          isFollowed: isFollowed ?? this.isFollowed);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': this.id,
        'name': this.name,
        'code': this.code,
        'icon': this.icon,
        'priority': this.priority,
        'favicon': this.favicon,
        'enable': isFollowed,
      };
}

class NewsCategoryModel {
  final int id;
  final String name;
  final String code;
  final IconData icon;
  final int priority;
  final FeedCategoryApiResponse rawData;
  final int followerCount;
  final bool isFollowed;

  NewsCategoryModel({
    @required this.id,
    @required this.name,
    @required this.code,
    @required this.icon,
    @required this.priority,
    @required this.rawData,
    @required this.isFollowed,
    @required this.followerCount,
  });

  NewsCategoryModel copyWith({
    int id,
    String name,
    String code,
    String icon,
    int priority,
    FeedSourceApiResponse rawData,
    int followerCount,
    bool isFollowed,
  }) =>
      NewsCategoryModel(
          id: id ?? this.id,
          name: name ?? this.name,
          code: code ?? this.code,
          icon: icon ?? this.icon,
          priority: priority ?? this.priority,
          rawData: rawData ?? this.rawData,
          followerCount: followerCount ?? this.followerCount,
          isFollowed: isFollowed ?? this.isFollowed);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': this.id,
        'name': this.name,
        'code': this.code,
        'icon': this.icon,
        'priority': this.priority,
        'enable': this.isFollowed,
      };
}

class NewsTopicModel {
  final String tag;
  final String icon;
  final int followerCount;
  final bool isFollowed;
  NewsTopicModel({
    @required this.tag,
    @required this.icon,
    @required this.followerCount,
    @required this.isFollowed,
  });
  NewsTopicModel copyWith({
    String tag,
    String icon,
    int followerCount,
    bool isFollowed,
  }) =>
      NewsTopicModel(
          tag: tag ?? this.tag,
          icon: icon ?? this.icon,
          followerCount: followerCount ?? this.followerCount,
          isFollowed: isFollowed ?? this.isFollowed);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'tag': this.tag,
        'icon': this.icon,
        'follower_count': this.followerCount,
        'is_followed': this.isFollowed,
      };
}
