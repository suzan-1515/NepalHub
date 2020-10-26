import 'package:flutter/foundation.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/feature_news/domain/entities/sort.dart';

mixin RemoteService {
  Future<dynamic> fetchLatestNews(
      {@required SortBy sortBy,
      @required int page,
      @required Language language,
      @required String token});
  Future<dynamic> fetchRecentNews(
      {@required SortBy sortBy,
      @required int page,
      @required Language language,
      @required String token});
  Future<dynamic> fetchTrendingNews(
      {@required Language language,
      @required SortBy sortBy,
      @required int page,
      @required int limit,
      @required String token});

  Future<dynamic> fetchNewsBySource(
      {@required String sourceId,
      @required SortBy sortBy,
      @required int page,
      @required Language language,
      @required String token});

  Future<dynamic> fetchNewsByCategory(
      {@required String categoryId,
      @required String sourceId,
      @required SortBy sortBy,
      @required int page,
      @required Language language,
      @required String token});

  Future<dynamic> fetchSources(
      {@required Language language, @required String token});

  Future<dynamic> fetchCategories(
      {@required Language language, @required String token});

  Future<dynamic> fetchTopics(
      {@required Language language, @required String token});

  Future<dynamic> fetchNewsByTopic(
      {@required String topicId,
      @required String sourceId,
      @required SortBy sortBy,
      @required int page,
      @required Language language,
      @required String token});
  Future<dynamic> fetchBookmarkedNews(
      {@required int page, @required String token});

  Future<dynamic> fetchNewsDetail(
      {@required String feedId, @required String token});

  Future<dynamic> likeFeed({@required String feedId, @required String token});
  Future<dynamic> unlikeFeed({@required String feedId, @required String token});

  Future<dynamic> dislikeFeed(
      {@required String feedId, @required String token});
  Future<dynamic> undislikeFeed(
      {@required String feedId, @required String token});

  Future<dynamic> shareFeed({@required String feedId, @required String token});
  Future<dynamic> viewFeed({@required String feedId, @required String token});

  Future<dynamic> bookmarkFeed(
      {@required String feedId, @required String token});
  Future<dynamic> unBookmarkFeed(
      {@required String feedId, @required String token});
  Future<dynamic> followCategory(
      {@required String categoryId, @required String token});
  Future<dynamic> unFollowCategory(
      {@required String categoryId, @required String token});
  Future<dynamic> followSource(
      {@required String sourceId, @required String token});
  Future<dynamic> unFollowSource(
      {@required String sourceId, @required String token});
  Future<dynamic> followTopic(
      {@required String topicId, @required String token});
  Future<dynamic> unFollowTopic(
      {@required String topicId, @required String token});
  Future<dynamic> fetchRelatedNews(
      {@required String parentId, @required String token});
}
