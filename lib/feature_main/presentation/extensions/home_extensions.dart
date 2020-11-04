import 'package:samachar_hub/feature_main/domain/entities/home_entity.dart';
import 'package:samachar_hub/feature_main/presentation/models/home/corona_model.dart';
import 'package:samachar_hub/feature_main/presentation/models/home/home_model.dart';
import 'package:samachar_hub/feature_main/presentation/models/home/latest_news_model.dart';
import 'package:samachar_hub/feature_main/presentation/models/home/trending_news_model.dart';
import 'package:samachar_hub/feature_news/presentation/extensions/news_extensions.dart';
import 'package:samachar_hub/feature_forex/presentation/extensions/forex_extensions.dart';
import 'package:samachar_hub/feature_horoscope/presentation/extensions/horoscope_extensions.dart';

extension HomeX on HomeEntity {
  HomeUIModel get toUIModel => HomeUIModel(
      coronaUIModel: this.corona.toUIModel,
      latestNewsUIModel: LatestNewsUIModel(feeds: this.latestNews),
      newsTopicUIModels: this.newsTopics.toUIModels,
      newsCategoryUIModels: this.newsCategories.toUIModels,
      newsSourceUIModels: this.newsSources.toUIModels,
      trendingNewsUIModel: TrendingNewsUIModel(feeds: this.trendingNews),
      forexUIModel: this.forexe.toUIModel,
      horoscopeUIModel: this.horoscope.toUIModel);
}

extension CoronaX on CoronaEntity {
  CoronaUIModel get toUIModel => CoronaUIModel(coronaEntity: this);
}
