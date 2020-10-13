import 'package:samachar_hub/feature_main/domain/entities/settings_entity.dart';

mixin Repository {
  Future setDarkMode(bool value);
  Future setPitchBlackMode(bool value);
  Future setSystemTheme(bool value);
  Future setNewsReadMode(int value);
  Future enableDailyMorningNewsNotification(bool value);
  Future enableDailyMorningHoroscopeNotification(bool value);
  Future enableTrendingNotification(bool value);
  Future enableCommentNotification(bool value);
  Future enableMessageNotification(bool value);
  Future enableOtherNotification(bool value);
  Future enableNewsNotification(bool value);
  Future setDefaultForexCurrency(String value);
  Future setDefaultHoroscopeSign(int value);

  Future<SettingsEntity> getSettings();
}
