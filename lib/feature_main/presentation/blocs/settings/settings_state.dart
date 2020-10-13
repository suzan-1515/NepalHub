part of 'settings_cubit.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class SettingsInitialState extends SettingsState {}

class SettingsLoadSuccess extends SettingsState {
  final SettingsEntity settingsEntity;

  SettingsLoadSuccess(this.settingsEntity);
  @override
  List<Object> get props => [settingsEntity];
}

class SettingsDarkModeChangedState extends SettingsState {
  final bool value;

  SettingsDarkModeChangedState({@required this.value});

  @override
  List<Object> get props => [value];
}

class SettingsPitchBlackModeChangedState extends SettingsState {
  final bool value;

  SettingsPitchBlackModeChangedState({@required this.value});

  @override
  List<Object> get props => [value];
}

class SettingsSystemThemeChangedState extends SettingsState {
  final bool value;

  SettingsSystemThemeChangedState({@required this.value});

  @override
  List<Object> get props => [value];
}

class SettingsNewsReadModeChangedState extends SettingsState {
  final int value;

  SettingsNewsReadModeChangedState({@required this.value});

  @override
  List<Object> get props => [value];
}

class SettingsDailyMorningNewsNotificationChangedState extends SettingsState {
  final bool value;

  SettingsDailyMorningNewsNotificationChangedState({@required this.value});

  @override
  List<Object> get props => [value];
}

class SettingsDailyMorningHoroscopeNotificationChangedState
    extends SettingsState {
  final bool value;

  SettingsDailyMorningHoroscopeNotificationChangedState({@required this.value});

  @override
  List<Object> get props => [value];
}

class SettingsTrendingNotificationChangedState extends SettingsState {
  final bool value;

  SettingsTrendingNotificationChangedState({@required this.value});

  @override
  List<Object> get props => [value];
}

class SettingsCommentNotificationChangedState extends SettingsState {
  final bool value;

  SettingsCommentNotificationChangedState({@required this.value});

  @override
  List<Object> get props => [value];
}

class SettingsMessageNotificationChangedState extends SettingsState {
  final bool value;

  SettingsMessageNotificationChangedState({@required this.value});

  @override
  List<Object> get props => [value];
}

class SettingsOtherNotificationChangedState extends SettingsState {
  final bool value;

  SettingsOtherNotificationChangedState({@required this.value});

  @override
  List<Object> get props => [value];
}

class SettingsNewsNotificationChangedState extends SettingsState {
  final bool value;

  SettingsNewsNotificationChangedState({@required this.value});

  @override
  List<Object> get props => [value];
}

class SettingsDefaultForexCurrencyChangedState extends SettingsState {
  final String value;

  SettingsDefaultForexCurrencyChangedState({@required this.value});

  @override
  List<Object> get props => [value];
}

class SettingsDefaultHoroscopeSignChangedState extends SettingsState {
  final int value;

  SettingsDefaultHoroscopeSignChangedState({@required this.value});

  @override
  List<Object> get props => [value];
}

class SettingsErrorState extends SettingsState {
  final String message;

  SettingsErrorState({@required this.message});

  @override
  List<Object> get props => [message];
}
