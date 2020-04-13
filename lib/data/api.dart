import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:samachar_hub/data/model/news.dart';
import 'package:samachar_hub/data/model/sources.dart';

import 'model/api_error.dart';

// Base URL
const String _baseApiURL = 'timesofnepal.com.np';

// const String _apiKey = "53ea041b1e1c4c659b41767532da63f2";

// API Endpoints
const String _latestNews = '/newsv4/infinite_feeds.php';
const String _trendingNews = '/newsv4/feeds_top.php';
const String _categoryNews = '/newsv4/infinite_feeds_category.php';
const String _trendingTags = '/newsv4/tags.php';
const String _newsSources = '/newsv4/sources.php';

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
  oths,
}

enum SortBy { relevancy, popularity, publishedAt }

String _getCategoryCode(NewsCategory category) {
  if (null == category) return null;
  return category.toString().split('.').last;
}

Future<News> getLatestNews() async {
  var sourceCall = http.get(Uri.https(_baseApiURL, _newsSources));
  var latestNewsCall = http.get(Uri.https(_baseApiURL, _latestNews));
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
    return News.fromJson(
        json.decode(newsResponse.body), json.decode(sourceResponse.body));
  } on Exception catch (e) {
    throw e;
  }
}

Future<News> getNewsByCategory(NewsCategory category,
    {int lastFeedId}) async {
  var sourceCall = http.get(Uri.https(_baseApiURL, _newsSources));
  final Map<String, String> queryParams = _filterNullOrEmptyValuesFromMap({
    'category': _getCategoryCode(category),
    'id': lastFeedId?.toString(),
  });
  var newsCall = http.get(Uri.https(_baseApiURL, _categoryNews, queryParams));
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
    return News.fromJson(
        json.decode(newsResponse.body), json.decode(sourceResponse.body));
  } on Exception catch (e) {
    throw e;
  }
}

Future<Sources> getSources() async {
  final Uri uri = Uri.https(_baseApiURL, _newsSources);
  final http.Response response = await http.get(uri);
  // If response is not ok
  _checkResponse(response);
  // Deserialize
  try {
    return Sources.fromJson(json.decode(response.body));
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
    try {
      final APIError apiError = APIError.fromJson(json.decode(response.body));
      throw apiError;
    } on Exception catch (e) {
      // Rethrow
      if (e is APIError)
        throw e;
      else // Deserialization error
        throw Exception(response.body);
    }
  }
}
