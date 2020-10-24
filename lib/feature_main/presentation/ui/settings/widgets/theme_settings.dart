import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/feature_main/domain/entities/settings_entity.dart';
import 'package:samachar_hub/feature_main/presentation/blocs/settings/settings_cubit.dart';

class ThemeSettings extends StatelessWidget {
  const ThemeSettings({
    Key key,
    @required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    final settingsCubit = context.bloc<SettingsCubit>();
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 16),
      child: BlocBuilder<SettingsCubit, SettingsState>(
        buildWhen: (previous, current) =>
            current is SettingsSystemThemeChangedState ||
            current is SettingsDarkModeChangedState ||
            current is SettingsPitchBlackModeChangedState ||
            current is SettingsInitialState ||
            current is SettingsLoadSuccess,
        builder: (context, state) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DarkThemeSetting(
              settingsEntity: settingsCubit.settings,
            ),
            SizedBox(height: 8),
            PitchBlackThemeSetting(settingsEntity: settingsCubit.settings),
            SizedBox(height: 8),
            SystemThemeSetting(settingsEntity: settingsCubit.settings),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class SystemThemeSetting extends StatelessWidget {
  const SystemThemeSetting({
    Key key,
    @required this.settingsEntity,
  }) : super(key: key);

  final SettingsEntity settingsEntity;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: settingsEntity.useDarkMode ?? false,
      child: Opacity(
        opacity: settingsEntity.useDarkMode ?? false ? 0.45 : 1.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      'Theme set by system',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  Text(
                    'Requires minimum OS version ${Platform.isAndroid ? 'Android 10' : 'IOS 13'}',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ),
            Checkbox(
              value: settingsEntity.themeSetBySystem ?? false,
              onChanged: (value) {
                context.bloc<SettingsCubit>().setUseSystemThemeMode(value);
              },
              activeColor: Theme.of(context).accentColor,
            )
          ],
        ),
      ),
    );
  }
}

class PitchBlackThemeSetting extends StatelessWidget {
  const PitchBlackThemeSetting({
    Key key,
    @required this.settingsEntity,
  }) : super(key: key);

  final SettingsEntity settingsEntity;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: ((!settingsEntity.useDarkMode) ?? false),
      child: Opacity(
        opacity: (!settingsEntity.useDarkMode ?? false) ? 0.45 : 1.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      'Use pitch black theme',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  Text(
                    'Only applies when dark mode is on',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ),
            Checkbox(
              value: settingsEntity.usePitchBlack ?? false,
              onChanged: (value) {
                context.bloc<SettingsCubit>().setPitchBlackMode(value);
              },
              activeColor: Theme.of(context).accentColor,
            )
          ],
        ),
      ),
    );
  }
}

class DarkThemeSetting extends StatelessWidget {
  const DarkThemeSetting({
    Key key,
    @required this.settingsEntity,
  }) : super(key: key);

  final SettingsEntity settingsEntity;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: (settingsEntity.themeSetBySystem ?? false),
      child: Opacity(
        opacity: (settingsEntity.themeSetBySystem ?? false) ? 0.45 : 1.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Use dark theme',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Switch(
              value: settingsEntity.useDarkMode ?? false,
              onChanged: (value) {
                context.bloc<SettingsCubit>().setDarkMode(value);
              },
              activeColor: Theme.of(context).accentColor,
            )
          ],
        ),
      ),
    );
  }
}
