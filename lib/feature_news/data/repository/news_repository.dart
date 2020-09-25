import 'package:flutter/foundation.dart';
import 'package:samachar_hub/core/exceptions/app_exceptions.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/network/network_info.dart';
import 'package:samachar_hub/feature_news/data/datasource/remote/remote_data_source.dart';
import 'package:samachar_hub/feature_news/domain/models/news_category.dart';
import 'package:samachar_hub/feature_news/domain/models/news_feed.dart';
import 'package:samachar_hub/feature_news/domain/models/news_source.dart';
import 'package:samachar_hub/feature_news/domain/models/news_topic.dart';
import 'package:samachar_hub/feature_news/domain/models/sort.dart';
import 'package:samachar_hub/feature_news/domain/repository/repository.dart';

class NewsRepository implements Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  NewsRepository(
      {@required RemoteDataSource remoteDataSource,
      @required NetworkInfo networkInfo})
      : this._remoteDataSource = remoteDataSource,
        this._networkInfo = networkInfo;

  @override
  Future<List<NewsFeedEntity>> getNewsByCategory(NewsCategoryEntity category,
      {NewsSourceEntity source,
      SortBy sortBy,
      int page,
      Language language}) async {
    if (!(await _networkInfo.isConnected)) throw NetworkException();
    return _remoteDataSource.fetchNewsByCategory(category,
        source: source, sortBy: sortBy, page: page, language: language);
  }

  @override
  Future<List<NewsFeedEntity>> getNewsBySource(NewsSourceEntity source,
      {SortBy sortBy, int page, Language language}) async {
    if (!(await _networkInfo.isConnected)) throw NetworkException();
    return _remoteDataSource.fetchNewsBySource(source,
        sortBy: sortBy, page: page, language: language);
  }

  @override
  Future<List<NewsFeedEntity>> getNewsByTopic(NewsTopicEntity topic,
      {NewsSourceEntity source,
      SortBy sortBy,
      int page,
      Language language}) async {
    if (!(await _networkInfo.isConnected)) throw NetworkException();
    return _remoteDataSource.fetchNewsByTopic(topic,
        source: source, sortBy: sortBy, page: page, language: language);
  }

  @override
  Future<List<NewsCategoryEntity>> getCategories({Language language}) async {
    if (!(await _networkInfo.isConnected)) throw NetworkException();
    return _remoteDataSource.fetchCategories(language: language);
  }

  @override
  Future<List<NewsFeedEntity>> getLatestNews(
      {SortBy sortBy, int page, Language language}) async {
    if (!(await _networkInfo.isConnected)) throw NetworkException();
    return _remoteDataSource.fetchLatestNews(
        sortBy: sortBy, page: page, language: language);
  }

  @override
  Future<List<NewsSourceEntity>> getSources({Language language}) async {
    if (!(await _networkInfo.isConnected)) throw NetworkException();
    return _remoteDataSource.fetchSources(language: language);
  }

  @override
  Future<List<NewsTopicEntity>> getTopics({Language language}) async {
    if (!(await _networkInfo.isConnected)) throw NetworkException();
    return _remoteDataSource.fetchTopics(language: language);
  }

  @override
  Future<List<NewsFeedEntity>> getTrendingNews(
      {NewsSourceEntity source,
      SortBy sortBy,
      int page,
      int limit,
      Language language}) async {
    if (!(await _networkInfo.isConnected)) throw NetworkException();
    return _remoteDataSource.fetchTrendingNews(
        sortBy: sortBy, page: page, limit: limit, language: language);
  }

  @override
  Future<void> bookmarkFeed(NewsFeedEntity feed) async {
    if (!(await _networkInfo.isConnected)) throw NetworkException();
    return _remoteDataSource.bookmarkFeed(feed);
  }

  @override
  Future<void> followCategory(NewsCategoryEntity category) async {
    if (!(await _networkInfo.isConnected)) throw NetworkException();
    return _remoteDataSource.followCategory(category);
  }

  @override
  Future<void> followSource(NewsSourceEntity source) async {
    if (!(await _networkInfo.isConnected)) throw NetworkException();
    return _remoteDataSource.followSource(source);
  }

  @override
  Future<List<NewsFeedEntity>> getBookmarkedNews({int page}) async {
    if (!(await _networkInfo.isConnected)) throw NetworkException();
    return _remoteDataSource.fetchBookmarkedNews(page: page);
  }

  @override
  Future<void> unBookmarkFeed(NewsFeedEntity feed) async {
    if (!(await _networkInfo.isConnected)) throw NetworkException();
    return _remoteDataSource.unBookmarkFeed(feed);
  }

  @override
  Future<void> followTopic(NewsTopicEntity topic) async {
    if (!(await _networkInfo.isConnected)) throw NetworkException();
    return _remoteDataSource.followTopic(topic);
  }

  @override
  Future<void> unFollowCategory(NewsCategoryEntity category) async {
    if (!(await _networkInfo.isConnected)) throw NetworkException();
    return _remoteDataSource.unFollowCategory(category);
  }

  @override
  Future<void> unFollowSource(NewsSourceEntity source) async {
    if (!(await _networkInfo.isConnected)) throw NetworkException();
    return _remoteDataSource.unFollowSource(source);
  }

  @override
  Future<void> unFollowTopic(NewsTopicEntity topic) async {
    if (!(await _networkInfo.isConnected)) throw NetworkException();
    return _remoteDataSource.unFollowTopic(topic);
  }

  @override
  Future<NewsFeedEntity> getNewsDetail(String feed) async {
    if (!(await _networkInfo.isConnected)) throw NetworkException();
    return _remoteDataSource.fetchNewsDetail(feed);
  }

  @override
  Future<List<NewsFeedEntity>> getRecentNews(
      {Language language, SortBy sortBy, int page}) async {
    if (!(await _networkInfo.isConnected)) throw NetworkException();
    return _remoteDataSource.fetchRecentNews(
        sortBy: sortBy, page: page, language: language);
  }

  @override
  Future<List<NewsFeedEntity>> getRelatedNews(NewsFeedEntity parentFeed) async {
    if (!(await _networkInfo.isConnected)) throw NetworkException();
    return _remoteDataSource.fetchRelatedNews(parentFeed);
  }

  @override
  Future<void> dislikeFeed(NewsFeedEntity feed) async {
    if (!(await _networkInfo.isConnected)) throw NetworkException();
    return _remoteDataSource.dislikeFeed(feed);
  }

  @override
  Future<void> likeFeed(NewsFeedEntity feed) async {
    if (!(await _networkInfo.isConnected)) throw NetworkException();
    return _remoteDataSource.likeFeed(feed);
  }

  @override
  Future<void> shareFeed(NewsFeedEntity feed) async {
    if (!(await _networkInfo.isConnected)) throw NetworkException();
    return _remoteDataSource.shareFeed(feed);
  }

  @override
  Future<void> undislikeFeed(NewsFeedEntity feed) async {
    if (!(await _networkInfo.isConnected)) throw NetworkException();
    return _remoteDataSource.undislikeFeed(feed);
  }

  @override
  Future<void> unlikeFeed(NewsFeedEntity feed) async {
    if (!(await _networkInfo.isConnected)) throw NetworkException();
    return _remoteDataSource.unlikeFeed(feed);
  }

  @override
  Future<void> viewFeed(NewsFeedEntity feed) async {
    if (!(await _networkInfo.isConnected)) throw NetworkException();
    return _remoteDataSource.viewFeed(feed);
  }
}
