import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/constants/notification_channels.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_main/presentation/blocs/settings/settings_cubit.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NewsSettings extends StatelessWidget {
  const NewsSettings({
    Key key,
    @required this.context,
  }) : super(key: key);

  final BuildContext context;

  Widget _buildMorningNotificationSwitch(bool initialValue) {
    return Switch(
      value: initialValue,
      onChanged: (value) {
        context.read<SettingsCubit>().setShowDailyMorningNews(value);
        if (value) {
          GetIt.I.get<NotificationService>().scheduleNotificationDaily(
                NotificationChannels.kMorningNewsId,
                'Good Morning  🌅',
                'Your personalised daily news is ready. Click to read. 📰',
                NotificationChannels.kMorningNewsChannelId,
                NotificationChannels.kMorningNewsChannelName,
                NotificationChannels.kMorningNewsChannelDesc,
                tz.TZDateTime.from(DateTime(3000, 1, 1, 13, 15), tz.UTC),
              );
          GetIt.I
              .get<AnalyticsService>()
              .logNewsDailyMorningNotificatoon(notify: true);
        } else {
          GetIt.I
              .get<NotificationService>()
              .flutterLocalNotificationsPlugin
              .cancel(NotificationChannels.kMorningNewsId);
          GetIt.I
              .get<AnalyticsService>()
              .logNewsDailyMorningNotificatoon(notify: false);
        }
      },
      activeColor: Theme.of(context).accentColor,
    );
  }

  Widget _buildNewsNotificationSwitch(bool initialValue) {
    return Switch(
      value: initialValue,
      onChanged: (value) {
        context.read<SettingsCubit>().setNewsNotifications(value);
        if (value) {
          GetIt.I
              .get<NotificationService>()
              .subscribe(NotificationChannels.kNewsNotifications, 1);
          GetIt.I.get<AnalyticsService>().logNewsNotificatoon(notify: true);
        } else
          GetIt.I
              .get<NotificationService>()
              .unSubscribe(NotificationChannels.kNewsNotifications);
        GetIt.I.get<AnalyticsService>().logNewsNotificatoon(notify: false);
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
                'Notify for daily news at 7 am',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              BlocBuilder<SettingsCubit, SettingsState>(
                buildWhen: (previous, current) =>
                    current
                        is SettingsDailyMorningNewsNotificationChangedState ||
                    current is SettingsInitialState ||
                    current is SettingsLoadSuccess,
                builder: (context, state) {
                  if (state
                      is SettingsDailyMorningNewsNotificationChangedState) {
                    return _buildMorningNotificationSwitch(state.value);
                  }
                  return _buildMorningNotificationSwitch(
                      settingsCubit.settings.showDailyMorningNews ?? true);
                },
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: RichText(
                  text: TextSpan(
                    text: 'News notifications',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(height: 1.5),
                    children: [
                      TextSpan(
                          text:
                              '\nReceive personalised, breaking, trending etc news notification.',
                          style: Theme.of(context).textTheme.caption),
                    ],
                  ),
                ),
              ),
              BlocBuilder<SettingsCubit, SettingsState>(
                buildWhen: (previous, current) =>
                    current is SettingsNewsNotificationChangedState ||
                    current is SettingsInitialState ||
                    current is SettingsLoadSuccess,
                builder: (context, state) {
                  if (state is SettingsNewsNotificationChangedState) {
                    return _buildNewsNotificationSwitch(state.value);
                  }
                  return _buildNewsNotificationSwitch(
                      settingsCubit.settings.newsNotifications ?? true);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
