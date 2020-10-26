import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_topic_entity.dart';

class NewsTopicUIModel {
  NewsTopicEntity topic;

  NewsTopicUIModel({@required this.topic});

  follow() {
    if (topic.isFollowed) return;
    topic = topic.copyWith(
        isFollowed: true, followerCount: topic.followerCount + 1);
  }

  unfollow() {
    if (!topic.isFollowed) return;
    topic = topic.copyWith(
        isFollowed: false, followerCount: topic.followerCount + 1);
  }

  String get formattedFollowerCount =>
      NumberFormat.compact().format(topic.followerCount);
}
