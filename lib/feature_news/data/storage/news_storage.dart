import 'package:samachar_hub/feature_news/data/storage/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsStorage implements Storage {
  final SharedPreferences _preferences;

  NewsStorage(
    this._preferences,
  );

  final String _latestNews = 'key_latest_news';
  final String _trendingNews = 'key_trending_news';
  final String _newsByCategory = 'key_category_news_';
  final String _newsBySource = 'key_source_news_';
  final String _newsByTopic = 'key_topic_news_';
  final String _followedCategories = 'key_followed_categories';
  final String _categories = 'key_categories';
  final String _followedSources = 'key_followed_sources';
  final String _sources = 'key_sources';
  final String _topics = 'key_topics';
  final String _followedTopics = 'key_followed_topics';
  final String _bookmarkedNews = 'key_bookmarks';

  @override
  Future<void> saveFollowedCategories(List<String> categories) async {
    if (categories != null && categories.isNotEmpty)
      _preferences.setStringList(_followedCategories, categories);
  }

  @override
  Future<List<String>> loadCategories() async =>
      _preferences.getStringList(_categories);

  @override
  Future<List<String>> loadFollowedCategories() async =>
      _preferences.getStringList(_followedCategories);

  @override
  Future loadFollowedSources() async =>
      _preferences.getStringList(_followedSources);

  @override
  Future loadLatestNews() async => _preferences.getStringList(_latestNews);

  @override
  Future loadNewsByCategory(String category) async =>
      _preferences.getStringList(_newsByCategory + category);

  @override
  Future loadNewsBySource(String source) async =>
      _preferences.getStringList(_newsBySource + source);

  @override
  Future loadNewsByTopic(String topic) async =>
      _preferences.getStringList(_newsByTopic + topic);

  @override
  Future loadSources() async => _preferences.getStringList(_sources);

  @override
  Future loadTopics() async => _preferences.getStringList(_topics);

  @override
  Future loadTrendingNews() async => _preferences.getStringList(_trendingNews);

  @override
  Future<void> saveCategories(List<String> categories) async {
    if (categories != null && categories.isNotEmpty)
      _preferences.setStringList(_categories, categories);
  }

  @override
  Future<void> saveFollowedSources(List<String> sources) async {
    if (sources != null && sources.isNotEmpty)
      _preferences.setStringList(_followedCategories, sources);
  }

  @override
  Future<void> saveLatestNews(List<String> feeds) async {
    if (feeds != null && feeds.isNotEmpty)
      _preferences.setStringList(_latestNews, feeds);
  }

  @override
  Future<void> saveNewsByCategory(String category, List<String> feeds) async {
    if (feeds != null && feeds.isNotEmpty)
      _preferences.setStringList(_newsByCategory + category, feeds);
  }

  @override
  Future<void> saveNewsBySource(String source, List<String> feeds) async {
    if (feeds != null && feeds.isNotEmpty)
      _preferences.setStringList(_newsBySource + source, feeds);
  }

  @override
  Future<void> saveNewsByTopic(String topic, List<String> feeds) async {
    if (feeds != null && feeds.isNotEmpty)
      _preferences.setStringList(_newsByTopic + topic, feeds);
  }

  @override
  Future<void> saveSources(List<String> sources) async {
    if (sources != null && sources.isNotEmpty)
      _preferences.setStringList(_sources, sources);
  }

  @override
  Future<void> saveTopics(List<String> topics) async {
    if (topics != null && topics.isNotEmpty)
      _preferences.setStringList(_topics, topics);
  }

  @override
  Future<void> saveTrendingNews(List<String> feeds) async {
    if (feeds != null && feeds.isNotEmpty)
      _preferences.setStringList(_trendingNews, feeds);
  }

  @override
  Future<void> followCategory(String feed) async {
    if (feed != null && feed.isNotEmpty) {
      final categories = _preferences.getStringList(_followedCategories);
      if (categories != null) {
        categories.add(feed);
        return _preferences.setStringList(_followedCategories, categories);
      }
    }
  }

  @override
  Future<void> followSource(String feed) async {
    if (feed != null && feed.isNotEmpty) {
      final categories = _preferences.getStringList(_followedSources);
      if (categories != null) {
        categories.add(feed);
        return _preferences.setStringList(_followedSources, categories);
      }
    }
  }

  @override
  Future<void> bookmarkFeed(String feed) async {
    if (feed != null && feed.isNotEmpty) {
      final bookmarks = _preferences.getStringList(_bookmarkedNews);
      if (bookmarks != null) {
        bookmarks.add(feed);
        return _preferences.setStringList(_bookmarkedNews, bookmarks);
      }
    }
  }

  @override
  Future<void> followTopic(String topic) async {
    if (topic != null && topic.isNotEmpty) {
      final topics = _preferences.getStringList(_followedTopics);
      if (topics != null) {
        topics.add(topic);
        return _preferences.setStringList(_followedTopics, topics);
      }
    }
  }

  @override
  Future<void> setBookmarkFeeds(List<String> feeds) async {
    if (feeds != null && feeds.isNotEmpty) {
      return _preferences.setStringList(_bookmarkedNews, feeds);
    }
  }

  @override
  Future<void> setFollowedCategories(List<String> categories) async {
    if (categories != null && categories.isNotEmpty) {
      return _preferences.setStringList(_followedCategories, categories);
    }
  }

  @override
  Future<void> setFollowedSources(List<String> sources) async {
    if (sources != null && sources.isNotEmpty) {
      return _preferences.setStringList(_followedSources, sources);
    }
  }

  @override
  Future<void> setFollowedTopics(List<String> topics) async {
    if (topics != null && topics.isNotEmpty) {
      return _preferences.setStringList(_followedTopics, topics);
    }
  }

  @override
  Future loadBookmarkedFeeds({int page}) async =>
      _preferences.getStringList(_bookmarkedNews);

  @override
  Future loadFollowedTopics() async =>
      _preferences.getStringList(_followedTopics);

  @override
  Future loadNewsFeedDetail(String feedId) {
    throw UnimplementedError();
  }
}
