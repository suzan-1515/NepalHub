import 'package:samachar_hub/feature_main/data/datasources/local/settings/local_data_source.dart';
import 'package:samachar_hub/feature_main/data/storage/settings/storage.dart';

class SettingsLocalDataSource with LocalDataSource {
  final Storage storage;

  SettingsLocalDataSource(this.storage);

  @override
  Future commentNotification(bool value) {
    return storage.commentNotification(value);
  }

  @override
  Future dailyMorningHoroscopeNotification(bool value) {
    return storage.dailyMorningHoroscopeNotification(value);
  }

  @override
  Future dailyMorningNewsNotification(bool value) {
    return storage.dailyMorningNewsNotification(value);
  }

  @override
  Future darkMode(bool value) {
    return storage.darkMode(value);
  }

  @override
  Future defaultForexCurrency(String value) {
    return storage.defaultForexCurrency(value);
  }

  @override
  Future defaultHoroscopeSign(int value) {
    return storage.defaultHoroscopeSign(value);
  }

  @override
  bool loadCommentNotification() {
    return storage.loadCommentNotification();
  }

  @override
  bool loadDailyMorningHoroscopeNotification() {
    return storage.loadDailyMorningHoroscopeNotification();
  }

  @override
  bool loadDailyMorningNewsNotification() {
    return storage.loadDailyMorningNewsNotification();
  }

  @override
  bool loadDarkMode() {
    return storage.loadDarkMode();
  }

  @override
  String loadDefaultForexCurrency() {
    return storage.loadDefaultForexCurrency();
  }

  @override
  int loadDefaultHoroscopeSign() {
    return storage.loadDefaultHoroscopeSign();
  }

  @override
  bool loadMessageNotification() {
    return storage.loadMessageNotification();
  }

  @override
  bool loadNewsNotification() {
    return storage.loadNewsNotification();
  }

  @override
  int loadNewsReadMode() {
    return storage.loadNewsReadMode();
  }

  @override
  bool loadOtherNotification() {
    return storage.loadOtherNotification();
  }

  @override
  bool loadPitchBlackMode() {
    return storage.loadPitchBlackMode();
  }

  @override
  bool loadSystemTheme() {
    return storage.loadSystemTheme();
  }

  @override
  bool loadTrendingNotification() {
    return storage.loadTrendingNotification();
  }

  @override
  Future messageNotification(bool value) {
    return storage.messageNotification(value);
  }

  @override
  Future newsNotification(bool value) {
    return storage.newsNotification(value);
  }

  @override
  Future newsReadMode(int value) {
    return storage.newsReadMode(value);
  }

  @override
  Future otherNotification(bool value) {
    return storage.otherNotification(value);
  }

  @override
  Future pitchBlackMode(bool value) {
    return storage.pitchBlackMode(value);
  }

  @override
  Future systemTheme(bool value) {
    return storage.systemTheme(value);
  }

  @override
  Future trendingNotification(bool value) {
    return storage.trendingNotification(value);
  }
}
