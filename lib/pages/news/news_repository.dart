import 'package:flutter/widgets.dart';
import 'package:samachar_hub/data/api/api_provider.dart' as Api;
import 'package:samachar_hub/data/mappers/mappers.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/pages/news/news_api_service.dart';
import 'package:samachar_hub/services/services.dart';

class NewsRepository {
  final NewsApiService newsApiService;
  final PreferenceService preferenceService;

  static const int PAGE_SIZE = 20;

  NewsRepository(this.newsApiService, this.preferenceService);

  Future<List<NewsFeedModel>> getLatestFeeds() async {
    var bookmarks = preferenceService.bookmarkedFeeds;
    var likes = preferenceService.likedFeeds;
    var unfollowedSources = preferenceService.unFollowedNewsSources;
    return await newsApiService.fetchLatestFeeds().then((onValue) => onValue
            .feeds
            ?.map((f) => NewsMapper.fromFeedApi(f))
            ?.where(
                (e) => !unfollowedSources.contains(e.rawData['source']['code']))
            ?.map((f) {
          f.bookmarked.value = bookmarks.contains(f.uuid);
          f.liked.value = likes.contains(f.uuid);
          return f;
        })?.toList());
  }

  Future<List<NewsFeedModel>> getTrendingFeeds({String limit}) async {
    var bookmarks = preferenceService.bookmarkedFeeds;
    var likes = preferenceService.likedFeeds;
    var unfollowedSources = preferenceService.unFollowedNewsSources;
    return await newsApiService.fetchTrendingFeeds(limit: limit).then(
        (onValue) => onValue.feeds
                ?.map((f) => NewsMapper.fromFeedApi(f))
                ?.where((e) =>
                    !unfollowedSources.contains(e.rawData['source']['code']))
                ?.map((f) {
              f.bookmarked.value = bookmarks.contains(f.uuid);
              f.liked.value = likes.contains(f.uuid);
              return f;
            })?.toList());
  }

  Future<List<NewsFeedModel>> getFeedsBySource(
      {@required String source, String lastFeedId}) async {
    var bookmarks = preferenceService.bookmarkedFeeds;
    var likes = preferenceService.likedFeeds;
    return await newsApiService
        .fetchFeedsBySource(source: source, lastFeedId: lastFeedId)
        .then((onValue) =>
            onValue.feeds?.map((f) => NewsMapper.fromFeedApi(f))?.map((f) {
              f.bookmarked.value = bookmarks.contains(f.uuid);
              f.liked.value = likes.contains(f.uuid);
              return f;
            })?.toList());
  }

  Future<List<NewsFeedModel>> getFeedsByCategory(
      {@required String category, String lastFeedId}) async {
    var bookmarks = preferenceService.bookmarkedFeeds;
    var likes = preferenceService.likedFeeds;
    var unfollowedSources = preferenceService.unFollowedNewsSources;
    return await newsApiService
        .fetchFeedsByCategory(category: category, lastFeedId: lastFeedId)
        .then((onValue) => onValue.feeds
                ?.map((f) => NewsMapper.fromFeedApi(f))
                ?.where((e) =>
                    !unfollowedSources.contains(e.rawData['source']['code']))
                ?.map((f) {
              f.bookmarked.value = bookmarks.contains(f.uuid);
              f.liked.value = likes.contains(f.uuid);
              return f;
            })?.toList());
  }

  Future<NewsTopicModel> getTopics() async {
    return await newsApiService
        .fetchTopics()
        .then((onValue) => NewsMapper.fromTagsApi(onValue));
  }

  Future<List<NewsFeedModel>> getNewsByTopic({@required String tag}) async {
    return await newsApiService.fetchNewsByTopic(tag: tag).then((onValue) {
      var bookmarks = preferenceService.bookmarkedFeeds;
      var likes = preferenceService.likedFeeds;
      var unfollowedSources = preferenceService.unFollowedNewsSources;
      return onValue.feeds
          ?.map((f) => NewsMapper.fromFeedApi(f))
          ?.where(
              (e) => !unfollowedSources.contains(e.rawData['source']['code']))
          ?.map((f) {
        f.bookmarked.value = bookmarks.contains(f.uuid);
        f.liked.value = likes.contains(f.uuid);
        return f;
      })?.toList();
    });
  }

  Future<List<NewsSourceModel>> getSources() async {
    return await newsApiService.fetchSources().then((onValue) {
      var unFollowedSources = preferenceService.unFollowedNewsSources;
      return onValue.sources
          ?.map((f) =>
              NewsMapper.fromSourceApi(f, !unFollowedSources.contains(f.code)))
          ?.toList();
    });
  }

  Future<List<NewsCategoryModel>> getCategories() async {
    return await newsApiService.fetchSources().then((onValue) {
      var followedCategories = preferenceService.unFollowedNewsCategories;
      return onValue.categories
          ?.map((f) => NewsMapper.fromCategoryApi(
              f, !followedCategories.contains(f.code)))
          ?.toList();
    });
  }
}
