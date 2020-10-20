import 'package:flutter/foundation.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/feature_news/domain/models/news_category.dart';
import 'package:samachar_hub/feature_news/domain/models/news_feed.dart';
import 'package:samachar_hub/feature_news/domain/models/news_source.dart';
import 'package:samachar_hub/feature_news/domain/models/news_topic.dart';
import 'package:samachar_hub/feature_news/domain/models/sort.dart';

mixin Repository {
  Future<List<NewsFeedEntity>> getLatestNews(
      {@required Language language,
      @required SortBy sortBy,
      @required int page});
  Future<List<NewsFeedEntity>> getRecentNews(
      {@required Language language,
      @required SortBy sortBy,
      @required int page});

  Future<List<NewsFeedEntity>> getTrendingNews(
      {@required Language language,
      @required SortBy sortBy,
      @required int page,
      @required int limit});

  Future<List<NewsFeedEntity>> getNewsBySource(NewsSourceEntity source,
      {@required Language language,
      @required SortBy sortBy,
      @required int page});

  Future<List<NewsFeedEntity>> getNewsByCategory(NewsCategoryEntity category,
      {@required Language language,
      @required NewsSourceEntity source,
      @required SortBy sortBy,
      @required int page});

  Future<List<NewsFeedEntity>> getRelatedNews(NewsFeedEntity parentFeed);

  Future<NewsFeedEntity> getNewsDetail(String feedId);

  Future<NewsFeedEntity> likeFeed(NewsFeedEntity feed);
  Future<NewsFeedEntity> unlikeFeed(NewsFeedEntity feed);

  Future<NewsFeedEntity> dislikeFeed(NewsFeedEntity feed);
  Future<NewsFeedEntity> undislikeFeed(NewsFeedEntity feed);

  Future<NewsFeedEntity> shareFeed(NewsFeedEntity feed);
  Future<NewsFeedEntity> viewFeed(NewsFeedEntity feed);

  Future<NewsFeedEntity> bookmarkFeed(NewsFeedEntity feed);

  Future<NewsFeedEntity> unBookmarkFeed(NewsFeedEntity feed);

  Future<NewsSourceEntity> followSource(NewsSourceEntity source);

  Future<NewsSourceEntity> unFollowSource(NewsSourceEntity source);

  Future<List<NewsSourceEntity>> getSources({@required Language language});

  Future<List<NewsCategoryEntity>> getCategories({@required Language language});

  Future<NewsCategoryEntity> followCategory(NewsCategoryEntity category);

  Future<NewsCategoryEntity> unFollowCategory(NewsCategoryEntity category);

  Future<List<NewsTopicEntity>> getTopics({@required Language language});

  Future<NewsTopicEntity> followTopic(NewsTopicEntity topic);

  Future<NewsTopicEntity> unFollowTopic(NewsTopicEntity topic);

  Future<List<NewsFeedEntity>> getNewsByTopic(NewsTopicEntity topic,
      {@required Language language,
      @required NewsSourceEntity source,
      @required SortBy sortBy,
      @required int page});

  Future<List<NewsFeedEntity>> getBookmarkedNews({@required int page});
}
