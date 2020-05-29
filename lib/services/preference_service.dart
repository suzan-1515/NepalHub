import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {
  final String _useDarkModeKey = 'useDarkMode';
  final String _pitchBlackKey = 'pitchBlack';
  final String _themeSetBySystemKey = 'themeSetBySystem';
  final String _openInAppKey = 'openInApp';
  final String _bookmarkedFeedsKey = 'bookmarked_feeds';
  final String _likedFeedsKey = 'liked_feeds';
  final String _userId = 'userId';

  final SharedPreferences _sharedPreferences;

  const PreferenceService(this._sharedPreferences);

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

  bool get themeSetBySystem =>
      _sharedPreferences.getBool(_themeSetBySystemKey) ?? false;

  bool get useDarkMode => _sharedPreferences.getBool(_useDarkModeKey) ?? false;

  bool get usePitchBlack => _sharedPreferences.getBool(_pitchBlackKey) ?? false;

  bool get openInApp => _sharedPreferences.getBool(_openInAppKey) ?? true;

  List<String> get bookmarkedFeeds =>
      _sharedPreferences.getStringList(_bookmarkedFeedsKey) ?? List<String>();
  List<String> get likedFeeds =>
      _sharedPreferences.getStringList(_bookmarkedFeedsKey) ?? List<String>();

  String get userId => _sharedPreferences.getString(_userId) ?? null;
}
