import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/feature_news/data/datasource/remote/remote_data_source.dart';
import 'package:samachar_hub/feature_news/data/models/news_category_model.dart';
import 'package:samachar_hub/feature_news/data/models/news_feed_model.dart';
import 'package:samachar_hub/feature_news/data/models/news_source_model.dart';
import 'package:samachar_hub/feature_news/data/models/news_topic_model.dart';
import 'package:samachar_hub/feature_news/data/service/remote_service.dart';
import 'package:samachar_hub/feature_news/domain/models/news_category.dart';
import 'package:samachar_hub/feature_news/domain/models/news_feed.dart';
import 'package:samachar_hub/feature_news/domain/models/news_source.dart';
import 'package:samachar_hub/feature_news/domain/models/news_topic.dart';
import 'package:samachar_hub/feature_news/domain/models/sort.dart';

class NewsRemoteDataSource implements RemoteDataSource {
  final RemoteService _remoteService;

  NewsRemoteDataSource(this._remoteService);

  @override
  Future<List<NewsCategoryModel>> fetchCategories({Language language}) async {
    final responseList =
        await _remoteService.fetchCategories(language: language);
    final categoriesResponse =
        responseList.map((e) => NewsCategoryModel.fromMap(e));
    return categoriesResponse;
  }

  @override
  Future<void> bookmarkFeed(NewsFeedEntity feed) {
    return _remoteService.bookmarkFeed(feed);
  }

  @override
  Future<void> followCategory(NewsCategoryEntity category) {
    return _remoteService.followCategory(category);
  }

  @override
  Future<void> followSource(NewsSourceEntity source) {
    return _remoteService.followSource(source);
  }

  @override
  Future<void> followTopic(NewsTopicEntity topic) {
    return _remoteService.followTopic(topic);
  }

  @override
  Future<void> unFollowCategory(NewsCategoryEntity category) {
    return _remoteService.unFollowCategory(category);
  }

  @override
  Future<void> unFollowSource(NewsSourceEntity source) {
    return _remoteService.unFollowSource(source);
  }

  @override
  Future<void> unFollowTopic(NewsTopicEntity topic) {
    return _remoteService.unFollowTopic(topic);
  }

  @override
  Future<List<NewsFeedModel>> fetchRecentNews(
      {SortBy sortBy, int page, Language language}) async {
    final newsResponse = await _remoteService.fetchRecentNews(
        sortBy: sortBy, page: page, language: language);
    final feeds = newsResponse.map((e) => NewsFeedModel.fromMap(e)).toList();
    return feeds;
  }

  @override
  Future<List<NewsFeedModel>> fetchLatestNews(
      {SortBy sortBy, int page, Language language}) async {
    final newsResponse = await _remoteService.fetchLatestNews(
        sortBy: sortBy, page: page, language: language);
    final feeds = newsResponse.map((e) => NewsFeedModel.fromMap(e)).toList();
    return feeds;
  }

  @override
  Future<List<NewsFeedModel>> fetchNewsByCategory(NewsCategoryEntity category,
      {NewsSourceEntity source,
      SortBy sortBy,
      int page,
      Language language}) async {
    final newsResponse = await _remoteService.fetchNewsByCategory(category,
        sortBy: sortBy, page: page, language: language);
    final feeds = newsResponse.map((e) => NewsFeedModel.fromMap(e)).toList();
    return feeds;
  }

  @override
  Future<List<NewsFeedModel>> fetchNewsBySource(NewsSourceEntity source,
      {SortBy sortBy, int page, Language language}) async {
    final newsResponse = await _remoteService.fetchNewsBySource(source,
        sortBy: sortBy, page: page, language: language);
    final feeds = newsResponse.map((e) => NewsFeedModel.fromMap(e)).toList();
    return feeds;
  }

  @override
  Future<List<NewsFeedModel>> fetchNewsByTopic(NewsTopicEntity topic,
      {NewsSourceEntity source,
      SortBy sortBy,
      int page,
      Language language}) async {
    final newsResponse = await _remoteService.fetchNewsByTopic(topic,
        sortBy: sortBy, page: page, language: language);
    final feeds = newsResponse.map((e) => NewsFeedModel.fromMap(e)).toList();
    return feeds;
  }

  @override
  Future<NewsFeedModel> fetchNewsDetail(String feedId) {}

  @override
  Future<List<NewsSourceModel>> fetchSources({Language language}) async {
    final response = await _remoteService.fetchSources(language: language);
    final sources = response.map((e) => NewsSourceModel.fromMap(e));
    return sources;
  }

  @override
  Future<List<NewsTopicModel>> fetchTopics({Language language}) async {
    final response = await _remoteService.fetchTopics(language: language);
    final call = response.map((e) => NewsTopicModel.fromMap(e));
    return call;
  }

  @override
  Future<List<NewsFeedModel>> fetchTrendingNews(
      {Language language, SortBy sortBy, int page, int limit}) async {
    final newsResponse = await _remoteService.fetchTrendingNews(
        sortBy: sortBy, page: page, language: language);
    final feeds = newsResponse.map((e) => NewsFeedModel.fromMap(e)).toList();
    return feeds;
  }

  @override
  Future<List<NewsFeedModel>> fetchBookmarkedNews({int page}) {
    // TODO: implement getBookmarkedNews
    throw UnimplementedError();
  }

  @override
  Future<void> unBookmarkFeed(NewsFeedEntity feed) {
    return _remoteService.unBookmarkFeed(feed);
  }

  @override
  Future<List<NewsFeedModel>> fetchRelatedNews(NewsFeedEntity feed) async {
    final newsResponse = await _remoteService.fetchRelatedNews(feed);
    final feeds = newsResponse.map((e) => NewsFeedModel.fromMap(e)).toList();
    return feeds;
  }

  @override
  Future<void> dislikeFeed(NewsFeedEntity feed) {
    // TODO: implement dislikeFeed
    throw UnimplementedError();
  }

  @override
  Future<void> likeFeed(NewsFeedEntity feed) {
    // TODO: implement likeFeed
    throw UnimplementedError();
  }

  @override
  Future<void> shareFeed(NewsFeedEntity feed) {
    // TODO: implement shareFeed
    throw UnimplementedError();
  }

  @override
  Future<void> undislikeFeed(NewsFeedEntity feed) {
    // TODO: implement undislikeFeed
    throw UnimplementedError();
  }

  @override
  Future<void> unlikeFeed(NewsFeedEntity feed) {
    // TODO: implement unlikeFeed
    throw UnimplementedError();
  }

  @override
  Future<void> viewFeed(NewsFeedEntity feed) {
    // TODO: implement viewFeed
    throw UnimplementedError();
  }
}
