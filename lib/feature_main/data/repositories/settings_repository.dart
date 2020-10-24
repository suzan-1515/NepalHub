import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_main/data/datasources/local/settings/local_data_source.dart';
import 'package:samachar_hub/feature_main/domain/entities/settings_entity.dart';
import 'package:samachar_hub/feature_main/domain/repositories/settings/repository.dart';

class SettingsRepository with Repository {
  final LocalDataSource _localDataSource;
  final AnalyticsService _analyticsService;

  SettingsRepository(this._localDataSource, this._analyticsService);

  @override
  Future enableCommentNotification(bool value) {
    return _localDataSource.commentNotification(value).then(
          (_) => _analyticsService.logCommentNotification(notify: value),
        );
  }

  @override
  Future enableDailyMorningHoroscopeNotification(bool value) {
    return _localDataSource.dailyMorningHoroscopeNotification(value).then(
          (_) => _analyticsService.logHoroscopeDailyMorningNotificatoon(
              notify: value),
        );
  }

  @override
  Future enableDailyMorningNewsNotification(bool value) {
    return _localDataSource.dailyMorningNewsNotification(value).then(
          (_) =>
              _analyticsService.logNewsDailyMorningNotificatoon(notify: value),
        );
  }

  @override
  Future enableMessageNotification(bool value) {
    return _localDataSource.messageNotification(value).then(
          (_) => _analyticsService.logMessageNotification(notify: value),
        );
  }

  @override
  Future enableNewsNotification(bool value) {
    return _localDataSource.newsNotification(value).then(
          (_) => _analyticsService.logNewsNotificatoon(notify: value),
        );
  }

  @override
  Future enableOtherNotification(bool value) {
    return _localDataSource.otherNotification(value).then(
          (_) => _analyticsService.logOtherNotificatoon(notify: value),
        );
  }

  @override
  Future enableTrendingNotification(bool value) {
    return _localDataSource.trendingNotification(value).then(
          (_) => _analyticsService.logTrendingNotificatoon(notify: value),
        );
  }

  @override
  Future<SettingsEntity> getSettings() async {
    SettingsEntity settings = SettingsEntity(
      commentNotifications: _localDataSource.loadCommentNotification(),
      defaultForexCurrency: _localDataSource.loadDefaultForexCurrency(),
      defaultHoroscopeSign: _localDataSource.loadDefaultHoroscopeSign(),
      messageNotifications: _localDataSource.loadMessageNotification(),
      newsNotifications: _localDataSource.loadNewsNotification(),
      newsReadMode: _localDataSource.loadNewsReadMode(),
      otherNotifications: _localDataSource.loadOtherNotification(),
      showDailyMorningHoroscope:
          _localDataSource.loadDailyMorningHoroscopeNotification(),
      showDailyMorningNews: _localDataSource.loadDailyMorningNewsNotification(),
      themeSetBySystem: _localDataSource.loadSystemTheme() ?? false,
      trendingNotifications: _localDataSource.loadTrendingNotification(),
      useDarkMode: _localDataSource.loadDarkMode() ?? false,
      usePitchBlack: _localDataSource.loadPitchBlackMode() ?? false,
    );

    return settings;
  }

  @override
  Future setDarkMode(bool value) {
    return _localDataSource.darkMode(value).then(
          (_) => _analyticsService.logDarkMode(enable: value),
        );
  }

  @override
  Future setDefaultForexCurrency(String value) {
    return _localDataSource.defaultForexCurrency(value).then(
          (_) => _analyticsService.logDefaultForexCurrency(currencyId: value),
        );
  }

  @override
  Future setDefaultHoroscopeSign(int value) {
    return _localDataSource.defaultHoroscopeSign(value).then(
          (_) => _analyticsService.logDefaultHoroscopeSign(signIndex: value),
        );
  }

  @override
  Future setNewsReadMode(int value) {
    return _localDataSource.newsReadMode(value).then(
          (_) => _analyticsService.logNewsReadMode(mode: value),
        );
  }

  @override
  Future setPitchBlackMode(bool value) {
    return _localDataSource
        .pitchBlackMode(value)
        .then((_) => _analyticsService.logPitchBlackMode(value: value));
  }

  @override
  Future setSystemTheme(bool value) {
    return _localDataSource
        .systemTheme(value)
        .then((_) => _analyticsService.logUseSystemTheme(value: value));
  }
}
