import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/feature_news/domain/models/news_category.dart';
import 'package:samachar_hub/feature_news/domain/models/news_feed.dart';
import 'package:samachar_hub/feature_news/domain/models/news_source.dart';
import 'package:samachar_hub/feature_news/domain/models/news_topic.dart';
import 'package:samachar_hub/feature_news/domain/models/sort.dart';

mixin Repository {
  Future<List<NewsFeedEntity>> getLatestNews(
      {Language language, SortBy sortBy, int page});
  Future<List<NewsFeedEntity>> getRecentNews(
      {Language language, SortBy sortBy, int page});

  Future<List<NewsFeedEntity>> getTrendingNews(
      {Language language, SortBy sortBy, int page, int limit});

  Future<List<NewsFeedEntity>> getNewsBySource(NewsSourceEntity source,
      {Language language, SortBy sortBy, int page});

  Future<List<NewsFeedEntity>> getNewsByCategory(NewsCategoryEntity category,
      {Language language, NewsSourceEntity source, SortBy sortBy, int page});

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

  Future<List<NewsSourceEntity>> getSources({Language language});

  Future<List<NewsCategoryEntity>> getCategories({Language language});

  Future<NewsCategoryEntity> followCategory(NewsCategoryEntity category);

  Future<NewsCategoryEntity> unFollowCategory(NewsCategoryEntity category);

  Future<List<NewsTopicEntity>> getTopics({Language language});

  Future<NewsTopicEntity> followTopic(NewsTopicEntity topic);

  Future<NewsTopicEntity> unFollowTopic(NewsTopicEntity topic);

  Future<List<NewsFeedEntity>> getNewsByTopic(NewsTopicEntity topic,
      {Language language, NewsSourceEntity source, SortBy sortBy, int page});

  Future<List<NewsFeedEntity>> getBookmarkedNews({int page});
}
