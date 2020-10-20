import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/network/http_manager/http_manager.dart';
import 'package:samachar_hub/feature_news/data/service/remote_service.dart';
import 'package:samachar_hub/feature_news/domain/models/news_source.dart';
import 'package:samachar_hub/feature_news/domain/models/sort.dart';
import 'package:samachar_hub/core/extensions/api_paging.dart';

class NewsRemoteService implements RemoteService {
  static const String NEWS = '/news-feeds';
  static const String NEWS_CATEGORY = '/news-categories';
  static const String NEWS_SOURCE = '/news-sources';
  static const String NEWS_TOPIC = '/news-topics';
  static const String NEWS_BOOKMARK = NEWS + '/bookmark';
  static const String NEWS_CATEGORY_FOLLOW = NEWS_CATEGORY + '/follow';
  static const String NEWS_SOURCE_FOLLOW = NEWS_SOURCE + '/follow';
  static const String NEWS_TOPIC_FOLLOW = NEWS_TOPIC + '/follow';
  static const String NEWS_LIKE = NEWS + '/like';
  static const String NEWS_DISLIKE = NEWS + '/dislike';
  static const String NEWS_SHARE = NEWS + '/share';
  static const String NEWS_VIEW = NEWS + '/view';
  final HttpManager httpManager;

  NewsRemoteService(this.httpManager);

  @override
  Future fetchLatestNews(
      {NewsSourceEntity source,
      SortBy sortBy,
      int page,
      Language language = Language.NEPALI,
      String token}) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    final Map<String, dynamic> queryParams = {
      'type': 'latest',
      '_start': page.start,
      '_limit': page.limit,
      'language': language.value
    };
    var latestNewsCall =
        httpManager.get(path: NEWS, query: queryParams, headers: headers);

