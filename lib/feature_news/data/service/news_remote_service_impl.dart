import 'package:samachar_hub/core/constants/api_url_constants.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/network/http_manager/http_manager.dart';
import 'package:samachar_hub/feature_news/data/service/remote_service.dart';
import 'package:samachar_hub/feature_news/domain/models/news_category.dart';
import 'package:samachar_hub/feature_news/domain/models/news_feed.dart';
import 'package:samachar_hub/feature_news/domain/models/news_source.dart';
import 'package:samachar_hub/feature_news/domain/models/news_topic.dart';
import 'package:samachar_hub/feature_news/domain/models/sort.dart';
import 'package:samachar_hub/core/extensions/api_paging.dart';

class NewsRemoteService implements RemoteService {
  static const String _news = '/news-feeds';
  static const String _newsCategory = '/news-categories';
  static const String _newsSource = '/news-sources';
  static const String _newsTopic = '/news-topics';
  static const String _newsBookmark = _news + '/bookmark';
  static const String _newsCategoryFollow = _newsCategory + '/follow';
  static const String _newsSourceFollow = _newsSource + '/follow';
  static const String _newsTopicFollow = _newsTopic + '/follow';
  static const String _newsLike = _news + '/like';
  static const String _newsDislike = _news + '/dislike';
  static const String _newsShare = _news + '/share';
  static const String _newsView = _news + '/view';
  final HttpManager httpManager;

  NewsRemoteService(this.httpManager);

  @override
  Future fetchLatestNews(
      {NewsSourceEntity source,
      SortBy sortBy,
      int page = 1,
      Language language = Language.NEPALI}) async {
    final Map<String, dynamic> queryParams = {
      'type': 'latest',
      '_start': page.start,
      '_limit': page.limit,
      'language': language.value
    };
    var latestNewsCall =
        httpManager.get(url: baseApiURL + _news, query: queryParams);

    return latestNewsCall;
  }

  @override
  Future fetchTrendingNews(
      {SortBy sortBy,
      int page = 1,
      int limit,
      Language language = Language.NEPALI}) async {
    final Map<String, dynamic> queryParams = {
      'type': 'trending',
      '_start': page.start,
      '_limit': limit ?? page.limit,
      'language': language.value
    };
    var trendingNewsCall =
        httpManager.get(url: baseApiURL + _news, query: queryParams);

    return trendingNewsCall;
  }

  @override
  Future fetchNewsBySource(NewsSourceEntity source,
      {SortBy sortBy,
      int page = 1,
      Language language = Language.NEPALI}) async {
    final Map<String, dynamic> queryParams = {
      'source': source.id,
      '_start': page.start,
      '_limit': page.limit,
      'language': language.value
    };
    var newsCall = httpManager.get(url: baseApiURL + _news, query: queryParams);

    return newsCall;
  }

  @override
  Future fetchNewsByCategory(NewsCategoryEntity category,
      {NewsSourceEntity source,
      SortBy sortBy,
      int page = 1,
      Language language = Language.NEPALI}) async {
    final Map<String, dynamic> queryParams = {
      'category': category.id,
      'source': source?.id,
      '_start': page.start,
      '_limit': page.limit,
      'language': language.value
    };
    var newsCall = httpManager.get(url: baseApiURL + _news, query: queryParams);

    return newsCall;
  }

  @override
  Future fetchSources({Language language = Language.NEPALI}) async {
    final Map<String, dynamic> queryParams = {'language': language.value};
    var sourceCall =
        httpManager.get(url: baseApiURL + _newsSource, query: queryParams);

    return sourceCall;
  }

  @override
  Future fetchTopics({Language language = Language.NEPALI}) async {
    final Map<String, dynamic> queryParams = {'language': language.value};
    var topicCall =
        httpManager.get(url: baseApiURL + _newsTopic, query: queryParams);

    return topicCall;
  }

  @override
  Future fetchNewsByTopic(NewsTopicEntity topic,
      {NewsSourceEntity source,
      SortBy sortBy,
      int page = 1,
      Language language = Language.NEPALI}) async {
    final Map<String, dynamic> queryParams = {
      'topics.id': topic.id,
      'source': source?.id,
      '_start': page.start,
      '_limit': page.limit,
      'language': language.value
    };
    var tagNewsCall =
        httpManager.get(url: baseApiURL + _news, query: queryParams);

    return tagNewsCall;
  }

