import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:samachar_hub/core/utils/date_time_utils.dart';
import 'package:samachar_hub/feature_news/domain/models/news_feed.dart';
import 'package:uuid/uuid.dart';

class NewsFeedUIModel {
  NewsFeedEntity feed;
  final String tag = Uuid().v4();
  String _publishedDateMomentAgo;

  NewsFeedUIModel({@required this.feed}) {
    this._publishedDateMomentAgo = relativeTimeString(feed.publishedDate);
  }

  like() {
    if (feed.isLiked) return;
    feed = feed.copyWith(isLiked: true, likeCount: feed.likeCount + 1);
  }

  unlike() {
    if (!feed.isLiked) return;
    feed = feed.copyWith(isLiked: false, likeCount: feed.likeCount - 1);
  }

  bookmark() {
    if (feed.isBookmarked) return;
    feed = feed.copyWith(
        isBookmarked: true, bookmarkCount: feed.bookmarkCount + 1);
  }

  unbookmark() {
    if (!feed.isBookmarked) return;
    feed = feed.copyWith(
        isBookmarked: false, bookmarkCount: feed.bookmarkCount - 1);
  }

  followSource() {
    if (feed.source.isFollowed) return;
    feed = feed.copyWith(
        source: feed.source.copyWith(
            isFollowed: true, followerCount: feed.source.followerCount + 1));
  }

  unfollowSource() {
    if (!feed.source.isFollowed) return;
    feed = feed.copyWith(
        source: feed.source.copyWith(
            isFollowed: false, followerCount: feed.source.followerCount - 1));
  }

  followCategory() {
    if (feed.category.isFollowed) return;
    feed = feed.copyWith(
        category: feed.category.copyWith(
            isFollowed: true, followerCount: feed.category.followerCount + 1));
  }

  unfollowCategory() {
    if (!feed.category.isFollowed) return;
    feed = feed.copyWith(
        category: feed.category.copyWith(
            isFollowed: false, followerCount: feed.category.followerCount - 1));
  }

  String get formattedLikeCount =>
      NumberFormat.compact().format(feed.likeCount);
  String get formattedCommentCount =>
      NumberFormat.compact().format(feed.commentCount);
  String get formattedShareCount =>
      NumberFormat.compact().format(feed.shareCount);
  String get formattedViewCount =>
      NumberFormat.compact().format(feed.viewCount);
  String get formattedSourceFollowerCount =>
      NumberFormat.compact().format(feed.source.followerCount);
  String get formattedCategoryFollowerCount =>
      NumberFormat.compact().format(feed.category.followerCount);

  String get publishedDateMomentAgo => _publishedDateMomentAgo;
}
