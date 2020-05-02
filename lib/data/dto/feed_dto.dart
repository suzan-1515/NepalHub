import 'package:flutter/material.dart';
import 'package:samachar_hub/data/api/response/api_response.dart';

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

class FeedSourceDTO extends FeedSourceApiResponse {
  FeedSourceDTO(int id, String name, String code, String icon, int priority,
      String favicon)
      : super(id, name, code, icon, priority, favicon);
}

class FeedCategoryDTO extends FeedCategoryApiResponse {
  FeedCategoryDTO(int id, String name, String nameNp, String code, String icon,
      int priority, String enable)
      : super(id, name, nameNp, code, icon, priority, enable);
}
