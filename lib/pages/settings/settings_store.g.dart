// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SettingsStore on _SettingsStore, Store {
  final _$useDarkModeAtom = Atom(name: '_SettingsStore.useDarkMode');

  @override
  bool get useDarkMode {
    _$useDarkModeAtom.context.enforceReadPolicy(_$useDarkModeAtom);
    _$useDarkModeAtom.reportObserved();
    return super.useDarkMode;
  }

  @override
  set useDarkMode(bool value) {
    _$useDarkModeAtom.context.conditionallyRunInAction(() {
      super.useDarkMode = value;
      _$useDarkModeAtom.reportChanged();
    }, _$useDarkModeAtom, name: '${_$useDarkModeAtom.name}_set');
  }

  final _$usePitchBlackAtom = Atom(name: '_SettingsStore.usePitchBlack');

  @override
  bool get usePitchBlack {
    _$usePitchBlackAtom.context.enforceReadPolicy(_$usePitchBlackAtom);
    _$usePitchBlackAtom.reportObserved();
    return super.usePitchBlack;
  }

  @override
  set usePitchBlack(bool value) {
    _$usePitchBlackAtom.context.conditionallyRunInAction(() {
      super.usePitchBlack = value;
      _$usePitchBlackAtom.reportChanged();
    }, _$usePitchBlackAtom, name: '${_$usePitchBlackAtom.name}_set');
  }

  final _$themeSetBySystemAtom = Atom(name: '_SettingsStore.themeSetBySystem');

  @override
  bool get themeSetBySystem {
    _$themeSetBySystemAtom.context.enforceReadPolicy(_$themeSetBySystemAtom);
    _$themeSetBySystemAtom.reportObserved();
    return super.themeSetBySystem;
  }

  @override
  set themeSetBySystem(bool value) {
    _$themeSetBySystemAtom.context.conditionallyRunInAction(() {
      super.themeSetBySystem = value;
      _$themeSetBySystemAtom.reportChanged();
    }, _$themeSetBySystemAtom, name: '${_$themeSetBySystemAtom.name}_set');
  }

  final _$openInAppAtom = Atom(name: '_SettingsStore.openInApp');

  @override
  bool get openInApp {
    _$openInAppAtom.context.enforceReadPolicy(_$openInAppAtom);
    _$openInAppAtom.reportObserved();
    return super.openInApp;
  }

  @override
  set openInApp(bool value) {
    _$openInAppAtom.context.conditionallyRunInAction(() {
      super.openInApp = value;
      _$openInAppAtom.reportChanged();
    }, _$openInAppAtom, name: '${_$openInAppAtom.name}_set');
  }

  final _$reloadAppAtom = Atom(name: '_SettingsStore.reloadApp');

  @override
  bool get reloadApp {
    _$reloadAppAtom.context.enforceReadPolicy(_$reloadAppAtom);
    _$reloadAppAtom.reportObserved();
    return super.reloadApp;
  }

  @override
  set reloadApp(bool value) {
    _$reloadAppAtom.context.conditionallyRunInAction(() {
      super.reloadApp = value;
      _$reloadAppAtom.reportChanged();
    }, _$reloadAppAtom, name: '${_$reloadAppAtom.name}_set');
  }

  final _$showDailyMorningNewsAtom =
      Atom(name: '_SettingsStore.showDailyMorningNews');

  @override
  bool get showDailyMorningNews {
    _$showDailyMorningNewsAtom.context
        .enforceReadPolicy(_$showDailyMorningNewsAtom);
    _$showDailyMorningNewsAtom.reportObserved();
    return super.showDailyMorningNews;
  }

  @override
  set showDailyMorningNews(bool value) {
    _$showDailyMorningNewsAtom.context.conditionallyRunInAction(() {
      super.showDailyMorningNews = value;
      _$showDailyMorningNewsAtom.reportChanged();
    }, _$showDailyMorningNewsAtom,
        name: '${_$showDailyMorningNewsAtom.name}_set');
  }

  final _$defaultForexCurrencyAtom =
      Atom(name: '_SettingsStore.defaultForexCurrency');

  @override
  String get defaultForexCurrency {
    _$defaultForexCurrencyAtom.context
        .enforceReadPolicy(_$defaultForexCurrencyAtom);
    _$defaultForexCurrencyAtom.reportObserved();
    return super.defaultForexCurrency;
  }

  @override
  set defaultForexCurrency(String value) {
    _$defaultForexCurrencyAtom.context.conditionallyRunInAction(() {
      super.defaultForexCurrency = value;
      _$defaultForexCurrencyAtom.reportChanged();
    }, _$defaultForexCurrencyAtom,
        name: '${_$defaultForexCurrencyAtom.name}_set');
  }

  final _$defaultHoroscopeSignAtom =
      Atom(name: '_SettingsStore.defaultHoroscopeSign');

  @override
  int get defaultHoroscopeSign {
    _$defaultHoroscopeSignAtom.context
        .enforceReadPolicy(_$defaultHoroscopeSignAtom);
    _$defaultHoroscopeSignAtom.reportObserved();
    return super.defaultHoroscopeSign;
  }

  @override
  set defaultHoroscopeSign(int value) {
    _$defaultHoroscopeSignAtom.context.conditionallyRunInAction(() {
      super.defaultHoroscopeSign = value;
      _$defaultHoroscopeSignAtom.reportChanged();
    }, _$defaultHoroscopeSignAtom,
        name: '${_$defaultHoroscopeSignAtom.name}_set');
  }

  final _$messageAtom = Atom(name: '_SettingsStore.message');

  @override
  String get message {
    _$messageAtom.context.enforceReadPolicy(_$messageAtom);
    _$messageAtom.reportObserved();
    return super.message;
  }

  @override
  set message(String value) {
    _$messageAtom.context.conditionallyRunInAction(() {
      super.message = value;
      _$messageAtom.reportChanged();
    }, _$messageAtom, name: '${_$messageAtom.name}_set');
  }

  final _$_SettingsStoreActionController =
      ActionController(name: '_SettingsStore');

  @override
  dynamic setDarkMode(bool value) {
    final _$actionInfo = _$_SettingsStoreActionController.startAction();
    try {
      return super.setDarkMode(value);
    } finally {
      _$_SettingsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setPitchBlack(bool value) {
    final _$actionInfo = _$_SettingsStoreActionController.startAction();
    try {
      return super.setPitchBlack(value);
    } finally {
      _$_SettingsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSystemTheme(bool value) {
    final _$actionInfo = _$_SettingsStoreActionController.startAction();
    try {
      return super.setSystemTheme(value);
    } finally {
      _$_SettingsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setOpenInApp(bool updatedOpenInAppPreference) {
    final _$actionInfo = _$_SettingsStoreActionController.startAction();
    try {
      return super.setOpenInApp(updatedOpenInAppPreference);
    } finally {
      _$_SettingsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setReloadApp() {
    final _$actionInfo = _$_SettingsStoreActionController.startAction();
    try {
      return super.setReloadApp();
    } finally {
      _$_SettingsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setShowDailyMorningNews(bool value) {
    final _$actionInfo = _$_SettingsStoreActionController.startAction();
    try {
      return super.setShowDailyMorningNews(value);
    } finally {
      _$_SettingsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setdefaultForexCurrency(String value) {
    final _$actionInfo = _$_SettingsStoreActionController.startAction();
    try {
      return super.setdefaultForexCurrency(value);
    } finally {
      _$_SettingsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setdefaultHoroscopeSign(int value) {
    final _$actionInfo = _$_SettingsStoreActionController.startAction();
    try {
      return super.setdefaultHoroscopeSign(value);
    } finally {
      _$_SettingsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'useDarkMode: ${useDarkMode.toString()},usePitchBlack: ${usePitchBlack.toString()},themeSetBySystem: ${themeSetBySystem.toString()},openInApp: ${openInApp.toString()},reloadApp: ${reloadApp.toString()},showDailyMorningNews: ${showDailyMorningNews.toString()},defaultForexCurrency: ${defaultForexCurrency.toString()},defaultHoroscopeSign: ${defaultHoroscopeSign.toString()},message: ${message.toString()}';
    return '{$string}';
  }
}
