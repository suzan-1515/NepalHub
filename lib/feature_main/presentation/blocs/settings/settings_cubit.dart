import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_main/domain/entities/settings_entity.dart';
import 'package:samachar_hub/feature_main/domain/usecases/settings/get_settings_use_case.dart';
import 'package:samachar_hub/feature_main/domain/usecases/settings/usecases.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SetDarkModeUseCase setDarkModeUseCase;
  final SetCommentNotificationStatusUseCase setCommentNotificationStatusUseCase;
  final SetDefaultForexCurrencyUseCase setDefaultForexCurrencyUseCase;
  final SetDefaultHoroscopeSignUseCase setDefaultHoroscopeSignUseCase;
  final SetMessageNotificationStatusUseCase setMessageNotificationStatusUseCase;

  final SetMorningHoroscopeNotificationStatusUseCase
      setMorningHoroscopeNotificationStatusUseCase;

  final SetMorningNewsNotificationStatusUseCase
      setMorningNewsNotificationStatusUseCase;
  final SetNewsNotificationStatusUseCase setNewsNotificationStatusUseCase;
  final SetNewsReadModeUseCase setNewsReadModeUseCase;
  final SetOtherNotificationStatusUseCase setOtherNotificationStatusUseCase;
  final SetPitchBlackModeUseCase setPitchBlackModeUseCase;
  final SetSystemThemeUseCase setSystemThemeUseCase;

  final SetTrendingNotificationStatusUseCase
      setTrendingNotificationStatusUseCase;
  final GetSettingsUseCase getSettingsUseCase;
  SettingsCubit({
    @required this.setCommentNotificationStatusUseCase,
    @required this.setDefaultForexCurrencyUseCase,
    @required this.setDefaultHoroscopeSignUseCase,
    @required this.setMessageNotificationStatusUseCase,
    @required this.setMorningHoroscopeNotificationStatusUseCase,
    @required this.setMorningNewsNotificationStatusUseCase,
    @required this.setNewsNotificationStatusUseCase,
    @required this.setNewsReadModeUseCase,
    @required this.setOtherNotificationStatusUseCase,
    @required this.setPitchBlackModeUseCase,
    @required this.setSystemThemeUseCase,
    @required this.setTrendingNotificationStatusUseCase,
    @required this.setDarkModeUseCase,
    @required this.getSettingsUseCase,
  }) : super(SettingsInitialState());

  SettingsEntity _settingsEntity;
  SettingsEntity get settings => _settingsEntity;

  getSettings() async {
    try {
      final settingEntity = await getSettingsUseCase.call(NoParams());
      this._settingsEntity = settingEntity;
      emit(SettingsLoadSuccess(settingEntity));
    } catch (e) {
      log('Settings load error: ', error: e);
      emit(SettingsErrorState(message: 'Unable to load settings.'));
    }
  }

  setDarkMode(bool value) async {
    try {
      await setDarkModeUseCase.call(SetDarkModeUseCaseParams(value: value));
      this._settingsEntity = this._settingsEntity.copyWith(useDarkMode: value);
      emit(SettingsDarkModeChangedState(value: value));
    } catch (e) {
      log('Dark mode set error: ', error: e);
      emit(SettingsErrorState(message: 'Unable to change dark mode.'));
    }
  }

  setPitchBlackMode(bool value) async {
    try {
      await setPitchBlackModeUseCase
          .call(SetPitchBlackModeUseCaseParams(value: value));
      this._settingsEntity =
          this._settingsEntity.copyWith(usePitchBlack: value);
      emit(SettingsPitchBlackModeChangedState(value: value));
    } catch (e) {
      log('Pitch black mode set error: ', error: e);
      emit(SettingsErrorState(message: 'Unable to change pitch black mode.'));
    }
  }

  setUseSystemThemeMode(bool value) async {
    try {
      await setSystemThemeUseCase
          .call(SetSystemThemeUseCaseParams(value: value));
      this._settingsEntity =
          this._settingsEntity.copyWith(themeSetBySystem: value);
      emit(SettingsSystemThemeChangedState(value: value));
    } catch (e) {
      log('Use system theme mode set error: ', error: e);
      emit(SettingsErrorState(message: 'Unable to change system theme mode.'));
    }
  }

  setNewsReadMode(int value) async {
    try {
      await setNewsReadModeUseCase
          .call(SetNewsReadModeUseCaseParams(value: value));
      this._settingsEntity = this._settingsEntity.copyWith(newsReadMode: value);
      emit(SettingsNewsReadModeChangedState(value: value));
    } catch (e) {
      log('News read mode set error: ', error: e);
      emit(SettingsErrorState(message: 'Unable to change news read mode.'));
    }
  }

  setShowDailyMorningNews(bool value) async {
    try {
      await setMorningNewsNotificationStatusUseCase
          .call(SetMorningNewsNotificationUseCaseParams(value: value));
      this._settingsEntity =
          this._settingsEntity.copyWith(showDailyMorningNews: value);
      emit(SettingsDailyMorningNewsNotificationChangedState(value: value));
    } catch (e) {
      log('Morning news notification set error: ', error: e);
      emit(
          SettingsErrorState(message: 'Unable to change notification status.'));
    }
  }

  setShowDailyMorningHoroscope(bool value) async {
    try {
      await setMorningHoroscopeNotificationStatusUseCase
          .call(SetMorningHoroscopeNotificationUseCaseParams(value: value));
      this._settingsEntity =
          this._settingsEntity.copyWith(showDailyMorningHoroscope: value);
      emit(SettingsDailyMorningHoroscopeNotificationChangedState(value: value));
    } catch (e) {
      log('Morning horoscope notification set error: ', error: e);
      emit(
          SettingsErrorState(message: 'Unable to change notification status.'));
    }
  }

  setTrendingNotifications(bool value) async {
    try {
      await setTrendingNotificationStatusUseCase
          .call(SetTrendingNotificationUseCaseParams(value: value));
      this._settingsEntity =
          this._settingsEntity.copyWith(trendingNotifications: value);
      emit(SettingsTrendingNotificationChangedState(value: value));
    } catch (e) {
      log('Trending notification set error: ', error: e);
      emit(
          SettingsErrorState(message: 'Unable to change notification status.'));
    }
  }

  setCommentNotifications(bool value) async {
    try {
      await setCommentNotificationStatusUseCase
          .call(SetCommentNotificationUseCaseParams(value: value));
      this._settingsEntity =
          this._settingsEntity.copyWith(commentNotifications: value);
      emit(SettingsCommentNotificationChangedState(value: value));
    } catch (e) {
      log('Comment notification set error: ', error: e);
      emit(
          SettingsErrorState(message: 'Unable to change notification status.'));
    }
  }

  setMessageNotifications(bool value) async {
    try {
      await setMessageNotificationStatusUseCase
          .call(SetMessageNotificationUseCaseParams(value: value));
      this._settingsEntity =
          this._settingsEntity.copyWith(messageNotifications: value);
      emit(SettingsMessageNotificationChangedState(value: value));
    } catch (e) {
      log('Message notification set error: ', error: e);
      emit(
          SettingsErrorState(message: 'Unable to change notification status.'));
    }
  }

  setOtherNotifications(bool value) async {
    try {
      await setOtherNotificationStatusUseCase
          .call(SetOtherNotificationUseCaseParams(value: value));
      this._settingsEntity =
          this._settingsEntity.copyWith(otherNotifications: value);
      emit(SettingsOtherNotificationChangedState(value: value));
    } catch (e) {
      log('Other notification set error: ', error: e);
      emit(
          SettingsErrorState(message: 'Unable to change notification status.'));
    }
  }

  setNewsNotifications(bool value) async {
    try {
      await setNewsNotificationStatusUseCase
          .call(SetNewsNotificationUseCaseParams(value: value));
      this._settingsEntity =
          this._settingsEntity.copyWith(newsNotifications: value);
      emit(SettingsNewsNotificationChangedState(value: value));
    } catch (e) {
      log('News notification set error: ', error: e);
      emit(
          SettingsErrorState(message: 'Unable to change notification status.'));
    }
  }

  setdefaultForexCurrency(String value) async {
    try {
      await setDefaultForexCurrencyUseCase
          .call(SetDefaultForexCurrencyUseCaseParams(value: value));
      this._settingsEntity =
          this._settingsEntity.copyWith(defaultForexCurrency: value);
      emit(SettingsDefaultForexCurrencyChangedState(value: value));
    } catch (e) {
      log('Default forex currency set error: ', error: e);
      emit(SettingsErrorState(message: 'Unable to set forex currency.'));
    }
  }

  setdefaultHoroscopeSign(int value) async {
    try {
      await setDefaultHoroscopeSignUseCase
          .call(SetDefaultHoroscopeSignUseCaseParams(value: value));
      this._settingsEntity =
          this._settingsEntity.copyWith(defaultHoroscopeSign: value);
      emit(SettingsDefaultHoroscopeSignChangedState(value: value));
    } catch (e) {
      log('Default horoscope sign set error: ', error: e);
      emit(SettingsErrorState(message: 'Unable to set horoscope sign.'));
    }
  }
}
