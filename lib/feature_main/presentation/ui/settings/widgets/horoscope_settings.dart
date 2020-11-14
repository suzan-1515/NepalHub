import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/constants/notification_channels.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_horoscope/domain/entities/horoscope_entity.dart';
import 'package:samachar_hub/feature_main/presentation/blocs/settings/settings_cubit.dart';

class HoroscopeSettings extends StatelessWidget {
  const HoroscopeSettings({
    Key key,
    @required this.context,
  }) : super(key: key);

  final BuildContext context;

  Widget _buildSignsDropDown(int selectedIndex) {
    return DropdownButton<int>(
      value: selectedIndex,
      onChanged: (value) {
        context.watch<SettingsCubit>().setdefaultHoroscopeSign(value);
      },
      items: HOROSCOPE_SIGNS[Language.NEPALI]
          .map(
            (e) => DropdownMenuItem<int>(
              value: HOROSCOPE_SIGNS[Language.NEPALI].indexOf(e),
              child: Text(
                e,
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildNotificationSwitch(bool initialValue) {
    return Switch(
      value: initialValue,
      onChanged: (value) {
        context.watch<SettingsCubit>().setShowDailyMorningHoroscope(value);
        if (value) {
          GetIt.I.get<NotificationService>().scheduleNotificationDaily(
              NotificationChannels.kMorningHoroscopeId,
              'Good Morning 🌅',
              'Your daily horoscope is here. Click to read. 📰',
              NotificationChannels.kMorningHoroscopeChannelId,
              NotificationChannels.kMorningHoroscopeChannelName,
              NotificationChannels.kMorningHoroscopeChannelDesc,
              DateTime(2020, 1, 1, 7));
          GetIt.I
              .get<AnalyticsService>()
              .logHoroscopeDailyMorningNotificatoon(notify: true);
        } else {
          GetIt.I
              .get<NotificationService>()
              .flutterLocalNotificationsPlugin
              .cancel(NotificationChannels.kMorningHoroscopeId);
          GetIt.I
              .get<AnalyticsService>()
              .logHoroscopeDailyMorningNotificatoon(notify: false);
        }
      },
      activeColor: Theme.of(context).accentColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    final settingsCubit = context.watch<SettingsCubit>();
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Your Horoscope',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              BlocBuilder<SettingsCubit, SettingsState>(
                  buildWhen: (previous, current) =>
                      current is SettingsInitialState ||
                      current is SettingsLoadSuccess ||
                      current is SettingsDefaultHoroscopeSignChangedState,
                  builder: (context, state) {
                    if (state is SettingsDefaultHoroscopeSignChangedState) {
                      return _buildSignsDropDown(state.value);
                    }
                    return _buildSignsDropDown(
                        settingsCubit.settings.defaultHoroscopeSign ?? 0);
                  }),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Notify daily horoscope at 7 am',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              BlocBuilder<SettingsCubit, SettingsState>(
                buildWhen: (previous, current) =>
                    (current is SettingsInitialState) ||
                    (current is SettingsLoadSuccess) ||
                    (current
                        is SettingsDailyMorningHoroscopeNotificationChangedState),
                builder: (context, state) {
                  if (state
                      is SettingsDailyMorningHoroscopeNotificationChangedState) {
                    return _buildNotificationSwitch(state.value);
                  }
                  return _buildNotificationSwitch(
                      settingsCubit.settings.showDailyMorningHoroscope ?? true);
                },
              ),
            ],
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
