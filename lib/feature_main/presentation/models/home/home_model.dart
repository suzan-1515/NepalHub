import 'package:flutter/material.dart';
import 'package:samachar_hub/feature_main/domain/entities/home_entity.dart';
import 'package:samachar_hub/feature_main/presentation/models/home/corona_model.dart';
import 'package:samachar_hub/feature_main/presentation/models/home/latest_news_model.dart';
import 'package:samachar_hub/feature_main/presentation/models/home/recent_news_model.dart';
import 'package:samachar_hub/feature_main/presentation/models/home/trending_news_model.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_topic.dart';

class HomeUIModel {
  CoronaUIModel coronaUIModel;
  LatestNewsUIModel latestNewsUIModel;
  RecentNewsUIModel recentNewsUIModel;
  TrendingNewsUIModel trendingNewsUIModel;
  List<NewsTopicUIModel> newsTopicUIModels;
  bool _showNewsCategory = true;
  bool _showNewsSource = true;
  bool _showDailyHoroscope = true;

  HomeUIModel({
    @required this.coronaUIModel,
    @required this.latestNewsUIModel,
    @required this.recentNewsUIModel,
    @required this.trendingNewsUIModel,
    @required this.newsTopicUIModels,
    HomeEntity feed,
  });

  bool get hasCoronaData => coronaUIModel != null;
  bool get hasLatestNews => latestNewsUIModel != null;
  bool get hasTrendingNews => trendingNewsUIModel != null;
  bool get hasRecentNews => recentNewsUIModel != null;
  bool get hasNewsTopics => newsTopicUIModels != null;

  set shouldShowNewsCategorySection(bool value) => _showNewsCategory = value;
  set shouldShowNewsSourceSection(bool value) => _showNewsSource = value;

  bool get shouldShowNewsCategorySection => _showNewsCategory;
  bool get shouldShowNewsSourceSection => _showNewsSource;

  set shouldShowDailyHoroscopeSection(bool value) =>
      _showDailyHoroscope = value;

  bool get shouldShowDailyHoroscopeSection => _showDailyHoroscope;
}
