import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/api/response/corona_api_response.dart';
import 'package:samachar_hub/data/api/response/forex_api_response.dart';
import 'package:samachar_hub/data/api/response/horoscope_api_response.dart';
import 'package:samachar_hub/data/mappers/mappers.dart';

// Base URL
const String _baseNewsApiURL = 'timesofnepal.com.np';
const String _baseHoroscopeApiURL = 'nepalipatro.com.np';
const String _baseForexApiURL = 'api.nepalipatro.com.np';
const String _baseCoronaApiURL = 'corona.lmao.ninja';

// API Endpoints
const String _latestNews = '/newsv4/infinite_feeds.php';
const String _trendingNews = '/newsv4/feeds_top.php';
const String _categoryNews = '/newsv4/infinite_feeds_category.php';
const String _trendingNewsTopics = '/newsv4/tags.php';
const String _topicNews = '/newsv4/search.php'; //param: text
const String _newsSources = '/newsv4/sources.php';

const String _coronaWorldWide = '/v2/all';
const String _coronaByCountry = '/v2/countries/'; //default to Nepal

const String _horoscope = '/rashifal/getv5/type/dwmy';

const String _forexToday = '/forex';
const String _forexByCountry =
    '/forex/currencycode'; //body: currency_code,from (date),to(date)

enum NewsCategory {
  tops,
  pltc,
  sprt,
  scte,
  wrld,
  busi,
  entm,
  hlth,
  blog,
  advs,
  oths,
}

enum SortBy { relevancy, popularity, publishedAt }

String _getCategoryCode(NewsCategory category) {
  if (null == category) return null;
  return category.toString().split('.').last;
}

Future<NewsApiResponse> fetchLatestNews() async {
  var sourceCall = http.get(Uri.https(_baseNewsApiURL, _newsSources));
  var latestNewsCall = http.get(Uri.https(_baseNewsApiURL, _latestNews));
  var results =
      await Future.wait([sourceCall, latestNewsCall], eagerError: true)
          .catchError((err) {
    throw err;
  });

  var sourceResponse = results.first;
  // If response is not ok
  _checkResponse(sourceResponse);
  // Deserialize
  var newsResponse = results.last;
  // If response is not ok
  _checkResponse(newsResponse);
  // Deserialize

  try {
    return NewsApiParser.parse(
        feeds: json.decode(newsResponse.body),
        sources: json.decode(sourceResponse.body));
  } on Exception catch (e) {
    throw e;
  }
}

Future<NewsApiResponse> fetchTrendingNews({String limit}) async {
  var sourceCall = http.get(Uri.https(_baseNewsApiURL, _newsSources));
  final Map<String, String> queryParams = _filterNullOrEmptyValuesFromMap({
    'limit': limit,
  });
  var trendingNewsCall =
      http.get(Uri.https(_baseNewsApiURL, _trendingNews, queryParams));
  var results =
      await Future.wait([sourceCall, trendingNewsCall], eagerError: true)
          .catchError((err) {
    throw err;
  });

  var sourceResponse = results.first;
  // If response is not ok
  _checkResponse(sourceResponse);
  // Deserialize
  var newsResponse = results.last;
  // If response is not ok
  _checkResponse(newsResponse);
  // Deserialize

  try {
    return NewsApiParser.parse(
        feeds: json.decode(newsResponse.body),
        sources: json.decode(sourceResponse.body));
  } on Exception catch (e) {
    throw e;
  }
}

Future<NewsApiResponse> fetchNewsByCategory(NewsCategory category,
    {String lastFeedId}) async {
  var sourceCall = http.get(Uri.https(_baseNewsApiURL, _newsSources));
  final Map<String, String> queryParams = _filterNullOrEmptyValuesFromMap({
    'category': _getCategoryCode(category),
    'id': lastFeedId,
  });
  var newsCall =
      http.get(Uri.https(_baseNewsApiURL, _categoryNews, queryParams));
  var results = await Future.wait([sourceCall, newsCall], eagerError: true)
      .catchError((err) {
    throw err;
  });

  var sourceResponse = results.first;
  // If response is not ok
  _checkResponse(sourceResponse);
  // Deserialize
  var newsResponse = results.last;
  // If response is not ok
  _checkResponse(newsResponse);
  // Deserialize

  try {
    return NewsApiParser.parse(
        feeds: json.decode(newsResponse.body),
        sources: json.decode(sourceResponse.body));
  } on Exception catch (e) {
    throw e;
  }
}

