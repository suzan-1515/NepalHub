import 'package:flutter/foundation.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/feature_news/data/models/news_category_model.dart';
import 'package:samachar_hub/feature_news/data/models/news_feed_model.dart';
import 'package:samachar_hub/feature_news/data/models/news_source_model.dart';
import 'package:samachar_hub/feature_news/data/models/news_topic_model.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_category_entity.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_feed_entity.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_source_entity.dart';
import 'package:samachar_hub/feature_news/domain/entities/sort.dart';

mixin RemoteDataSource {
  Future<List<NewsFeedModel>> fetchLatestNews(
      {@required SortBy sortBy,
      @required int page,
      @required Language language,
      @required String token});

  Future<List<NewsFeedModel>> fetchRecentNews(
      {@required SortBy sortBy,
      @required int page,
      @required Language language,
      @required String token});

  Future<List<NewsFeedModel>> fetchTrendingNews(
      {@required Language language,
      @required SortBy sortBy,
      @required int page,
      @required int limit,
      @required String token});

  Future<List<NewsFeedModel>> fetchNewsBySource(
      {@required String sourceId,
      @required SortBy sortBy,
      @required int page,
      @required Language language,
      @required String token});

  Future<List<NewsFeedModel>> fetchNewsByCategory(
      {@required String categoryId,
      @required String sourceId,
      @required SortBy sortBy,
      @required int page,
      @required Language language,
      @required String token});

  Future<NewsFeedModel> fetchNewsDetail(
      {@required String feedId, @required String token});
  Future<List<NewsFeedModel>> fetchRelatedNews(
      {@required String feedId, @required String token});

  Future<NewsFeedModel> likeFeed(
      {@required String feedId, @required String token});
  Future<NewsFeedModel> unlikeFeed(
      {@required String feedId, @required String token});

  Future<NewsFeedModel> dislikeFeed(
      {@required String feedId, @required String token});
  Future<NewsFeedModel> undislikeFeed(
      {@required String feedId, @required String token});

  Future<NewsFeedModel> shareFeed(
      {@required String feedId, @required String token});
  Future<NewsFeedModel> viewFeed(
      {@required String feedId, @required String token});

  Future<NewsFeedModel> bookmarkFeed(
      {@required String feedId, @required String token});

  Future<NewsFeedModel> unBookmarkFeed(
      {@required String feedId, @required String token});

  Future<List<NewsFeedModel>> fetchBookmarkedNews(
      {@required int page, @required String token});

  Future<NewsSourceModel> followSource(
      {@required String sourceId, @required String token});

  Future<NewsSourceModel> unFollowSource(
      {@required String sourceId, @required String token});

  Future<NewsCategoryModel> followCategory(
      {@required String categoryId, @required String token});

  Future<NewsCategoryModel> unFollowCategory(
      {@required String categoryId, @required String token});

  Future<List<NewsSourceModel>> fetchSources(
      {@required Language language, @required String token});

  Future<List<NewsCategoryModel>> fetchCategories(
      {@required Language language, @required String token});

  Future<List<NewsTopicModel>> fetchTopics(
      {@required Language language, @required String token});

  Future<NewsTopicModel> followTopic(
      {@required String topicId, @required String token});

  Future<NewsTopicModel> unFollowTopic(
      {@required String topicId, @required String token});

  Future<List<NewsFeedModel>> fetchNewsByTopic(
      {@required String topicId,
      @required String sourceId,
      @required SortBy sortBy,
      @required int page,
      @required Language language,
      @required String token});
}
