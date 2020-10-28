import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/feature_forex/data/models/forex_model.dart';
import 'package:samachar_hub/feature_horoscope/data/models/horoscope_model.dart';
import 'package:samachar_hub/feature_main/domain/entities/home_entity.dart';
import 'package:samachar_hub/feature_news/data/models/news_category_model.dart';
import 'package:samachar_hub/feature_news/data/models/news_feed_model.dart';
import 'package:samachar_hub/feature_news/data/models/news_source_model.dart';
import 'package:samachar_hub/feature_news/data/models/news_topic_model.dart';

class HomeModel extends HomeEntity {
  HomeModel({
    @required CoronaModel corona,
    @required List<NewsFeedModel> trendingNews,
    @required List<NewsFeedModel> latestNews,
    @required List<NewsCategoryModel> newsCategories,
    @required List<NewsSourceModel> newsSources,
    @required List<NewsTopicModel> newsTopics,
    @required ForexModel forexe,
    @required HoroscopeModel horoscope,
  }) : super(
          corona: corona,
          trendingNews: trendingNews,
          latestNews: latestNews,
          newsTopics: newsTopics,
          newsCategories: newsCategories,
          newsSources: newsSources,
          forexe: forexe,
          horoscope: horoscope,
        );
  factory HomeModel.fromJson(String str) => HomeModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HomeModel.fromMap(Map<String, dynamic> json) => HomeModel(
        corona: CoronaModel.fromMap(json["corona"]),
        trendingNews: List<NewsFeedModel>.from(
            json["trending_news"].map((x) => NewsFeedModel.fromMap(x))),
        latestNews: List<NewsFeedModel>.from(
            json["latest_news"].map((x) => NewsFeedModel.fromMap(x))),
        newsTopics: List<NewsTopicModel>.from(
            json["news_topics"].map((x) => NewsTopicModel.fromMap(x))),
        newsCategories: List<NewsCategoryModel>.from(
            json["news_categories"].map((x) => NewsCategoryModel.fromMap(x))),
        newsSources: List<NewsSourceModel>.from(
            json["news_sources"].map((x) => NewsSourceModel.fromMap(x))),
        forexe: ForexModel.fromMap(json["forex"]),
        horoscope: HoroscopeModel.fromMap(json["horoscope"]),
      );

  Map<String, dynamic> toMap() => {
        "corona": (corona as CoronaModel).toMap(),
        "trending_news": List<NewsFeedModel>.from(
            trendingNews.map((x) => (x as NewsFeedModel).toMap())),
        "latest_news": List<NewsFeedModel>.from(
            latestNews.map((x) => (x as NewsFeedModel).toMap())),
        "news_topics": List<NewsTopicModel>.from(
            newsTopics.map((x) => (x as NewsTopicModel).toMap())),
        "news_categories": List<NewsCategoryModel>.from(
            newsCategories.map((x) => (x as NewsCategoryModel).toMap())),
        "news_sources": List<NewsSourceModel>.from(
            newsSources.map((x) => (x as NewsSourceModel).toMap())),
        "forex": (forexe as ForexModel).toMap(),
        "horoscope": (horoscope as HoroscopeModel).toMap(),
      };
}

class CoronaModel extends CoronaEntity {
  CoronaModel({
    @required String id,
    @required String coronaCase,
    @required String death,
    @required String recovered,
    @required String active,
    @required String critical,
    @required int casesPerMillion,
    @required int deathsPerMillion,
    @required String tests,
    @required int testsPerMillion,
    @required DateTime lastUpdated,
    @required String totalCases,
    @required String totalDeaths,
    @required String totalRecovered,
    @required CoronaCountryModel country,
    @required Language language,
    @required DateTime createdAt,
    @required DateTime updatedAt,
  }) : super(
            id: id,
            coronaCase: coronaCase,
            death: death,
            recovered: recovered,
            active: active,
            critical: critical,
            casesPerMillion: casesPerMillion,
            deathsPerMillion: deathsPerMillion,
            tests: tests,
            testsPerMillion: testsPerMillion,
            lastUpdated: lastUpdated,
            totalCases: totalCases,
            totalDeaths: totalDeaths,
            totalRecovered: totalRecovered,
            country: country,
            language: language,
            createdAt: createdAt,
            updatedAt: updatedAt);

  factory CoronaModel.fromJson(String str) =>
      CoronaModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CoronaModel.fromMap(Map<String, dynamic> json) => CoronaModel(
        id: json["id"].toString(),
        coronaCase: json["case"],
        death: json["death"],
        recovered: json["recovered"],
        active: json["active"],
        critical: json["critical"],
        casesPerMillion: json["cases_per_million"],
        deathsPerMillion: json["deaths_per_million"],
        tests: json["tests"],
        testsPerMillion: json["tests_per_million"],
        lastUpdated: DateTime.parse(json["last_updated"]),
        totalCases: json["total_cases"],
        totalDeaths: json["total_deaths"],
        totalRecovered: json["total_recovered"],
        country: CoronaCountryModel.fromMap(json["country"]),
        language: (json["language"] as String).toLanguage,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "case": coronaCase,
        "death": death,
        "recovered": recovered,
        "active": active,
        "critical": critical,
        "cases_per_million": casesPerMillion,
        "deaths_per_million": deathsPerMillion,
        "tests": tests,
        "tests_per_million": testsPerMillion,
        "last_updated": lastUpdated.toIso8601String(),
        "total_cases": totalCases,
        "total_deaths": totalDeaths,
        "total_recovered": totalRecovered,
        "country": (country as CoronaCountryModel).toMap(),
        "language": language.value,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class CoronaCountryModel extends CountryEntity {
  CoronaCountryModel({
    @required String id,
    @required String title,
    @required String code,
    @required Language language,
    @required DateTime createdAt,
    @required DateTime updatedAt,
    @required String flag,
  }) : super(
            id: id,
            title: title,
            code: code,
            language: language,
            createdAt: createdAt,
            updatedAt: updatedAt,
            flag: flag);
  factory CoronaCountryModel.fromJson(String str) =>
      CoronaCountryModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CoronaCountryModel.fromMap(Map<String, dynamic> json) =>
      CoronaCountryModel(
        id: json["id"].toString(),
        title: json["title"],
        code: json["code"],
        language: (json["language"] as String).toLanguage,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        flag: json["flag"]['url'],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "code": code,
        "language": language.value,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "flag": flag,
      };
}
