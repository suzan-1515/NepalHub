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

  Future<void> likeFeed(NewsFeedEntity feed);
  Future<void> unlikeFeed(NewsFeedEntity feed);

  Future<void> dislikeFeed(NewsFeedEntity feed);
  Future<void> undislikeFeed(NewsFeedEntity feed);

  Future<void> shareFeed(NewsFeedEntity feed);
  Future<void> viewFeed(NewsFeedEntity feed);

  Future<void> bookmarkFeed(NewsFeedEntity feed);

  Future<void> unBookmarkFeed(NewsFeedEntity feed);

  Future<void> followSource(NewsSourceEntity source);

  Future<void> unFollowSource(NewsSourceEntity source);

  Future<List<NewsSourceEntity>> getSources({Language language});

  Future<List<NewsCategoryEntity>> getCategories({Language language});

  Future<void> followCategory(NewsCategoryEntity category);

  Future<void> unFollowCategory(NewsCategoryEntity category);

  Future<List<NewsTopicEntity>> getTopics({Language language});

  Future<void> followTopic(NewsTopicEntity topic);

  Future<void> unFollowTopic(NewsTopicEntity topic);

  Future<List<NewsFeedEntity>> getNewsByTopic(NewsTopicEntity topic,
      {Language language, NewsSourceEntity source, SortBy sortBy, int page});

  Future<List<NewsFeedEntity>> getBookmarkedNews({int page});
}
