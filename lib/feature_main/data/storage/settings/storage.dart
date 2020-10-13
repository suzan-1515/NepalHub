mixin Storage {
  Future darkMode(bool value);
  Future pitchBlackMode(bool value);
  Future systemTheme(bool value);
  Future newsReadMode(int value);
  Future dailyMorningNewsNotification(bool value);
  Future dailyMorningHoroscopeNotification(bool value);
  Future trendingNotification(bool value);
  Future commentNotification(bool value);
  Future messageNotification(bool value);
  Future otherNotification(bool value);
  Future newsNotification(bool value);
  Future defaultForexCurrency(String value);
  Future defaultHoroscopeSign(int value);

  bool loadDarkMode();
  bool loadPitchBlackMode();
  bool loadSystemTheme();
  int loadNewsReadMode();
  bool loadDailyMorningNewsNotification();
  bool loadDailyMorningHoroscopeNotification();
  bool loadTrendingNotification();
  bool loadCommentNotification();
  bool loadMessageNotification();
  bool loadOtherNotification();
  bool loadNewsNotification();
  String loadDefaultForexCurrency();
  int loadDefaultHoroscopeSign();
}
