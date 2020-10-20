import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/feature_news/data/datasource/remote/remote_data_source.dart';
import 'package:samachar_hub/feature_news/data/models/news_category_model.dart';
import 'package:samachar_hub/feature_news/data/models/news_feed_model.dart';
import 'package:samachar_hub/feature_news/data/models/news_source_model.dart';
import 'package:samachar_hub/feature_news/data/models/news_topic_model.dart';
import 'package:samachar_hub/feature_news/data/service/remote_service.dart';
import 'package:samachar_hub/feature_news/domain/models/sort.dart';

class NewsRemoteDataSource implements RemoteDataSource {
  final RemoteService _remoteService;

  NewsRemoteDataSource(this._remoteService);

  @override
  Future<List<NewsCategoryModel>> fetchCategories(
      {Language language, String token}) async {
    final responseList =
        await _remoteService.fetchCategories(language: language, token: token);
    final List<NewsCategoryModel> categoriesResponse = responseList
        .map<NewsCategoryModel>((e) => NewsCategoryModel.fromMap(e))
        .toList();
    return categoriesResponse;
  }

  @override
  Future<NewsFeedModel> bookmarkFeed({String feedId, String token}) async {
    final newsFeedResponse =
        await _remoteService.bookmarkFeed(feedId: feedId, token: token);
    return NewsFeedModel.fromMap(newsFeedResponse);
  }

  @override
  Future<NewsCategoryModel> followCategory(
      {String categoryId, String token}) async {
    final newsCategoryResponse = await _remoteService.followCategory(
        categoryId: categoryId, token: token);
    return NewsCategoryModel.fromMap(newsCategoryResponse);
  }

  @override
  Future<NewsSourceModel> followSource({String sourceId, String token}) async {
    final newsSourceResponse =
        await _remoteService.followSource(sourceId: sourceId, token: token);
    return NewsSourceModel.fromMap(newsSourceResponse);
  }

  @override
  Future<NewsTopicModel> followTopic({String topicId, String token}) async {
    final newsTopicResponse =
        await _remoteService.followTopic(topicId: topicId, token: token);
    return NewsTopicModel.fromMap(newsTopicResponse);
  }

  @override
  Future<NewsCategoryModel> unFollowCategory(
      {String categoryId, String token}) async {
    final newsCategoryResponse = await _remoteService.unFollowCategory(
        categoryId: categoryId, token: token);
    return NewsCategoryModel.fromMap(newsCategoryResponse);
  }

  @override
  Future<NewsSourceModel> unFollowSource(
      {String sourceId, String token}) async {
    final newsSourceResponse =
        await _remoteService.unFollowSource(sourceId: sourceId, token: token);
    return NewsSourceModel.fromMap(newsSourceResponse);
  }

  @override
  Future<NewsTopicModel> unFollowTopic({String topicId, String token}) async {
    final newsTopicResponse =
        await _remoteService.unFollowTopic(topicId: topicId, token: token);
    return NewsTopicModel.fromMap(newsTopicResponse);
  }

  @override
  Future<List<NewsFeedModel>> fetchRecentNews(
      {SortBy sortBy, int page, Language language, String token}) async {
    final newsResponse = await _remoteService.fetchRecentNews(
        sortBy: sortBy, page: page, language: language, token: token);
    final List<NewsFeedModel> feeds = newsResponse
        .map<NewsFeedModel>((e) => NewsFeedModel.fromMap(e))
        .toList();
    return feeds;
  }

  @override
  Future<List<NewsFeedModel>> fetchLatestNews(
      {SortBy sortBy, int page, Language language, String token}) async {
    final newsResponse = await _remoteService.fetchLatestNews(
        sortBy: sortBy, page: page, language: language, token: token);
    final List<NewsFeedModel> feeds = newsResponse
        .map<NewsFeedModel>((e) => NewsFeedModel.fromMap(e))
        .toList();
    return feeds;
  }

  @override
  Future<List<NewsFeedModel>> fetchNewsByCategory(
      {String categoryId,
      String sourceId,
      SortBy sortBy,
      int page,
      Language language,
      String token}) async {
    final newsResponse = await _remoteService.fetchNewsByCategory(
        categoryId: categoryId,
        sortBy: sortBy,
        sourceId: sourceId,
        page: page,
        language: language,
        token: token);
    final List<NewsFeedModel> feeds = newsResponse
        .map<NewsFeedModel>((e) => NewsFeedModel.fromMap(e))
        .toList();
    return feeds;
  }

  @override
  Future<List<NewsFeedModel>> fetchNewsBySource(
      {String sourceId,
      SortBy sortBy,
      int page,
      Language language,
      String token}) async {
    final newsResponse = await _remoteService.fetchNewsBySource(
        sourceId: sourceId,
        sortBy: sortBy,
        page: page,
        language: language,
        token: token);
    final List<NewsFeedModel> feeds = newsResponse
        .map<NewsFeedModel>((e) => NewsFeedModel.fromMap(e))
        .toList();
    return feeds;
  }

