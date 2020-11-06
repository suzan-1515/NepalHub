import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/feature_forex/domain/entities/forex_entity.dart';
import 'package:samachar_hub/feature_gold/domain/entities/gold_silver_entity.dart';
import 'package:samachar_hub/feature_horoscope/domain/entities/horoscope_entity.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_category_entity.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_feed_entity.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_source_entity.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_topic_entity.dart';

class HomeEntity extends Equatable {
  HomeEntity({
    @required this.corona,
    @required this.trendingNews,
    @required this.latestNews,
    @required this.newsCategories,
    @required this.newsSources,
    @required this.newsTopics,
    @required this.horoscope,
    @required this.forexe,
    @required this.goldSilver,
  });

  final CoronaEntity corona;
  final List<NewsFeedEntity> trendingNews;
  final List<NewsFeedEntity> latestNews;
  final List<NewsCategoryEntity> newsCategories;
  final List<NewsSourceEntity> newsSources;
  final List<NewsTopicEntity> newsTopics;
  final HoroscopeEntity horoscope;
  final GoldSilverEntity goldSilver;
  final ForexEntity forexe;

  HomeEntity copyWith(
          {CoronaEntity corona,
          List<NewsFeedEntity> trendingNews,
          List<NewsFeedEntity> latestNews,
          List<NewsTopicEntity> newsTopics,
          List<NewsCategoryEntity> newsCategories,
          List<NewsSourceEntity> newsSources,
          HoroscopeEntity horoscope,
          ForexEntity forexe,
          GoldSilverEntity goldSilver}) =>
      HomeEntity(
        corona: corona ?? this.corona,
        trendingNews: trendingNews ?? this.trendingNews,
        latestNews: latestNews ?? this.latestNews,
        newsTopics: newsTopics ?? this.newsTopics,
        newsCategories: newsCategories ?? this.newsCategories,
        newsSources: newsTopics ?? this.newsSources,
        horoscope: horoscope ?? this.horoscope,
        forexe: forexe ?? this.forexe,
        goldSilver: goldSilver ?? this.goldSilver,
      );

  @override
  List<Object> get props => [
        corona,
        trendingNews,
        latestNews,
        newsTopics,
        newsSources,
        newsCategories,
        forexe,
        horoscope
      ];
}

class CoronaEntity {
  CoronaEntity({
    @required this.id,
    @required this.coronaCase,
    @required this.death,
    @required this.recovered,
    @required this.active,
    @required this.critical,
    @required this.casesPerMillion,
    @required this.deathsPerMillion,
    @required this.tests,
    @required this.testsPerMillion,
    @required this.lastUpdated,
    @required this.totalCases,
    @required this.totalDeaths,
    @required this.totalRecovered,
    @required this.country,
    @required this.language,
    @required this.createdAt,
    @required this.updatedAt,
  });

  final String id;
  final String coronaCase;
  final String death;
  final String recovered;
  final String active;
  final String critical;
  final int casesPerMillion;
  final int deathsPerMillion;
  final String tests;
  final int testsPerMillion;
  final DateTime lastUpdated;
  final String totalCases;
  final String totalDeaths;
  final String totalRecovered;
  final CountryEntity country;
  final Language language;
  final DateTime createdAt;
  final DateTime updatedAt;

  CoronaEntity copyWith({
    int id,
    String coronaCase,
    String death,
    String recovered,
    String active,
    String critical,
    int casesPerMillion,
    int deathsPerMillion,
    String tests,
    int testsPerMillion,
    DateTime lastUpdated,
    String totalCases,
    String totalDeaths,
    String totalRecovered,
    CountryEntity country,
    Language language,
    DateTime createdAt,
    DateTime updatedAt,
  }) =>
      CoronaEntity(
        id: id ?? this.id,
        coronaCase: coronaCase ?? this.coronaCase,
        death: death ?? this.death,
        recovered: recovered ?? this.recovered,
        active: active ?? this.active,
        critical: critical ?? this.critical,
        casesPerMillion: casesPerMillion ?? this.casesPerMillion,
        deathsPerMillion: deathsPerMillion ?? this.deathsPerMillion,
        tests: tests ?? this.tests,
        testsPerMillion: testsPerMillion ?? this.testsPerMillion,
        lastUpdated: lastUpdated ?? this.lastUpdated,
        totalCases: totalCases ?? this.totalCases,
        totalDeaths: totalDeaths ?? this.totalDeaths,
        totalRecovered: totalRecovered ?? this.totalRecovered,
        country: country ?? this.country,
        language: language ?? this.language,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
}

class CountryEntity {
  CountryEntity({
    @required this.id,
    @required this.title,
    @required this.code,
    @required this.language,
    @required this.createdAt,
    @required this.updatedAt,
    @required this.flag,
  });

  final String id;
  final String title;
  final String code;
  final Language language;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String flag;

  CountryEntity copyWith({
    int id,
    String title,
    String code,
    Language language,
    DateTime createdAt,
    DateTime updatedAt,
    String flag,
  }) =>
      CountryEntity(
        id: id ?? this.id,
        title: title ?? this.title,
        code: code ?? this.code,
        language: language ?? this.language,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        flag: flag ?? this.flag,
      );
}
