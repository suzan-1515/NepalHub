import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/extensions/view.dart';
import 'package:samachar_hub/core/widgets/progress_widget.dart';
import 'package:samachar_hub/feature_main/domain/usecases/settings/get_settings_use_case.dart';
import 'package:samachar_hub/feature_main/domain/usecases/settings/set_comment_notification_status_use_case.dart';
import 'package:samachar_hub/feature_main/domain/usecases/settings/usecases.dart';
import 'package:samachar_hub/feature_main/presentation/blocs/settings/settings_cubit.dart';
import 'package:samachar_hub/feature_main/presentation/ui/settings/widgets/settings_list.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  GetSettingsUseCase _getSettingsUseCase;
  SetCommentNotificationStatusUseCase _setCommentNotificationStatusUseCase;
  SetDarkModeUseCase _setDarkModeUseCase;
  SetDefaultForexCurrencyUseCase _setDefaultForexCurrencyUseCase;
  SetDefaultHoroscopeSignUseCase _setDefaultHoroscopeSignUseCase;
  SetMorningHoroscopeNotificationStatusUseCase
      _setMorningHoroscopeNotificationStatusUseCase;
  SetMorningNewsNotificationStatusUseCase
      _setMorningNewsNotificationStatusUseCase;
  SetNewsNotificationStatusUseCase _setNewsNotificationStatusUseCase;
  SetNewsReadModeUseCase _setNewsReadModeUseCase;
  SetOtherNotificationStatusUseCase _setOtherNotificationStatusUseCase;
  SetPitchBlackModeUseCase _setPitchBlackModeUseCase;
  SetSystemThemeUseCase _setSystemThemeUseCase;
  SetTrendingNotificationStatusUseCase _setTrendingNotificationStatusUseCase;
  SetMessageNotificationStatusUseCase _setMessageNotificationStatusUseCase;

  @override
  void initState() {
    super.initState();
    this._getSettingsUseCase = context.repository<GetSettingsUseCase>();
    this._setCommentNotificationStatusUseCase =
        context.repository<SetCommentNotificationStatusUseCase>();
    this._setDarkModeUseCase = context.repository<SetDarkModeUseCase>();
    this._setDefaultForexCurrencyUseCase =
        context.repository<SetDefaultForexCurrencyUseCase>();
    this._setDefaultHoroscopeSignUseCase =
        context.repository<SetDefaultHoroscopeSignUseCase>();
    this._setMorningHoroscopeNotificationStatusUseCase =
        context.repository<SetMorningHoroscopeNotificationStatusUseCase>();
    this._setMorningNewsNotificationStatusUseCase =
        context.repository<SetMorningNewsNotificationStatusUseCase>();
    this._setNewsNotificationStatusUseCase =
        context.repository<SetNewsNotificationStatusUseCase>();
    this._setNewsReadModeUseCase = context.repository<SetNewsReadModeUseCase>();
    this._setOtherNotificationStatusUseCase =
        context.repository<SetOtherNotificationStatusUseCase>();
    this._setPitchBlackModeUseCase =
        context.repository<SetPitchBlackModeUseCase>();
    this._setSystemThemeUseCase = context.repository<SetSystemThemeUseCase>();
    this._setTrendingNotificationStatusUseCase =
        context.repository<SetTrendingNotificationStatusUseCase>();
    this._setMessageNotificationStatusUseCase =
        context.repository<SetMessageNotificationStatusUseCase>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingsCubit>(
      create: (context) => SettingsCubit(
        getSettingsUseCase: _getSettingsUseCase,
        setCommentNotificationStatusUseCase:
            _setCommentNotificationStatusUseCase,
        setDarkModeUseCase: _setDarkModeUseCase,
        setDefaultForexCurrencyUseCase: _setDefaultForexCurrencyUseCase,
        setDefaultHoroscopeSignUseCase: _setDefaultHoroscopeSignUseCase,
        setMessageNotificationStatusUseCase:
            _setMessageNotificationStatusUseCase,
        setMorningHoroscopeNotificationStatusUseCase:
            _setMorningHoroscopeNotificationStatusUseCase,
        setMorningNewsNotificationStatusUseCase:
            _setMorningNewsNotificationStatusUseCase,
        setNewsNotificationStatusUseCase: _setNewsNotificationStatusUseCase,
        setNewsReadModeUseCase: _setNewsReadModeUseCase,
        setOtherNotificationStatusUseCase: _setOtherNotificationStatusUseCase,
        setPitchBlackModeUseCase: _setPitchBlackModeUseCase,
        setSystemThemeUseCase: _setSystemThemeUseCase,
        setTrendingNotificationStatusUseCase:
            _setTrendingNotificationStatusUseCase,
      )..getSettings(),
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocConsumer<SettingsCubit, SettingsState>(
              listener: (context, state) {
                if (state is SettingsErrorState) {
                  context.showMessage(state.message);
                }
              },
              buildWhen: (previous, current) =>
                  (current is SettingsInitialState) ||
                  (current is SettingsLoadSuccess),
              builder: (context, state) {
                if (state is SettingsLoadSuccess) {
                  return SettingsList(settings: state.settingsEntity);
                }
                return Center(
                  child: ProgressView(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
