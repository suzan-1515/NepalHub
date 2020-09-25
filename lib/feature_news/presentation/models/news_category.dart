import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:samachar_hub/feature_news/domain/models/news_category.dart';

class NewsCategoryUIModel extends ChangeNotifier {
  NewsCategoryEntity category;
  final ValueNotifier<bool> followNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<int> followerCountNotifier = ValueNotifier<int>(0);

  NewsCategoryUIModel({@required this.category}) {
    this.followerCountNotifier.value = category.followerCount;
    this.followNotifier.value = category.isFollowed;
  }

  follow() {
    if (category.isFollowed) return;
    followerCountNotifier.value = followerCountNotifier.value++;
    category = category.copyWith(
        isFollowed: true, followerCount: followerCountNotifier.value);
  }

  unfollow() {
    if (!category.isFollowed) return;
    followerCountNotifier.value = followerCountNotifier.value--;
    category = category.copyWith(
        isFollowed: false, followerCount: followerCountNotifier.value);
  }

  String get formattedFollowerCount =>
      NumberFormat.compact().format(category.followerCount);

  @override
  void dispose() {
    super.dispose();
    followNotifier.dispose();
    followerCountNotifier.dispose();
  }
}