    return latestNewsCall;
  }

  @override
  Future fetchTrendingNews({
    SortBy sortBy,
    int page,
    int limit,
    Language language,
    String token,
  }) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    final Map<String, dynamic> queryParams = {
      'type': 'trending',
      '_start': page.start.toString(),
      '_limit': limit?.toString() ?? page.limit.toString(),
      'language': language.value
    };
    var trendingNewsCall =
        httpManager.get(path: NEWS, query: queryParams, headers: headers);

    return trendingNewsCall;
  }

  @override
  Future fetchNewsBySource({
    String sourceId,
    SortBy sortBy,
    int page,
    Language language,
    String token,
  }) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    final Map<String, dynamic> queryParams = {
      'source': sourceId,
      '_start': page.start.toString(),
      '_limit': page.limit.toString(),
      'language': language.value
    };
    var newsCall =
        httpManager.get(path: NEWS, query: queryParams, headers: headers);

    return newsCall;
  }

  @override
  Future fetchNewsByCategory({
    String categoryId,
    String sourceId,
    SortBy sortBy,
    int page,
    Language language,
    String token,
  }) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    final Map<String, dynamic> queryParams = {
      'category': categoryId,
      'source': sourceId,
      '_start': page.start.toString(),
      '_limit': page.limit.toString(),
      'language': language.value
    };
    var newsCall =
        httpManager.get(path: NEWS, query: queryParams, headers: headers);

    return newsCall;
  }

  @override
  Future fetchSources(
      {Language language = Language.NEPALI, String token}) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    final Map<String, dynamic> queryParams = {'language': language.value};
    var sourceCall = httpManager.get(
        path: NEWS_SOURCE, query: queryParams, headers: headers);

    return sourceCall;
  }

  @override
  Future fetchTopics(
      {Language language = Language.NEPALI, String token}) async {
    final Map<String, dynamic> queryParams = {'language': language.value};
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    var topicCall =
        httpManager.get(path: NEWS_TOPIC, query: queryParams, headers: headers);

    return topicCall;
  }

  @override
  Future fetchNewsByTopic(
      {String topicId,
      String sourceId,
      SortBy sortBy,
      int page,
      Language language,
      String token}) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    final Map<String, dynamic> queryParams = {
      'topics.id': topicId,
      'source': sourceId,
      '_start': page.start.toString(),
      '_limit': page.limit.toString(),
      'language': language.value
    };
    var tagNewsCall =
        httpManager.get(path: NEWS, query: queryParams, headers: headers);

    return tagNewsCall;
  }

  @override
  Future fetchCategories(
      {Language language = Language.NEPALI, String token}) async {
    final Map<String, dynamic> queryParams = {'language': language.value};
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    var categoryCall = httpManager.get(
        path: NEWS_CATEGORY, query: queryParams, headers: headers);

    return categoryCall;
  }

  @override
  Future fetchRecentNews(
      {SortBy sortBy, int page, Language language, String token}) {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    final Map<String, dynamic> queryParams = {
      'type': 'recent',
      '_start': page.start.toString(),
      '_limit': page.limit.toString(),
      'language': language?.value
    };
    var latestNewsCall =
        httpManager.get(path: NEWS, query: queryParams, headers: headers);

    return latestNewsCall;
  }

  @override
  Future bookmarkFeed({String feedId, String token}) {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    var path = '$NEWS_BOOKMARK/$feedId';
    var bookmarkCall = httpManager.post(path: path, headers: headers);

    return bookmarkCall;
  }

  @override
  Future unBookmarkFeed({String feedId, String token}) {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    var path = '$NEWS_BOOKMARK/$feedId';
    var bookmarkCall = httpManager.delete(url: path, headers: headers);

    return bookmarkCall;
  }

  @override
  Future followCategory({String categoryId, String token}) {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    var path = '$NEWS_CATEGORY_FOLLOW/$categoryId';
    var call = httpManager.post(path: path, headers: headers);

    return call;
  }

  @override
  Future followSource({String sourceId, String token}) {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    var path = '$NEWS_SOURCE_FOLLOW/$sourceId';
    var call = httpManager.post(path: path, headers: headers);

    return call;
  }

  @override
  Future unFollowCategory({String categoryId, String token}) {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    var path = '$NEWS_CATEGORY_FOLLOW/$categoryId';
    var call = httpManager.delete(url: path, headers: headers);

    return call;
  }

  @override
  Future unFollowSource({String sourceId, String token}) {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    var path = '$NEWS_SOURCE_FOLLOW/$sourceId';
    var call = httpManager.delete(url: path, headers: headers);

    return call;
  }

  @override
  Future followTopic({String topicId, String token}) {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    var path = '$NEWS_TOPIC_FOLLOW/$topicId';
    var call = httpManager.post(path: path, headers: headers);

    return call;
  }

  @override
  Future unFollowTopic({String topicId, String token}) {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    var path = '$NEWS_TOPIC_FOLLOW/$topicId';
    var call = httpManager.delete(url: path, headers: headers);

    return call;
  }

  @override
  Future fetchRelatedNews({String parentId, String token}) {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    final Map<String, dynamic> queryParams = {
      'parent_id': parentId,
    };
    var call =
        httpManager.get(path: NEWS, query: queryParams, headers: headers);

    return call;
  }

  @override
  Future dislikeFeed({String feedId, String token}) {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    var path = '$NEWS_DISLIKE/$feedId';
    var call = httpManager.post(path: path, headers: headers);

    return call;
  }

  @override
  Future likeFeed({String feedId, String token}) {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    var path = '$NEWS_LIKE/$feedId';
    var call = httpManager.post(path: path, headers: headers);

    return call;
  }

  @override
  Future shareFeed({String feedId, String token}) {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    var path = '$NEWS_SHARE/$feedId';
    var call = httpManager.post(path: path, headers: headers);

    return call;
  }

  @override
  Future undislikeFeed({String feedId, String token}) {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    var path = '$NEWS_DISLIKE/$feedId';
    var call = httpManager.delete(url: path, headers: headers);

    return call;
  }

  @override
  Future unlikeFeed({String feedId, String token}) {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    var path = '$NEWS_LIKE/$feedId';
    var call = httpManager.delete(url: path, headers: headers);

    return call;
  }

  @override
  Future viewFeed({String feedId, String token}) {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    var path = '$NEWS_VIEW/$feedId';
    var call = httpManager.post(path: path, headers: headers);

    return call;
  }

  @override
  Future fetchNewsDetail({String feedId, String token}) {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    var path = '$NEWS/$feedId';
    var call = httpManager.get(path: path, headers: headers);

    return call;
  }
}
