import 'package:mobx/mobx.dart';
import 'package:samachar_hub/services/services.dart';

part 'settings_store.g.dart';

class SettingsStore = _SettingsStore with _$SettingsStore;

abstract class _SettingsStore with Store {
  PreferenceService _preferenceService;

  @observable
  bool useDarkMode;

  @observable
  bool usePitchBlack;

  @observable
  bool themeSetBySystem;

  @observable
  bool openInApp;

  @observable
  int newsReadMode;

  @observable
  bool reloadApp;

  @observable
  bool showDailyMorningNews;

  @observable
  bool showDailyMorningHoroscope;

  @observable
  bool trendingNotifications;

  @observable
  bool commentNotifications;

  @observable
  bool messageNotifications;

  @observable
  bool otherNotifications;

  @observable
  bool newsNotifications;

  @observable
  String defaultForexCurrency;

  @observable
  int defaultHoroscopeSign;

  @observable
  String message;

  _SettingsStore(this._preferenceService) {
    useDarkMode = _preferenceService.useDarkMode;
    usePitchBlack = _preferenceService.usePitchBlack;
    themeSetBySystem = _preferenceService.themeSetBySystem;
    openInApp = _preferenceService.openInApp;
    newsReadMode = _preferenceService.newsReadMode;
    showDailyMorningNews = _preferenceService.showDailyMorningNews;
    showDailyMorningHoroscope = _preferenceService.showDailyMorningHoroscope;
    defaultForexCurrency = _preferenceService.defaultForexCurrency;
    defaultHoroscopeSign = _preferenceService.defaultZodiac;
    trendingNotifications = _preferenceService.trendingNotifications;
    commentNotifications = _preferenceService.commentNotifications;
    messageNotifications = _preferenceService.messageNotifications;
    otherNotifications = _preferenceService.otherNotifications;
    newsNotifications = _preferenceService.newsNotifications;
  }

  @action
  setDarkMode(bool value) {
    _preferenceService.useDarkMode = value;
    useDarkMode = value;
  }

  @action
  setPitchBlack(bool value) {
    _preferenceService.usePitchBlack = value;
    usePitchBlack = value;
  }

  @action
  setSystemTheme(bool value) {
    _preferenceService.themeSetBySystem = value;
    themeSetBySystem = value;
  }

  @action
  void setOpenInApp(bool updatedOpenInAppPreference) {
    _preferenceService.openInApp = updatedOpenInAppPreference;
    openInApp = updatedOpenInAppPreference;
  }

  @action
  setNewsReadMode(int value) {
    _preferenceService.newsReadMode = value;
    newsReadMode = value;
  }

  @action
  setReloadApp() {
    reloadApp = true;
  }

  @action
  setShowDailyMorningNews(bool value) {
    _preferenceService.showDailyMorningNews = value;
    showDailyMorningNews = value;
  }

  @action
  setShowDailyMorningHoroscope(bool value) {
    _preferenceService.showDailyMorningHoroscope = value;
    showDailyMorningHoroscope = value;
  }

  @action
  setTrendingNotifications(bool value) {
    _preferenceService.trendingNotifications = value;
    trendingNotifications = value;
  }

  @action
  setCommentNotifications(bool value) {
    _preferenceService.commentNotifications = value;
    commentNotifications = value;
  }

  @action
  setMessageNotifications(bool value) {
    _preferenceService.messageNotifications = value;
    messageNotifications = value;
  }

  @action
  setOtherNotifications(bool value) {
    _preferenceService.otherNotifications = value;
    otherNotifications = value;
  }

  @action
  setNewsNotifications(bool value) {
    _preferenceService.newsNotifications = value;
    newsNotifications = value;
  }

  @action
  setdefaultForexCurrency(String value) {
    _preferenceService.defaultForexCurrency = value;
    defaultForexCurrency = value;
  }

  @action
  setdefaultHoroscopeSign(int value) {
    _preferenceService.defaultZodiac = value;
    defaultHoroscopeSign = value;
  }
}
