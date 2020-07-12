import 'package:flutter/material.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/api/api_provider.dart' as Api;

class NewsApiService {
  Future<NewsApiResponse> fetchLatestFeeds() async {
    return await Api.fetchLatestNews();
  }

  Future<NewsApiResponse> fetchTrendingFeeds({String limit}) async {
    return await Api.fetchTrendingNews(limit: limit);
  }

  Future<NewsApiResponse> fetchFeedsByCategory(
      {@required String category, String lastFeedId}) async {
    return await Api.fetchNewsByCategory(category, lastFeedId: lastFeedId);
  }

  Future<NewsTopicsApiResponse> fetchTopics() async {
    return await Api.fetchNewsTopics();
  }

  Future<NewsApiResponse> fetchNewsByTopic({@required String tag}) async {
    return await Api.fetchNewsByTopic(topic: tag);
  }

  Future<NewsSourcesApiResponse> fetchSources() async {
    return await Api.fetchSources();
  }
}
