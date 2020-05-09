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
      {@required Api.NewsCategory category, String lastFeedId}) async {
    return await Api.fetchNewsByCategory(category, lastFeedId: lastFeedId);
  }

  Future<NewsTagsApiResponse> fetchTags() async {
    return await Api.fetchTags();
  }

  Future<NewsSourcesApiResponse> fetchSources() async {
    return await Api.fetchSources();
  }
}
