import 'package:flutter/widgets.dart';
import 'package:samachar_hub/data/api/api_provider.dart' as Api;
import 'package:samachar_hub/data/mappers/mappers.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/services/services.dart';

class NewsRepository {
  final NewsApiService newsApiService;
  final PreferenceService preferenceService;

  NewsRepository(this.newsApiService, this.preferenceService);

  Future<List<NewsFeedModel>> getLatestFeeds() async {
    var bookmarks = preferenceService.bookmarkedFeeds;
    var likes = preferenceService.likedFeeds;
    return await newsApiService.fetchLatestFeeds().then((onValue) =>
        onValue.feeds?.map((f) => NewsMapper.fromFeedApi(f))?.map((f) {
          f.bookmarked.value = bookmarks.contains(f.uuid);
          f.liked.value = likes.contains(f.uuid);
          return f;
        })?.toList());
  }

  Future<List<NewsFeedModel>> getTrendingFeeds({String limit}) async {
    var bookmarks = preferenceService.bookmarkedFeeds;
    var likes = preferenceService.likedFeeds;
    return await newsApiService.fetchTrendingFeeds(limit: limit).then(
        (onValue) =>
            onValue.feeds?.map((f) => NewsMapper.fromFeedApi(f))?.map((f) {
              f.bookmarked.value = bookmarks.contains(f.uuid);
              f.liked.value = likes.contains(f.uuid);
              return f;
            })?.toList());
  }

  Future<List<NewsFeedModel>> getFeedsByCategory(
      {@required Api.NewsCategory category, String lastFeedId}) async {
    var bookmarks = preferenceService.bookmarkedFeeds;
    var likes = preferenceService.likedFeeds;
    return await newsApiService
        .fetchFeedsByCategory(category: category, lastFeedId: lastFeedId)
        .then((onValue) =>
            onValue.feeds?.map((f) => NewsMapper.fromFeedApi(f))?.map((f) {
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
    return await newsApiService.fetchNewsByTopic(tag: tag).then((onValue) =>
        onValue.feeds?.map((f) => NewsMapper.fromFeedApi(f))?.toList());
  }

  Future<List<NewsSourceModel>> getSources() async {
    return await newsApiService.fetchSources().then((onValue) =>
        onValue.sources?.map((f) => NewsMapper.fromSourceApi(f))?.toList());
  }

  Future<List<NewsCategoryModel>> getCategories() async {
    return await newsApiService.fetchSources().then((onValue) => onValue
        .categories
        ?.map((f) => NewsMapper.fromCategoryApi(f))
        ?.toList());
  }
}
