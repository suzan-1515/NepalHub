import 'package:flutter/widgets.dart';
import 'package:samachar_hub/common/service/news_api_service.dart';
import 'package:samachar_hub/common/service/preference_service.dart';
import 'package:samachar_hub/data/dto/news_dto.dart';
import 'package:samachar_hub/data/mapper/news_mapper.dart';
import 'package:samachar_hub/data/api/api_provider.dart' as Api;

class NewsRepository {
  final NewsApiService newsApiService;
  final PreferenceService preferenceService;

  NewsRepository(this.newsApiService, this.preferenceService);

  Future<List<Feed>> getLatestFeeds() async {
    var bookmarks = preferenceService.bookmarkedFeeds;
    var likes = preferenceService.likedFeeds;
    return await newsApiService.fetchLatestFeeds().then((onValue) =>
        onValue.feeds?.map((f) => NewsMapper.fromFeedApi(f))?.map((f) {
          f.bookmarked.value = bookmarks.contains(f.id);
          f.liked.value = likes.contains(f.id);
          return f;
        })?.toList());
  }

  Future<List<Feed>> getTrendingFeeds({String limit}) async {
    var bookmarks = preferenceService.bookmarkedFeeds;
    var likes = preferenceService.likedFeeds;
    return await newsApiService.fetchTrendingFeeds(limit: limit).then(
        (onValue) =>
            onValue.feeds?.map((f) => NewsMapper.fromFeedApi(f))?.map((f) {
              f.bookmarked.value = bookmarks.contains(f.id);
              f.liked.value = likes.contains(f.id);
              return f;
            })?.toList());
  }

  Future<List<Feed>> getFeedsByCategory(
      {@required Api.NewsCategory category, String lastFeedId}) async {
    var bookmarks = preferenceService.bookmarkedFeeds;
    var likes = preferenceService.likedFeeds;
    return await newsApiService
        .fetchFeedsByCategory(category: category, lastFeedId: lastFeedId)
        .then((onValue) =>
            onValue.feeds?.map((f) => NewsMapper.fromFeedApi(f))?.map((f) {
              f.bookmarked.value = bookmarks.contains(f.id);
              f.liked.value = likes.contains(f.id);
              return f;
            })?.toList());
  }

  Future<NewsTopics> getTopics() async {
    return await newsApiService
        .fetchTopics()
        .then((onValue) => NewsMapper.fromTagsApi(onValue));
  }

  Future<List<Feed>> getNewsByTopic({@required String tag}) async {
    return await newsApiService.fetchNewsByTopic(tag: tag).then((onValue) =>
        onValue.feeds?.map((f) => NewsMapper.fromFeedApi(f))?.toList());
  }

  Future<List<FeedSource>> getSources() async {
    return await newsApiService.fetchSources().then((onValue) =>
        onValue.sources?.map((f) => NewsMapper.fromSourceApi(f))?.toList());
  }

  Future<List<FeedCategory>> getCategories() async {
    return await newsApiService.fetchSources().then((onValue) => onValue
        .categories
        ?.map((f) => NewsMapper.fromCategoryApi(f))
        ?.toList());
  }
}