Future<NewsSourcesApiResponse> fetchSources() async {
  final Uri uri = Uri.https(_baseNewsApiURL, _newsSources);
  final http.Response response = await http.get(uri);
  // If response is not ok
  _checkResponse(response);
  // Deserialize
  try {
    return NewsSourcesApiResponse.fromJson(json.decode(response.body));
  } on Exception catch (e) {
    throw e;
  }
}

Future<NewsTopicsApiResponse> fetchNewsTopics() async {
  final Uri uri = Uri.https(_baseNewsApiURL, _trendingNewsTopics);
  final http.Response response = await http.get(uri);
  // If response is not ok
  _checkResponse(response);
  // Deserialize
  try {
    return NewsTopicsApiResponse.fromJson(json.decode(response.body));
  } on Exception catch (e) {
    throw e;
  }
}

Future<NewsApiResponse> fetchNewsByTopic({@required String topic}) async {
  var sourceCall = http.get(Uri.https(_baseNewsApiURL, _newsSources));
  final Map<String, String> queryParams = _filterNullOrEmptyValuesFromMap({
    'text': topic,
  });
  var tagNewsCall =
      http.get(Uri.https(_baseNewsApiURL, _topicNews, queryParams));
  var results = await Future.wait([sourceCall, tagNewsCall], eagerError: true)
      .catchError((err) {
    throw err;
  });

  var sourceResponse = results.first;
  // If response is not ok
  _checkResponse(sourceResponse);
  // Deserialize
  var newsResponse = results.last;
  // If response is not ok
  _checkResponse(newsResponse);
  // Deserialize

  try {
    return NewsApiParser.parseTagNews(
        feeds: json.decode(newsResponse.body),
        sources: json.decode(sourceResponse.body));
  } on Exception catch (e) {
    throw e;
  }
}

Future<CoronaWorldwideApiResponse> fetchCoronaWorldwideStat() async {
  final Uri uri = Uri.https(_baseCoronaApiURL, _coronaWorldWide);
  final http.Response response = await http.get(uri);
  // If response is not ok
  _checkResponse(response);
  // Deserialize
  try {
    return CoronaWorldwideApiResponse.fromJson(json.decode(response.body));
  } on Exception catch (e) {
    throw e;
  }
}

Future<CoronaCountrySpecificApiResponse> fetchCoronaStatByCountry(
    {@required String country}) async {
  final Uri uri = Uri.https(_baseCoronaApiURL, _coronaByCountry + country);
  final http.Response response = await http.get(uri);
  // If response is not ok
  _checkResponse(response);
  // Deserialize
  try {
    return CoronaCountrySpecificApiResponse.fromJson(
        json.decode(response.body));
  } on Exception catch (e) {
    throw e;
  }
}

Future<HoroscopeApiResponse> fetchHoroscope() async {
  final Uri uri = Uri.https(_baseHoroscopeApiURL, _horoscope);
  final http.Response response = await http.get(uri);
  // If response is not ok
  _checkResponse(response);
  // Deserialize
  try {
    return HoroscopeApiResponse.fromJson(json.decode(response.body));
  } on Exception catch (e) {
    throw e;
  }
}

Future<List<ForexApiResponse>> fetchTodayForex() async {
  final Uri uri = Uri.https(_baseForexApiURL, _forexToday);
  final http.Response response = await http.get(uri);
  // If response is not ok
  _checkResponse(response);
  // Deserialize
  try {
    final List data = json.decode(response.body);
    return data.map((e) => ForexApiResponse.fromJson(e)).toList();
  } on Exception catch (e) {
    throw e;
  }
}

Future<List<ForexApiResponse>> fetchForexByCountry(
    {@required String currencyCode,
    @required String fromDate,
    @required String toDate}) async {
  final Map<String, String> body = _filterNullOrEmptyValuesFromMap({
    'currency_code': currencyCode,
    'from': fromDate,
    'to': toDate,
  });
  final Uri uri = Uri.https(_baseForexApiURL, _forexByCountry);
  final http.Response response = await http.post(uri, body: body);
  // If response is not ok
  _checkResponse(response);
  // Deserialize
  try {
    final List data = json.decode(response.body);
    return data.map((e) => ForexApiResponse.fromJson(e)).toList();
  } on Exception catch (e) {
    throw e;
  }
}

Map<String, String> _filterNullOrEmptyValuesFromMap(Map<String, String> map) {
  final Map<String, String> filteredMap = <String, String>{};
  map.forEach((String key, String value) {
    if (value != null && value.isNotEmpty) filteredMap[key] = value;
  });
  return filteredMap;
}

_checkResponse(http.Response response) {
  if (response.statusCode != 200) {
    // Try to build api_error object
    throw APIException('Bad response. Try again.');
  }
}
