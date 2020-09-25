import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/feature_news/domain/models/news_category.dart';
import 'package:samachar_hub/feature_news/domain/models/news_feed.dart';
import 'package:samachar_hub/feature_news/domain/models/news_source.dart';
import 'package:samachar_hub/feature_news/domain/models/news_topic.dart';
import 'package:samachar_hub/feature_news/domain/models/sort.dart';

mixin RemoteService {
  Future<dynamic> fetchLatestNews({SortBy sortBy, int page, Language language});
  Future<dynamic> fetchRecentNews({SortBy sortBy, int page, Language language});
  Future<dynamic> fetchTrendingNews(
      {Language language, SortBy sortBy, int page, int limit});

  Future<dynamic> fetchNewsBySource(NewsSourceEntity source,
      {SortBy sortBy, int page, Language language});

  Future<dynamic> fetchNewsByCategory(NewsCategoryEntity category,
      {NewsSourceEntity source, SortBy sortBy, int page, Language language});

  Future<dynamic> fetchSources({Language language});

  Future<dynamic> fetchCategories({Language language});

  Future<dynamic> fetchTopics({Language language});

  Future<dynamic> fetchNewsByTopic(NewsTopicEntity topic,
      {NewsSourceEntity source, SortBy sortBy, int page, Language language});

  Future<dynamic> likeFeed(NewsFeedEntity feed);
  Future<dynamic> unlikeFeed(NewsFeedEntity feed);

  Future<dynamic> dislikeFeed(NewsFeedEntity feed);
  Future<dynamic> undislikeFeed(NewsFeedEntity feed);

  Future<dynamic> shareFeed(NewsFeedEntity feed);
  Future<dynamic> viewFeed(NewsFeedEntity feed);

  Future<dynamic> bookmarkFeed(NewsFeedEntity feed);
  Future<dynamic> unBookmarkFeed(NewsFeedEntity feed);
  Future<dynamic> followCategory(NewsCategoryEntity category);
  Future<dynamic> unFollowCategory(NewsCategoryEntity category);
  Future<dynamic> followSource(NewsSourceEntity source);
  Future<dynamic> unFollowSource(NewsSourceEntity source);
  Future<dynamic> followTopic(NewsTopicEntity topic);
  Future<dynamic> unFollowTopic(NewsTopicEntity topic);
  Future<dynamic> fetchRelatedNews(NewsFeedEntity parent);
}
