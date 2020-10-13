import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:samachar_hub/core/constants/notification_channels.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_main/domain/entities/settings_entity.dart';
import 'package:samachar_hub/feature_main/presentation/blocs/settings/settings_cubit.dart';

class NewsSettings extends StatelessWidget {
  const NewsSettings({
    Key key,
    @required this.context,
    @required this.settingsEntity,
  }) : super(key: key);

  final BuildContext context;
  final SettingsEntity settingsEntity;

  Widget _buildMorningNotificationSwitch(bool initialValue) {
    return Switch(
      value: initialValue,
      onChanged: (value) {
        context.bloc<SettingsCubit>().setShowDailyMorningNews(value);
        if (value) {
          context.repository<NotificationService>().scheduleNotificationDaily(
              NotificationChannels.kMorningNewsId,
              'Good Morning  🌅',
              'Your personalised daily news is ready. Click to read. 📰',
              NotificationChannels.kMorningNewsChannelId,
              NotificationChannels.kMorningNewsChannelName,
              NotificationChannels.kMorningNewsChannelDesc,
              Time(7, 0, 0));
          context
              .repository<AnalyticsService>()
              .logNewsDailyMorningNotificatoon(notify: true);
        } else {
          context
              .repository<NotificationService>()
              .flutterLocalNotificationsPlugin
              .cancel(NotificationChannels.kMorningNewsId);
          context
              .repository<AnalyticsService>()
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
        context.bloc<SettingsCubit>().setNewsNotifications(value);
        if (value) {
          context
              .repository<NotificationService>()
              .subscribe(NotificationChannels.kNewsNotifications, 1);
          context
              .repository<AnalyticsService>()
              .logNewsNotificatoon(notify: true);
        } else
          context
              .repository<NotificationService>()
              .unSubscribe(NotificationChannels.kNewsNotifications);
        context
            .repository<AnalyticsService>()
            .logNewsNotificatoon(notify: false);
      },
      activeColor: Theme.of(context).accentColor,
    );
  }

  @override
  Widget build(BuildContext context) {
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
                    current is SettingsInitialState,
                builder: (context, state) {
                  if (state
                      is SettingsDailyMorningNewsNotificationChangedState) {
                    return _buildMorningNotificationSwitch(state.value);
                  }
                  return _buildMorningNotificationSwitch(
                      settingsEntity.showDailyMorningNews ?? true);
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
                    current is SettingsInitialState,
                builder: (context, state) {
                  if (state is SettingsNewsNotificationChangedState) {
                    return _buildNewsNotificationSwitch(state.value);
                  }
                  return _buildNewsNotificationSwitch(
                      settingsEntity.newsNotifications ?? true);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