  @override
  Future fetchCategories({Language language = Language.NEPALI}) async {
    final Map<String, dynamic> queryParams = {'language': language.value};
    var categoryCall =
        httpManager.get(url: baseApiURL + _newsCategory, query: queryParams);

    return categoryCall;
  }

  @override
  Future fetchRecentNews({SortBy sortBy, int page, Language language}) {
    final Map<String, dynamic> queryParams = {
      'type': 'recent',
      '_start': page.start,
      '_limit': page.limit,
      'language': language.value
    };
    var latestNewsCall =
        httpManager.get(url: baseApiURL + _news, query: queryParams);

    return latestNewsCall;
  }

  @override
  Future bookmarkFeed(NewsFeedEntity feed) {
    final Map<String, dynamic> body = {
      'feed_id': feed.id,
    };
    var bookmarkCall =
        httpManager.post(url: baseApiURL + _newsBookmark, body: body);

    return bookmarkCall;
  }

  @override
  Future unBookmarkFeed(NewsFeedEntity feed) {
    final parameter = '/${feed.id}';
    var bookmarkCall =
        httpManager.delete(url: baseApiURL + _newsBookmark + parameter);

    return bookmarkCall;
  }

  @override
  Future followCategory(NewsCategoryEntity category) {
    final Map<String, dynamic> body = {
      'category_id': category.id,
    };
    var call =
        httpManager.post(url: baseApiURL + _newsCategoryFollow, body: body);

    return call;
  }

  @override
  Future followSource(NewsSourceEntity source) {
    final Map<String, dynamic> body = {
      'source_id': source.id,
    };
    var call =
        httpManager.post(url: baseApiURL + _newsSourceFollow, body: body);

    return call;
  }

  @override
  Future unFollowCategory(NewsCategoryEntity category) {
    final parameter = '/${category.id}';
    var call =
        httpManager.delete(url: baseApiURL + _newsCategoryFollow + parameter);

    return call;
  }

  @override
  Future unFollowSource(NewsSourceEntity source) {
    final parameter = '/${source.id}';
    var call =
        httpManager.delete(url: baseApiURL + _newsCategoryFollow + parameter);

    return call;
  }

  @override
  Future followTopic(NewsTopicEntity topic) {
    final Map<String, dynamic> body = {
      'topic_id': topic.id,
    };
    var call = httpManager.post(url: baseApiURL + _newsTopicFollow, body: body);

    return call;
  }

  @override
  Future unFollowTopic(NewsTopicEntity topic) {
    final parameter = '/${topic.id}';
    var call =
        httpManager.delete(url: baseApiURL + _newsCategoryFollow + parameter);

    return call;
  }

  @override
  Future fetchRelatedNews(NewsFeedEntity parent) {
    final Map<String, dynamic> queryParams = {
      'parent_id': parent.uuid,
    };
    var call = httpManager.get(url: baseApiURL + _news, query: queryParams);

    return call;
  }

  @override
  Future dislikeFeed(NewsFeedEntity feed) {
    final Map<String, dynamic> body = {
      'feed_id': feed.id,
    };
    var call = httpManager.post(url: baseApiURL + _newsDislike, body: body);

    return call;
  }

  @override
  Future likeFeed(NewsFeedEntity feed) {
    final Map<String, dynamic> body = {
      'feed_id': feed.id,
    };
    var call = httpManager.post(url: baseApiURL + _newsLike, body: body);

    return call;
  }

  @override
  Future shareFeed(NewsFeedEntity feed) {
    final Map<String, dynamic> body = {
      'feed_id': feed.id,
    };
    var call = httpManager.post(url: baseApiURL + _newsShare, body: body);

    return call;
  }

  @override
  Future undislikeFeed(NewsFeedEntity feed) {
    final parameter = '/${feed.id}';
    var call = httpManager.delete(url: baseApiURL + _newsDislike + parameter);

    return call;
  }

  @override
  Future unlikeFeed(NewsFeedEntity feed) {
    final parameter = '/${feed.id}';
    var call = httpManager.delete(url: baseApiURL + _newsLike + parameter);

    return call;
  }

  @override
  Future viewFeed(NewsFeedEntity feed) {
    final Map<String, dynamic> body = {
      'feed_id': feed.id,
    };
    var call = httpManager.post(url: baseApiURL + _newsView, body: body);

    return call;
  }
}
