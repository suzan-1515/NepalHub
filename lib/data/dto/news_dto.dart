import 'package:flutter/material.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:uuid/uuid.dart';

class Feed {
  final FeedApiResponse rawData;
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
  final List<Feed> related;
  ValueNotifier<bool> bookmarked = ValueNotifier(false);
  ValueNotifier<bool> liked = ValueNotifier(false);
  String tag = Uuid().v4();

  Feed(this.rawData,
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

  Map<String, dynamic> toJson() {
    var data = this.rawData.toJson();
    data['bookmarked'] = this.bookmarked.value;
    data['liked'] = this.liked.value;
    return data;
  }
}

class FeedSource {
  final int id;
  final String name;
  final String code;
  final String icon;
  final int priority;
  final String favicon;
  final FeedSourceApiResponse rawData;
  final ValueNotifier<bool> enabled = ValueNotifier<bool>(true);

  FeedSource(
      {@required this.id,
      @required this.name,
      @required this.code,
      @required this.icon,
      @required this.priority,
      @required this.favicon,
      @required this.rawData,
      bool enabled = true}) {
    this.enabled.value = enabled;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': this.id,
        'name': this.name,
        'code': this.code,
        'icon': this.icon,
        'priority': this.priority,
        'favicon': this.favicon,
        'enable': this.enabled.value,
      };
}

class FeedCategory {
  final int id;
  final String name;
  final String code;
  final String icon;
  final int priority;
  final FeedCategoryApiResponse rawData;
  final ValueNotifier<bool> enabled = ValueNotifier<bool>(true);
  FeedCategory(
      {@required this.id,
      @required this.name,
      @required this.code,
      @required this.icon,
      @required this.priority,
      @required this.rawData,
      bool enable = true}) {
    this.enabled.value = enable;
  }
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': this.id,
        'name': this.name,
        'code': this.code,
        'icon': this.icon,
        'priority': this.priority,
        'enable': this.enabled.value,
      };
}

class NewsTopics extends NewsTopicsApiResponse {
  NewsTopics(List<String> tags) : super(tags);
}
