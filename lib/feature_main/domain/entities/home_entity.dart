import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/feature_news/domain/models/news_feed.dart';
import 'package:samachar_hub/feature_news/domain/models/news_topic.dart';

class HomeEntity extends Equatable {
  HomeEntity({
    @required this.corona,
    @required this.trendingNews,
    @required this.recentNews,
    @required this.latestNews,
    @required this.newsTopics,
  });

  final CoronaEntity corona;
  final List<NewsFeedEntity> trendingNews;
  final List<NewsFeedEntity> recentNews;
  final List<NewsFeedEntity> latestNews;
  final List<NewsTopicEntity> newsTopics;

  HomeEntity copyWith({
    CoronaEntity corona,
    List<NewsFeedEntity> trendingNews,
    List<NewsFeedEntity> recentNews,
    List<NewsFeedEntity> latestNews,
    List<NewsTopicEntity> newsTopics,
  }) =>
      HomeEntity(
        corona: corona ?? this.corona,
        trendingNews: trendingNews ?? this.trendingNews,
        recentNews: recentNews ?? this.recentNews,
        latestNews: latestNews ?? this.latestNews,
        newsTopics: newsTopics ?? this.newsTopics,
      );

  @override
  List<Object> get props =>
      [corona, trendingNews, recentNews, latestNews, newsTopics];
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
