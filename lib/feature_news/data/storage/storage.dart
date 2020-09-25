abstract class Storage {
  Future<dynamic> loadLatestNews();

  Future<void> saveLatestNews(List<String> feeds);

  Future<dynamic> loadTrendingNews();

  Future<void> saveTrendingNews(List<String> feeds);

  Future<dynamic> loadNewsFeedDetail(String feedId);

  Future<dynamic> loadNewsBySource(String source);

  Future<void> saveNewsBySource(String source, List<String> feeds);

  Future<dynamic> loadNewsByCategory(String category);

  Future<void> saveNewsByCategory(String category, List<String> feeds);

  Future<void> bookmarkFeed(String feed);

  Future<void> setBookmarkFeeds(List<String> feeds);

  Future<dynamic> loadBookmarkedFeeds({int page});

  Future<void> followSource(String source);

  Future<void> setFollowedSources(List<String> source);

  Future<void> followCategory(String category);

  Future<void> setFollowedCategories(List<String> category);

  Future<dynamic> loadSources();

  Future<void> saveSources(List<String> sources);

  Future<dynamic> loadCategories();

  Future<void> saveCategories(List<String> categories);

  Future<dynamic> loadFollowedSources();

  Future<void> saveFollowedSources(List<String> sources);

  Future<dynamic> loadFollowedCategories();

  Future<void> saveFollowedCategories(List<String> categories);

  Future<dynamic> loadTopics();

  Future<void> saveTopics(List<String> topics);

  Future<void> followTopic(String topic);

  Future<void> setFollowedTopics(List<String> topics);

  Future<dynamic> loadFollowedTopics();

  Future<dynamic> loadNewsByTopic(String topic);

  Future<void> saveNewsByTopic(String topic, List<String> feeds);
}
