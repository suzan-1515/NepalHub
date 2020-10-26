import 'package:flutter/foundation.dart';
import 'package:samachar_hub/core/exceptions/app_exceptions.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/network/network_info.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_auth/data/repositories/auth_repository.dart';
import 'package:samachar_hub/feature_news/data/datasource/remote/remote_data_source.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_category_entity.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_feed_entity.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_source_entity.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_topic_entity.dart';
import 'package:samachar_hub/feature_news/domain/entities/sort.dart';
import 'package:samachar_hub/feature_news/domain/repository/repository.dart';

class NewsRepository implements Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;
  final AnalyticsService _analyticsService;
  final AuthRepository _authRepository;

  NewsRepository({
    @required RemoteDataSource remoteDataSource,
    @required NetworkInfo networkInfo,
    @required AnalyticsService analyticsService,
    @required AuthRepository authRepository,
  })  : this._remoteDataSource = remoteDataSource,
        this._networkInfo = networkInfo,
        this._analyticsService = analyticsService,
        this._authRepository = authRepository;

  @override
  Future<List<NewsFeedEntity>> getNewsByCategory(NewsCategoryEntity category,
      {NewsSourceEntity source,
      SortBy sortBy,
      int page,
      Language language}) async {
    if (!(await _networkInfo.isConnected)) throw NetworkException();
    return _remoteDataSource.fetchNewsByCategory(
      categoryId: category.id,
      sourceId: source?.id,
      sortBy: sortBy,
      page: page,
      language: language,
      token: _authRepository.getUserToken(),
    );
  }

  @override
  Future<List<NewsFeedEntity>> getNewsBySource(
    NewsSourceEntity source, {
    SortBy sortBy,
    int page,
    Language language,
  }) async {
    if (!(await _networkInfo.isConnected)) throw NetworkException();
    return _remoteDataSource.fetchNewsBySource(
      sourceId: source.id,
      sortBy: sortBy,
      page: page,
      language: language,
      token: _authRepository.getUserToken(),
    );
  }

  @override
  Future<List<NewsFeedEntity>> getNewsByTopic(NewsTopicEntity topic,
      {NewsSourceEntity source,
      SortBy sortBy,
      int page,
      Language language}) async {
    if (!(await _networkInfo.isConnected)) throw NetworkException();
    return _remoteDataSource.fetchNewsByTopic(
      topicId: topic.title,
      sourceId: source?.id,
      sortBy: sortBy,
      page: page,
      language: language,
      token: _authRepository.getUserToken(),
    );
  }

  @override
  Future<List<NewsCategoryEntity>> getCategories({Language language}) async {
    if (!(await _networkInfo.isConnected)) throw NetworkException();
    return _remoteDataSource.fetchCategories(
      language: language,
      token: _authRepository.getUserToken(),
    );
  }

  @override
  Future<List<NewsFeedEntity>> getLatestNews({
    SortBy sortBy,
    int page,
    Language language,
  }) async {
    if (!(await _networkInfo.isConnected)) throw NetworkException();
    return _remoteDataSource.fetchLatestNews(
      sortBy: sortBy,
      page: page,
      language: language,
      token: _authRepository.getUserToken(),
    );
  }

  @override
  Future<List<NewsSourceEntity>> getSources({Language language}) async {
    if (!(await _networkInfo.isConnected)) throw NetworkException();
    return _remoteDataSource.fetchSources(
      language: language,
      token: _authRepository.getUserToken(),
    );
  }

  @override
  Future<List<NewsTopicEntity>> getTopics({Language language}) async {
    if (!(await _networkInfo.isConnected)) throw NetworkException();
    return _remoteDataSource.fetchTopics(
      language: language,
      token: _authRepository.getUserToken(),
    );
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
      sortBy: sortBy,
      page: page,
      limit: limit,
      language: language,
      token: _authRepository.getUserToken(),
    );
  }

  @override
  Future<NewsFeedEntity> bookmarkFeed(NewsFeedEntity feed) async {
    if (!(await _networkInfo.isConnected)) throw NetworkException();
    return _remoteDataSource
        .bookmarkFeed(
      feedId: feed.id,
      token: _authRepository.getUserToken(),
    )
        .then((value) {
      _analyticsService.logNewsBookmark(feedId: feed.id);
      return value;
    });
  }

  @override
  Future<NewsCategoryEntity> followCategory(NewsCategoryEntity category) async {
    if (!(await _networkInfo.isConnected)) throw NetworkException();
    return _remoteDataSource
        .followCategory(
      categoryId: category.id,
      token: _authRepository.getUserToken(),
    )
        .then((value) {
      _analyticsService.logNewsCategoryFollow(categoryId: category.id);
      return value;
    });
  }

  @override
  Future<NewsSourceEntity> followSource(NewsSourceEntity source) async {
    if (!(await _networkInfo.isConnected)) throw NetworkException();
    return _remoteDataSource
        .followSource(
      sourceId: source.id,
      token: _authRepository.getUserToken(),
    )
        .then((value) {
      _analyticsService.logNewsSourceFollow(sourceId: source.id);
      return value;
    });
  }

  @override
  Future<List<NewsFeedEntity>> getBookmarkedNews({int page}) async {
    if (!(await _networkInfo.isConnected)) throw NetworkException();
    return _remoteDataSource.fetchBookmarkedNews(
      page: page,
      token: _authRepository.getUserToken(),
    );
  }

  @override
  Future<NewsFeedEntity> unBookmarkFeed(NewsFeedEntity feed) async {
    if (!(await _networkInfo.isConnected)) throw NetworkException();
    return _remoteDataSource
        .unBookmarkFeed(
      feedId: feed.id,
      token: _authRepository.getUserToken(),
    )
        .then((value) {
      _analyticsService.logNewsUnBookmark(feedId: feed.id);
      return value;
    });
  }

  @override
  Future<NewsTopicEntity> followTopic(NewsTopicEntity topic) async {
    if (!(await _networkInfo.isConnected)) throw NetworkException();
    return _remoteDataSource
        .followTopic(
      topicId: topic.id,
      token: _authRepository.getUserToken(),
    )
        .then((value) {
      _analyticsService.logNewsTopicFollow(topicId: topic.id);
      return value;
    });
  }

  @override
  Future<NewsCategoryEntity> unFollowCategory(
      NewsCategoryEntity category) async {
    if (!(await _networkInfo.isConnected)) throw NetworkException();
    return _remoteDataSource
        .unFollowCategory(
      categoryId: category.id,
      token: _authRepository.getUserToken(),
    )
        .then((value) {
      _analyticsService.logNewsCategoryUnFollow(categoryId: category.id);
      return value;
    });
  }

  @override
  Future<NewsSourceEntity> unFollowSource(NewsSourceEntity source) async {
    if (!(await _networkInfo.isConnected)) throw NetworkException();
    return _remoteDataSource
        .unFollowSource(
      sourceId: source.id,
      token: _authRepository.getUserToken(),
    )
        .then((value) {
      _analyticsService.logNewsSourceUnFollow(sourceId: source.id);
      return value;
    });
  }

  @override
  Future<NewsTopicEntity> unFollowTopic(NewsTopicEntity topic) async {
    if (!(await _networkInfo.isConnected)) throw NetworkException();
    return _remoteDataSource
        .unFollowTopic(
      topicId: topic.id,
      token: _authRepository.getUserToken(),
    )
        .then((value) {
      _analyticsService.logNewsTopicUnFollow(topicId: topic.id);
      return value;
    });
  }

  @override
  Future<NewsFeedEntity> getNewsDetail(String feed) async {
    if (!(await _networkInfo.isConnected)) throw NetworkException();
    return _remoteDataSource.fetchNewsDetail(
      feedId: feed,
      token: _authRepository.getUserToken(),
    );
  }

  @override
  Future<List<NewsFeedEntity>> getRecentNews(
      {Language language, SortBy sortBy, int page}) async {
    if (!(await _networkInfo.isConnected)) throw NetworkException();
    return _remoteDataSource.fetchRecentNews(
      sortBy: sortBy,
      page: page,
      language: language,
      token: _authRepository.getUserToken(),
    );
  }

  @override
  Future<List<NewsFeedEntity>> getRelatedNews(NewsFeedEntity parentFeed) async {
    if (!(await _networkInfo.isConnected)) throw NetworkException();
    return _remoteDataSource.fetchRelatedNews(
      feedId: parentFeed.uuid,
      token: _authRepository.getUserToken(),
    );
  }

  @override
  Future<NewsFeedEntity> dislikeFeed(NewsFeedEntity feed) async {
    if (!(await _networkInfo.isConnected)) throw NetworkException();
    return _remoteDataSource
        .dislikeFeed(
      feedId: feed.id,
      token: _authRepository.getUserToken(),
    )
        .then((value) {
      _analyticsService.logNewsDislike(feedId: feed.id);
      return value;
    });
  }

  @override
  Future<NewsFeedEntity> likeFeed(NewsFeedEntity feed) async {
    if (!(await _networkInfo.isConnected)) throw NetworkException();
    return _remoteDataSource
        .likeFeed(
      feedId: feed.id,
      token: _authRepository.getUserToken(),
    )
        .then((value) {
      _analyticsService.logNewsLike(feedId: feed.id);
      return value;
    });
  }

  @override
  Future<NewsFeedEntity> shareFeed(NewsFeedEntity feed) async {
    if (!(await _networkInfo.isConnected)) throw NetworkException();
    return _remoteDataSource
        .shareFeed(
      feedId: feed.id,
      token: _authRepository.getUserToken(),
    )
        .then((value) {
      _analyticsService.logNewsShare(feedId: feed.id);
      return value;
    });
  }

  @override
  Future<NewsFeedEntity> undislikeFeed(NewsFeedEntity feed) async {
    if (!(await _networkInfo.isConnected)) throw NetworkException();
    return _remoteDataSource
        .undislikeFeed(
      feedId: feed.id,
      token: _authRepository.getUserToken(),
    )
        .then((value) {
      _analyticsService.logNewsUndislike(feedId: feed.id);
      return value;
    });
  }

  @override
  Future<NewsFeedEntity> unlikeFeed(NewsFeedEntity feed) async {
    if (!(await _networkInfo.isConnected)) throw NetworkException();
    return _remoteDataSource
        .unlikeFeed(
      feedId: feed.id,
      token: _authRepository.getUserToken(),
    )
        .then((value) {
      _analyticsService.logNewsUnlike(feedId: feed.id);
      return value;
    });
  }

  @override
  Future<NewsFeedEntity> viewFeed(NewsFeedEntity feed) async {
    if (!(await _networkInfo.isConnected)) throw NetworkException();
    return _remoteDataSource
        .viewFeed(
      feedId: feed.id,
      token: _authRepository.getUserToken(),
    )
        .then((value) {
      _analyticsService.logNewsView(feedId: feed.id);
      return value;
    });
  }
}
