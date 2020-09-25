import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:samachar_hub/feature_news/domain/models/news_source.dart';

class NewsSourceUIModel extends ChangeNotifier {
  NewsSourceEntity source;
  final ValueNotifier<bool> followNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<int> followerCountNotifier = ValueNotifier<int>(0);

  NewsSourceUIModel({@required this.source}) {
    this.followerCountNotifier.value = source.followerCount;
    this.followNotifier.value = source.isFollowed;
  }

  follow() {
    if (source.isFollowed) return;
    followerCountNotifier.value = followerCountNotifier.value++;
    source = source.copyWith(
        isFollowed: true, followerCount: followerCountNotifier.value);
  }

  unfollow() {
    if (!source.isFollowed) return;
    followerCountNotifier.value = followerCountNotifier.value--;
    source = source.copyWith(
        isFollowed: false, followerCount: followerCountNotifier.value);
  }

  String get formattedFollowerCount =>
      NumberFormat.compact().format(source.followerCount);

  @override
  void dispose() {
    super.dispose();
    followNotifier.dispose();
    followerCountNotifier.dispose();
  }
}
