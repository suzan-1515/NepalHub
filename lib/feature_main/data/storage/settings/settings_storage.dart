import 'package:flutter/material.dart';
import 'package:samachar_hub/feature_main/data/storage/settings/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsStorage with Storage {
  final SharedPreferences _sharedPreferences;
  final String _useDarkModeKey = 'useDarkMode';
  final String _pitchBlackKey = 'pitchBlack';
  final String _themeSetBySystemKey = 'themeSetBySystem';
  final String _newsReadModeKey = 'newsReadMode';
  final String _showDailyMorningNewsKey = 'showDailyMorningNews';
  final String _showDailyMorningHoroscopeKey = 'showDailyMorningHoroscope';
  final String _newsNotificationsKey = 'newsNotificationsKey';
  final String _trendingNotificationsKey = 'trendingNotifications';
  final String _commentNotificationsKey = 'commentNotifications';
  final String _messageNotificationsKey = 'messageNotifications';
  final String _otherNotificationsKey = 'otherNotifications';
  final String _defaultForexCurrencyKey = 'default_forex_currency';
  final String _defaultZodiacKey = 'default_zodiac';

  SettingsStorage({@required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences;

  @override
  Future commentNotification(bool value) {
    assert(value != null);
    return _sharedPreferences.setBool(_commentNotificationsKey, value);
  }

  @override
  Future dailyMorningHoroscopeNotification(bool value) {
    assert(value != null);
    return _sharedPreferences.setBool(_showDailyMorningHoroscopeKey, value);
  }

  @override
  Future dailyMorningNewsNotification(bool value) {
    assert(value != null);
    return _sharedPreferences.setBool(_showDailyMorningNewsKey, value);
  }

  @override
  Future darkMode(bool value) {
    assert(value != null);
    return _sharedPreferences.setBool(_useDarkModeKey, value);
  }

  @override
  Future defaultForexCurrency(String value) {
    assert(value != null);
    return _sharedPreferences.setString(_defaultForexCurrencyKey, value);
  }

  @override
  Future defaultHoroscopeSign(int value) {
    assert(value != null);
    return _sharedPreferences.setInt(_defaultZodiacKey, value);
  }

  @override
  Future messageNotification(bool value) {
    assert(value != null);
    return _sharedPreferences.setBool(_messageNotificationsKey, value);
  }

  @override
  Future newsNotification(bool value) {
    assert(value != null);
    return _sharedPreferences.setBool(_newsNotificationsKey, value);
  }

  @override
  Future newsReadMode(int value) {
    assert(value != null);
    return _sharedPreferences.setInt(_newsReadModeKey, value);
  }

  @override
  Future otherNotification(bool value) {
    assert(value != null);
    return _sharedPreferences.setBool(_otherNotificationsKey, value);
  }

  @override
  Future pitchBlackMode(bool value) {
    assert(value != null);
    return _sharedPreferences.setBool(_pitchBlackKey, value);
  }

  @override
  Future systemTheme(bool value) {
    assert(value != null);
    return _sharedPreferences.setBool(_themeSetBySystemKey, value);
  }

  @override
  Future trendingNotification(bool value) {
    assert(value != null);
    return _sharedPreferences.setBool(_trendingNotificationsKey, value);
  }

  @override
  bool loadCommentNotification() {
    return _sharedPreferences.getBool(_commentNotificationsKey);
  }

  @override
  bool loadDailyMorningHoroscopeNotification() {
    return _sharedPreferences.getBool(_commentNotificationsKey);
  }

  @override
  bool loadDailyMorningNewsNotification() {
    return _sharedPreferences.getBool(_showDailyMorningNewsKey);
  }

  @override
  bool loadDarkMode() {
    return _sharedPreferences.getBool(_useDarkModeKey);
  }

  @override
  String loadDefaultForexCurrency() {
    return _sharedPreferences.getString(_defaultForexCurrencyKey);
  }

  @override
  int loadDefaultHoroscopeSign() {
    return _sharedPreferences.getInt(_defaultZodiacKey);
  }

  @override
  bool loadMessageNotification() {
    return _sharedPreferences.getBool(_messageNotificationsKey);
  }

  @override
  bool loadNewsNotification() {
    return _sharedPreferences.getBool(_newsNotificationsKey);
  }

  @override
  int loadNewsReadMode() {
    return _sharedPreferences.getInt(_newsReadModeKey);
  }

  @override
  bool loadOtherNotification() {
    return _sharedPreferences.getBool(_otherNotificationsKey);
  }

  @override
  bool loadPitchBlackMode() {
    return _sharedPreferences.getBool(_pitchBlackKey);
  }

  @override
  bool loadSystemTheme() {
    return _sharedPreferences.getBool(_themeSetBySystemKey);
  }

  @override
  bool loadTrendingNotification() {
    return _sharedPreferences.getBool(_trendingNotificationsKey);
  }
}
