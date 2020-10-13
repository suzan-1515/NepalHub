import 'package:samachar_hub/feature_main/domain/entities/home_entity.dart';
import 'package:samachar_hub/feature_main/presentation/models/home/corona_model.dart';
import 'package:samachar_hub/feature_main/presentation/models/home/home_model.dart';
import 'package:samachar_hub/feature_main/presentation/models/home/latest_news_model.dart';
import 'package:samachar_hub/feature_main/presentation/models/home/recent_news_model.dart';
import 'package:samachar_hub/feature_main/presentation/models/home/trending_news_model.dart';
import 'package:samachar_hub/feature_news/presentation/extensions/news_extensions.dart';

extension HomeX on HomeEntity {
  HomeUIModel get toUIModel => HomeUIModel(
      coronaUIModel: this.corona.toUIModel,
      latestNewsUIModel: LatestNewsUIModel(feeds: this.latestNews.toUIModels),
      newsTopicUIModels: this.newsTopics.toUIModels,
      recentNewsUIModel: RecentNewsUIModel(feeds: this.recentNews.toUIModels),
      trendingNewsUIModel:
          TrendingNewsUIModel(feeds: this.trendingNews.toUIModels));
}

extension CoronaX on CoronaEntity {
  CoronaUIModel get toUIModel => CoronaUIModel(coronaEntity: this);
}
