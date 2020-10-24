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
  bool showNewsCategory = true;
  bool showNewsSource = true;
  bool showDailyHoroscope = true;

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
}
