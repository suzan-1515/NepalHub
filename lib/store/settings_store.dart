import 'package:mobx/mobx.dart';
import 'package:samachar_hub/service/preference_service.dart';

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

  // Todo: Probably use a common store
  @observable
  String message;

  _SettingsStore(this._preferenceService) {
    useDarkMode = _preferenceService.useDarkMode;
    usePitchBlack = _preferenceService.usePitchBlack;
    themeSetBySystem = _preferenceService.themeSetBySystem;
    openInApp = _preferenceService.openInApp;
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
}
