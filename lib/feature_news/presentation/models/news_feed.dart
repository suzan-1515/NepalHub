import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:samachar_hub/core/utils/date_time_utils.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_feed_entity.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_category.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_source.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_topic.dart';
import 'package:uuid/uuid.dart';

class NewsFeedUIModel {
  NewsFeedEntity _feed;
  NewsCategoryUIModel _newsCategoryUIModel;
  NewsSourceUIModel _newsSourceUIModel;
  List<NewsTopicUIModel> _newsTopicUIModels;
  String tag = Uuid().v4();
  String _publishedDateMomentAgo;

  NewsFeedUIModel({@required NewsFeedEntity feed}) : this._feed = feed {
    this._newsCategoryUIModel = NewsCategoryUIModel(category: feed.category);
    this._newsSourceUIModel = NewsSourceUIModel(source: feed.source);
    this._newsTopicUIModels =
        feed.topics.map((e) => NewsTopicUIModel(topic: e)).toList();
    this._publishedDateMomentAgo = relativeTimeString(feed.publishedDate);
  }

  NewsFeedEntity get feedEntity => _feed;
  NewsCategoryUIModel get newsCategoryUIModel => _newsCategoryUIModel;
  NewsSourceUIModel get newsSourceUIModel => _newsSourceUIModel;
  List<NewsTopicUIModel> get newsTopicUIModels => _newsTopicUIModels;

  like() {
    if (feedEntity.isLiked) return;
    _feed =
        feedEntity.copyWith(isLiked: true, likeCount: feedEntity.likeCount + 1);
  }

  unlike() {
    if (!feedEntity.isLiked) return;
    _feed = feedEntity.copyWith(
        isLiked: false, likeCount: feedEntity.likeCount - 1);
  }

  bookmark() {
    if (feedEntity.isBookmarked) return;
    _feed = feedEntity.copyWith(
        isBookmarked: true, bookmarkCount: feedEntity.bookmarkCount + 1);
  }

  unbookmark() {
    if (!feedEntity.isBookmarked) return;
    _feed = feedEntity.copyWith(
        isBookmarked: false, bookmarkCount: feedEntity.bookmarkCount - 1);
  }

  NewsFeedEntity get newsFeedEntity => this.feedEntity.copyWith(
        source: newsSourceUIModel.source,
        category: newsCategoryUIModel.category,
        topics: newsTopicUIModels.map((e) => e.topic).toList(),
      );

  set newsFeedEntity(NewsFeedEntity newsFeedEntity) => _feed = newsFeedEntity;

  String get formattedLikeCount =>
      NumberFormat.compact().format(feedEntity.likeCount);
  String get formattedCommentCount =>
      NumberFormat.compact().format(feedEntity.commentCount);
  String get formattedShareCount =>
      NumberFormat.compact().format(feedEntity.shareCount);
  String get formattedViewCount =>
      NumberFormat.compact().format(feedEntity.viewCount);

  String get publishedDateMomentAgo => _publishedDateMomentAgo;
}
