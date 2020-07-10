import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {
  final String _useDarkModeKey = 'useDarkMode';
  final String _pitchBlackKey = 'pitchBlack';
  final String _themeSetBySystemKey = 'themeSetBySystem';
  final String _openInAppKey = 'openInApp';
  final String _bookmarkedFeedsKey = 'bookmarked_feeds';
  final String _likedFeedsKey = 'liked_feeds';
  final String _userId = 'userId';
  final String _defaultForexCurrencyKey = 'default_forex_currency';
  final String _defaultZodiacKey = 'default_zodiac';
  final String _unFollowedNewsSourcesKey = 'unfollowed_news_sources';
  final String _unFollowedNewsCategoriesKey = 'unfollowed_news_categories';
  final String _followedNewsTopicsKey = 'followed_news_topics';
  final String _firstTimeOpenKey = 'first_open';

  final SharedPreferences _sharedPreferences;

  const PreferenceService(this._sharedPreferences);

  set isFirstOpen(bool value) {
    _sharedPreferences.setBool(_firstTimeOpenKey, value);
  }

  set useDarkMode(bool value) {
    _sharedPreferences.setBool(_useDarkModeKey, value);
  }

  set usePitchBlack(bool value) {
    _sharedPreferences.setBool(_pitchBlackKey, value);
  }

  set themeSetBySystem(bool value) {
    _sharedPreferences.setBool(_themeSetBySystemKey, value);
  }

  set openInApp(bool openInApp) {
    _sharedPreferences.setBool(_openInAppKey, openInApp);
  }

  set bookmarkedFeeds(List<String> favourites) {
    _sharedPreferences.setStringList(_bookmarkedFeedsKey, favourites);
  }

  set likedFeeds(List<String> likes) {
    _sharedPreferences.setStringList(_likedFeedsKey, likes);
  }

  set userId(String userId) {
    _sharedPreferences.setString(_userId, userId);
  }

  set defaultForexCurrency(String currencyCode) {
    _sharedPreferences.setString(_defaultForexCurrencyKey, currencyCode);
  }

  set defaultZodiac(int zodiac) {
    _sharedPreferences.setInt(_defaultZodiacKey, zodiac);
  }

  set unFollowedNewsSources(List<String> sources) {
    _sharedPreferences.setStringList(_unFollowedNewsSourcesKey, sources);
  }

  set unFollowedNewsCategories(List<String> categories) {
    _sharedPreferences.setStringList(_unFollowedNewsCategoriesKey, categories);
  }

  set followedNewsTopics(List<String> topics) {
    _sharedPreferences.setStringList(_followedNewsTopicsKey, topics);
  }

  bool get themeSetBySystem =>
      _sharedPreferences.getBool(_themeSetBySystemKey) ?? false;

  bool get isFirstOpen => _sharedPreferences.getBool(_firstTimeOpenKey) ?? true;

  bool get useDarkMode => _sharedPreferences.getBool(_useDarkModeKey) ?? false;

  bool get usePitchBlack => _sharedPreferences.getBool(_pitchBlackKey) ?? false;

  bool get openInApp => _sharedPreferences.getBool(_openInAppKey) ?? true;

  List<String> get bookmarkedFeeds =>
      _sharedPreferences.getStringList(_bookmarkedFeedsKey) ?? List<String>();
  List<String> get likedFeeds =>
      _sharedPreferences.getStringList(_bookmarkedFeedsKey) ?? List<String>();

  String get userId => _sharedPreferences.getString(_userId) ?? null;

  String get defaultForexCurrency =>
      _sharedPreferences.getString(_defaultForexCurrencyKey) ?? 'USD';

  int get defaultZodiac => _sharedPreferences.getInt(_defaultZodiacKey) ?? 0;

  List<String> get unFollowedNewsSources =>
      _sharedPreferences.getStringList(_unFollowedNewsSourcesKey) ??
      List<String>();

  List<String> get unFollowedNewsCategories =>
      _sharedPreferences.getStringList(_unFollowedNewsCategoriesKey) ??
      List<String>();

  List<String> get followedNewsTopics =>
      _sharedPreferences.getStringList(_followedNewsTopicsKey) ??
      List<String>();
}
