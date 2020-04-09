import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {
  final String _useDarkModeKey = 'useDarkMode';
  final String _pitchBlackKey = 'pitchBlack';
  final String _themeSetBySystemKey = 'themeSetBySystem';
  final String _openInAppKey = 'openInApp';
  final String _favouritesKey = 'favourites';

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

  set favourites(List<String> favourites) {
    _sharedPreferences.setStringList(_favouritesKey, favourites);
  }

  bool get themeSetBySystem =>
      _sharedPreferences.getBool(_themeSetBySystemKey) ?? false;

  bool get useDarkMode => _sharedPreferences.getBool(_useDarkModeKey) ?? false;

  bool get usePitchBlack => _sharedPreferences.getBool(_pitchBlackKey) ?? false;

  bool get openInApp => _sharedPreferences.getBool(_openInAppKey) ?? true;

  List<String> get favourites =>
      _sharedPreferences.getStringList(_favouritesKey) ?? List<String>();
}
