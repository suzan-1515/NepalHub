import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_source_entity.dart';

class NewsSourceUIModel {
  NewsSourceEntity source;

  NewsSourceUIModel({@required this.source});

  follow() {
    if (source.isFollowed) return;
    source = source.copyWith(
        isFollowed: true, followerCount: source.followerCount + 1);
  }

  unfollow() {
    if (!source.isFollowed) return;
    source = source.copyWith(
        isFollowed: false, followerCount: source.followerCount - 1);
  }

  String get formattedFollowerCount =>
      NumberFormat.compact().format(source.followerCount);
}
