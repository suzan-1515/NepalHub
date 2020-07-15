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
  bool reloadApp;

  @observable
  bool showDailyMorningNews;

  @observable
  String defaultForexCurrency;

  @observable
  int defaultHoroscopeSign;

  // Todo: Probably use a common store
  @observable
  String message;

  _SettingsStore(this._preferenceService) {
    useDarkMode = _preferenceService.useDarkMode;
    usePitchBlack = _preferenceService.usePitchBlack;
    themeSetBySystem = _preferenceService.themeSetBySystem;
    openInApp = _preferenceService.openInApp;
    showDailyMorningNews = _preferenceService.showDailyMorningNews;
    defaultForexCurrency = _preferenceService.defaultForexCurrency;
    defaultHoroscopeSign = _preferenceService.defaultZodiac;
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
  setReloadApp() {
    reloadApp = true;
  }

  @action
  setShowDailyMorningNews(bool value) {
    _preferenceService.showDailyMorningNews = value;
    showDailyMorningNews = value;
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
