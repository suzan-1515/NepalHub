import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/feature_news/data/models/news_category_model.dart';
import 'package:samachar_hub/feature_news/data/models/news_feed_model.dart';
import 'package:samachar_hub/feature_news/data/models/news_source_model.dart';
import 'package:samachar_hub/feature_news/data/models/news_topic_model.dart';
import 'package:samachar_hub/feature_news/domain/models/news_category.dart';
import 'package:samachar_hub/feature_news/domain/models/news_feed.dart';
import 'package:samachar_hub/feature_news/domain/models/news_source.dart';
import 'package:samachar_hub/feature_news/domain/models/news_topic.dart';
import 'package:samachar_hub/feature_news/domain/models/sort.dart';

mixin RemoteDataSource {
  Future<List<NewsFeedModel>> fetchLatestNews(
      {SortBy sortBy, int page, Language language});

  Future<List<NewsFeedModel>> fetchRecentNews(
      {SortBy sortBy, int page, Language language});

  Future<List<NewsFeedModel>> fetchTrendingNews(
      {Language language, SortBy sortBy, int page, int limit});

  Future<List<NewsFeedModel>> fetchNewsBySource(NewsSourceEntity source,
      {SortBy sortBy, int page, Language language});

  Future<List<NewsFeedModel>> fetchNewsByCategory(NewsCategoryEntity category,
      {NewsSourceEntity source, SortBy sortBy, int page, Language language});

  Future<NewsFeedModel> fetchNewsDetail(String feedId);
  Future<List<NewsFeedModel>> fetchRelatedNews(NewsFeedEntity feed);

  Future<void> likeFeed(NewsFeedEntity feed);
  Future<void> unlikeFeed(NewsFeedEntity feed);

  Future<void> dislikeFeed(NewsFeedEntity feed);
  Future<void> undislikeFeed(NewsFeedEntity feed);

  Future<void> shareFeed(NewsFeedEntity feed);
  Future<void> viewFeed(NewsFeedEntity feed);

  Future<void> bookmarkFeed(NewsFeedEntity feed);

  Future<void> unBookmarkFeed(NewsFeedEntity feed);

  Future<List<NewsFeedModel>> fetchBookmarkedNews({int page});

  Future<void> followSource(NewsSourceEntity source);

  Future<void> unFollowSource(NewsSourceEntity source);

  Future<void> followCategory(NewsCategoryEntity category);

  Future<void> unFollowCategory(NewsCategoryEntity category);

  Future<List<NewsSourceModel>> fetchSources({Language language});

  Future<List<NewsCategoryModel>> fetchCategories({Language language});

  Future<List<NewsTopicModel>> fetchTopics({Language language});

  Future<void> followTopic(NewsTopicEntity topic);

  Future<void> unFollowTopic(NewsTopicEntity topic);

  Future<List<NewsFeedModel>> fetchNewsByTopic(NewsTopicEntity topic,
      {NewsSourceEntity source, SortBy sortBy, int page, Language language});
}
