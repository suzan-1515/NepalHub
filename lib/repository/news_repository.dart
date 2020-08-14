import 'package:flutter/widgets.dart';
import 'package:samachar_hub/data/mappers/mappers.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/data/models/sort.dart';
import 'package:samachar_hub/services/news_api_service.dart';
import 'package:samachar_hub/services/services.dart';

class NewsRepository {
  final NewsApiService newsApiService;
  final PreferenceService preferenceService;

  static const int PAGE_SIZE = 20;

  NewsRepository(this.newsApiService, this.preferenceService);

  Future<List<NewsFeed>> getLatestFeeds() async {
    var bookmarks = preferenceService.bookmarkedFeeds;
    var likes = preferenceService.likedFeeds;
    var unFollowedSources = preferenceService.unFollowedNewsSources;
    var unFollowedCategories = preferenceService.unFollowedNewsCategories;
    return await newsApiService.fetchLatestFeeds().then((onValue) => onValue
        .feeds
        ?.map((f) => NewsMapper.fromFeedApi(
            f, bookmarks, likes, unFollowedSources, unFollowedCategories))
        ?.toList());
  }

  Future<List<NewsFeed>> getTrendingFeeds({String limit}) async {
    var bookmarks = preferenceService.bookmarkedFeeds;
    var likes = preferenceService.likedFeeds;
    var unFollowedSources = preferenceService.unFollowedNewsSources;
    var unFollowedCategories = preferenceService.unFollowedNewsCategories;
    return await newsApiService.fetchTrendingFeeds(limit: limit).then(
        (onValue) => onValue.feeds
            ?.map((f) => NewsMapper.fromFeedApi(
                f, bookmarks, likes, unFollowedSources, unFollowedCategories))
            ?.toList());
  }

  Future<List<NewsFeed>> getFeedsBySource(
      {@required String source, String lastFeedId, SortBy sort}) async {
    var bookmarks = preferenceService.bookmarkedFeeds;
    var likes = preferenceService.likedFeeds;
    var unFollowedSources = preferenceService.unFollowedNewsSources;
    var unFollowedCategories = preferenceService.unFollowedNewsCategories;
    return await newsApiService
        .fetchFeedsBySource(source: source, lastFeedId: lastFeedId)
        .then((onValue) => onValue.feeds
            ?.map((f) => NewsMapper.fromFeedApi(
                f, bookmarks, likes, unFollowedSources, unFollowedCategories))
            ?.toList());
  }

  Future<List<NewsFeed>> getFeedsByCategory(
      {@required String category,
      String lastFeedId,
      String source,
      SortBy sort}) async {
    var bookmarks = preferenceService.bookmarkedFeeds;
    var likes = preferenceService.likedFeeds;
    var unFollowedSources = preferenceService.unFollowedNewsSources;
    var unFollowedCategories = preferenceService.unFollowedNewsCategories;
    return await newsApiService
        .fetchFeedsByCategory(category: category, lastFeedId: lastFeedId)
        .then((onValue) => onValue.feeds
            ?.map((f) => NewsMapper.fromFeedApi(
                f, bookmarks, likes, unFollowedSources, unFollowedCategories))
            ?.toList());
  }

  Future<List<NewsTopic>> getTopics({bool followedOnly = false}) async {
    var followedTopics = preferenceService.followedNewsTopics;
    return await newsApiService.fetchTopics().then((onValue) => onValue.tags
            ?.map((e) => NewsMapper.fromTopicApi(e, followedTopics.contains(e)))
            ?.where((element) {
          if (followedOnly) return element.isFollowed;
          return true;
        })?.toList());
  }

  Future<List<NewsFeed>> getNewsByTopic(
      {@required String topic, String source, SortBy sort}) async {
    return await newsApiService.fetchNewsByTopic(tag: topic).then((onValue) {
      var bookmarks = preferenceService.bookmarkedFeeds;
      var likes = preferenceService.likedFeeds;
      var unFollowedSources = preferenceService.unFollowedNewsSources;
      var unFollowedCategories = preferenceService.unFollowedNewsCategories;
      return onValue.feeds
          ?.map((f) => NewsMapper.fromFeedApi(
              f, bookmarks, likes, unFollowedSources, unFollowedCategories))
          ?.toList();
    });
  }

  Future<List<NewsSource>> getSources({bool followedOnly = false}) async {
    return await newsApiService.fetchSources().then((onValue) {
      var unFollowedSources = preferenceService.unFollowedNewsSources;
      return onValue.sources
          ?.map((f) =>
              NewsMapper.fromSourceApi(f, !unFollowedSources.contains(f.code)))
          ?.where((e) {
        if (followedOnly) return e.isFollowed;
        return true;
      })?.toList();
    });
  }

  Future<List<NewsCategory>> getCategories({bool followedOnly = false}) async {
    return await newsApiService.fetchSources().then((onValue) {
      var followedCategories = preferenceService.unFollowedNewsCategories;
      return onValue.categories
          ?.map((f) => NewsMapper.fromCategoryApi(
              f, !followedCategories.contains(f.code)))
          ?.where((e) {
        if (followedOnly) return e.isFollowed;
        return true;
      })?.toList();
    });
  }
}
