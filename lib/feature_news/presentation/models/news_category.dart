import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_category_entity.dart';

class NewsCategoryUIModel {
  NewsCategoryEntity category;

  NewsCategoryUIModel({@required this.category});

  follow() {
    if (category.isFollowed) return;
    category = category.copyWith(
        isFollowed: true, followerCount: category.followerCount + 1);
  }

  unfollow() {
    if (!category.isFollowed) return;
    category = category.copyWith(
        isFollowed: false, followerCount: category.followerCount - 1);
  }

  String get formattedFollowerCount =>
      NumberFormat.compact().format(category.followerCount);
}
