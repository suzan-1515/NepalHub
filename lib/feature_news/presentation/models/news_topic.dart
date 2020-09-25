import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:samachar_hub/feature_news/domain/models/news_topic.dart';

class NewsTopicUIModel extends ChangeNotifier {
  NewsTopicEntity topic;
  final ValueNotifier<bool> followNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<int> followerCountNotifier = ValueNotifier<int>(0);

  NewsTopicUIModel({@required this.topic}) {
    this.followerCountNotifier.value = topic.followerCount;
    this.followNotifier.value = topic.isFollowed;
  }

  follow() {
    if (topic.isFollowed) return;
    followerCountNotifier.value = followerCountNotifier.value++;
    topic = topic.copyWith(
        isFollowed: true, followerCount: followerCountNotifier.value);
  }

  unfollow() {
    if (!topic.isFollowed) return;
    followerCountNotifier.value = followerCountNotifier.value--;
    topic = topic.copyWith(
        isFollowed: false, followerCount: followerCountNotifier.value);
  }

  String get formattedFollowerCount =>
      NumberFormat.compact().format(topic.followerCount);

  @override
  void dispose() {
    super.dispose();
    followNotifier.dispose();
    followerCountNotifier.dispose();
  }
}