  @override
  Future<List<NewsFeedModel>> fetchNewsByTopic(
      {String topicId,
      String sourceId,
      SortBy sortBy,
      int page,
      Language language,
      String token}) async {
    final newsResponse = await _remoteService.fetchNewsByTopic(
        topicId: topicId,
        sortBy: sortBy,
        sourceId: sourceId,
        page: page,
        language: language,
        token: token);
    final List<NewsFeedModel> feeds = newsResponse
        .map<NewsFeedModel>((e) => NewsFeedModel.fromMap(e))
        .toList();
    return feeds;
  }

  @override
  Future<NewsFeedModel> fetchNewsDetail({String feedId, String token}) async {
    final newsFeedResponse =
        await _remoteService.fetchNewsDetail(feedId: feedId, token: token);
    return NewsFeedModel.fromMap(newsFeedResponse);
  }

  @override
  Future<List<NewsSourceModel>> fetchSources(
      {Language language, String token}) async {
    final response =
        await _remoteService.fetchSources(language: language, token: token);
    final List<NewsSourceModel> sources = response
        .map<NewsSourceModel>((e) => NewsSourceModel.fromMap(e))
        .toList();
    return sources;
  }

  @override
  Future<List<NewsTopicModel>> fetchTopics(
      {Language language, String token}) async {
    final response =
        await _remoteService.fetchTopics(language: language, token: token);
    final List<NewsTopicModel> call =
        response.map<NewsTopicModel>((e) => NewsTopicModel.fromMap(e)).toList();
    return call;
  }

  @override
  Future<List<NewsFeedModel>> fetchTrendingNews(
      {Language language,
      SortBy sortBy,
      int page,
      int limit,
      String token}) async {
    final newsResponse = await _remoteService.fetchTrendingNews(
        sortBy: sortBy,
        limit: limit,
        page: page,
        language: language,
        token: token);
    final List<NewsFeedModel> feeds = newsResponse
        .map<NewsFeedModel>((e) => NewsFeedModel.fromMap(e))
        .toList();
    return feeds;
  }

  @override
  Future<List<NewsFeedModel>> fetchBookmarkedNews({int page, String token}) {
    // TODO: implement getBookmarkedNews
    throw UnimplementedError();
  }

  @override
  Future<NewsFeedModel> unBookmarkFeed({String feedId, String token}) async {
    final newsFeedResponse =
        await _remoteService.unBookmarkFeed(feedId: feedId, token: token);
    return NewsFeedModel.fromMap(newsFeedResponse);
  }

  @override
  Future<List<NewsFeedModel>> fetchRelatedNews(
      {String feedId, String token}) async {
    final newsResponse =
        await _remoteService.fetchRelatedNews(parentId: feedId, token: token);
    final List<NewsFeedModel> feeds = newsResponse
        .map<NewsFeedModel>((e) => NewsFeedModel.fromMap(e))
        .toList();
    return feeds;
  }

  @override
  Future<NewsFeedModel> dislikeFeed({String feedId, String token}) async {
    final newsFeedResponse =
        await _remoteService.dislikeFeed(feedId: feedId, token: token);
    return NewsFeedModel.fromMap(newsFeedResponse);
  }

  @override
  Future<NewsFeedModel> likeFeed({String feedId, String token}) async {
    final newsFeedResponse =
        await _remoteService.likeFeed(feedId: feedId, token: token);
    return NewsFeedModel.fromMap(newsFeedResponse);
  }

  @override
  Future<NewsFeedModel> shareFeed({String feedId, String token}) async {
    final newsFeedResponse =
        await _remoteService.shareFeed(feedId: feedId, token: token);
    return NewsFeedModel.fromMap(newsFeedResponse);
  }

  @override
  Future<NewsFeedModel> undislikeFeed({String feedId, String token}) async {
    final newsFeedResponse =
        await _remoteService.undislikeFeed(feedId: feedId, token: token);
    return NewsFeedModel.fromMap(newsFeedResponse);
  }

  @override
  Future<NewsFeedModel> unlikeFeed({String feedId, String token}) async {
    final newsFeedResponse =
        await _remoteService.unlikeFeed(feedId: feedId, token: token);
    return NewsFeedModel.fromMap(newsFeedResponse);
  }

  @override
  Future<NewsFeedModel> viewFeed({String feedId, String token}) async {
    final newsFeedResponse =
        await _remoteService.viewFeed(feedId: feedId, token: token);
    return NewsFeedModel.fromMap(newsFeedResponse);
  }
}
