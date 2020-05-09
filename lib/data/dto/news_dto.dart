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

class FeedSource extends FeedSourceApiResponse {
  FeedSource(
      {@required int id,
      @required String name,
      @required String code,
      @required String icon,
      @required int priority,
      @required String favicon})
      : super(id, name, code, icon, priority, favicon);
}

class FeedCategory extends FeedCategoryApiResponse {
  FeedCategory(
      {@required int id,
      @required String name,
      @required String nameNp,
      @required String code,
      @required String icon,
      @required int priority,
      @required String enable})
      : super(id, name, nameNp, code, icon, priority, enable);
}

class NewsTags extends NewsTagsApiResponse {
  NewsTags(List<String> tags) : super(tags);
}
