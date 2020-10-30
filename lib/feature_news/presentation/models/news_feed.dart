import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:samachar_hub/core/utils/date_time_utils.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_feed_entity.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_category.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_source.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_topic.dart';

class NewsFeedUIModel {
  NewsFeedEntity _feed;
  NewsCategoryUIModel _newsCategoryUIModel;
  NewsSourceUIModel _newsSourceUIModel;
  List<NewsTopicUIModel> _newsTopicUIModels;
  String _publishedDateMomentAgo;

  NewsFeedUIModel({@required NewsFeedEntity feed}) {
    this.feedEntity = feed;
  }

  NewsCategoryUIModel get newsCategoryUIModel => _newsCategoryUIModel;
  NewsSourceUIModel get newsSourceUIModel => _newsSourceUIModel;
  List<NewsTopicUIModel> get newsTopicUIModels => _newsTopicUIModels;

  like() {
    if (_feed.isLiked) return;
    feedEntity = _feed.copyWith(isLiked: true, likeCount: _feed.likeCount + 1);
  }

  unlike() {
    if (!_feed.isLiked) return;
    feedEntity = _feed.copyWith(isLiked: false, likeCount: _feed.likeCount - 1);
  }

  bookmark() {
    if (_feed.isBookmarked) return;
    feedEntity = _feed.copyWith(
        isBookmarked: true, bookmarkCount: _feed.bookmarkCount + 1);
  }

  unbookmark() {
    if (!_feed.isBookmarked) return;
    feedEntity = _feed.copyWith(
        isBookmarked: false, bookmarkCount: _feed.bookmarkCount - 1);
  }

  NewsFeedEntity get feedEntity => this._feed.copyWith(
        source: newsSourceUIModel.source,
        category: newsCategoryUIModel.category,
        topics: newsTopicUIModels.map((e) => e.topic).toList(),
      );

  set feedEntity(NewsFeedEntity newsFeedEntity) {
    _feed = newsFeedEntity;
    this._newsCategoryUIModel = NewsCategoryUIModel(category: _feed.category);
    this._newsSourceUIModel = NewsSourceUIModel(source: _feed.source);
    this._newsTopicUIModels =
        _feed.topics.map((e) => NewsTopicUIModel(topic: e)).toList();
    this._publishedDateMomentAgo = relativeTimeString(_feed.publishedDate);
  }

  String get formattedLikeCount =>
      NumberFormat.compact().format(_feed.likeCount);
  String get formattedCommentCount =>
      NumberFormat.compact().format(_feed.commentCount);
  String get formattedShareCount =>
      NumberFormat.compact().format(_feed.shareCount);
  String get formattedViewCount =>
      NumberFormat.compact().format(_feed.viewCount);

  String get publishedDateMomentAgo => _publishedDateMomentAgo;
}
