import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/constants/notification_channels.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_main/domain/entities/settings_entity.dart';
import 'package:samachar_hub/feature_main/presentation/blocs/settings/settings_cubit.dart';

class NotificationSettings extends StatelessWidget {
  const NotificationSettings({
    Key key,
    @required this.context,
    @required this.settingsEntity,
  }) : super(key: key);

  final BuildContext context;
  final SettingsEntity settingsEntity;

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
              Flexible(
                child: RichText(
                  text: TextSpan(
                    text: 'Trending notifications',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(height: 1.5),
                    children: [
                      TextSpan(
                          text: '\nReceive all trending notifications',
                          style: Theme.of(context).textTheme.caption),
                    ],
                  ),
                ),
              ),
              BlocBuilder<SettingsCubit, SettingsState>(
                buildWhen: (previous, current) =>
                    current is SettingsTrendingNotificationChangedState ||
                    current is SettingsInitialState,
                builder: (context, state) {
                  if (state is SettingsTrendingNotificationChangedState) {
                    return TrendingNotificationSwitch(
                        context: context, initialValue: state.value);
                  }
                  return TrendingNotificationSwitch(
                      context: context,
                      initialValue:
                          settingsEntity.trendingNotifications ?? true);
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
                    text: 'Comments',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(height: 1.5),
                    children: [
                      TextSpan(
                          text:
                              '\nGet notified when someone replied to your comments.',
                          style: Theme.of(context).textTheme.caption),
                    ],
                  ),
                ),
              ),
              BlocBuilder<SettingsCubit, SettingsState>(
                buildWhen: (previous, current) =>
                    current is SettingsCommentNotificationChangedState ||
                    current is SettingsInitialState,
                builder: (context, state) {
                  if (state is SettingsCommentNotificationChangedState) {
                    return CommentNotificationSwitch(
                        context: context, initialValue: state.value);
                  }
                  return CommentNotificationSwitch(
                      context: context,
                      initialValue:
                          settingsEntity.commentNotifications ?? true);
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
                    text: 'Messages',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(height: 1.5),
                    children: [
                      TextSpan(
                          text:
                              '\nGet notified when someone sent you a message.',
                          style: Theme.of(context).textTheme.caption),
                    ],
                  ),
                ),
              ),
              BlocBuilder<SettingsCubit, SettingsState>(
                buildWhen: (previous, current) =>
                    current is SettingsMessageNotificationChangedState ||
                    current is SettingsInitialState,
                builder: (context, state) {
                  if (state is SettingsMessageNotificationChangedState) {
                    return MessageNotificationSwitch(
                        context: context, initialValue: state.value);
                  }
                  return MessageNotificationSwitch(
                      context: context,
                      initialValue:
                          settingsEntity.messageNotifications ?? true);
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
                    text: 'Other notifications',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(height: 1.5),
                    children: [
                      TextSpan(
                          text:
                              '\nGet notified for weather,corona, app updates, etc...',
                          style: Theme.of(context).textTheme.caption),
                    ],
                  ),
                ),
              ),
              BlocBuilder<SettingsCubit, SettingsState>(
                buildWhen: (previous, current) =>
                    current is SettingsOtherNotificationChangedState ||
                    current is SettingsInitialState,
                builder: (context, state) {
                  if (state is SettingsOtherNotificationChangedState) {
                    return OtherNotificationSwitch(
                        context: context, initialValue: state.value);
                  }
                  return OtherNotificationSwitch(
                      context: context,
                      initialValue: settingsEntity.otherNotifications ?? true);
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

class OtherNotificationSwitch extends StatelessWidget {
  const OtherNotificationSwitch({
    Key key,
    @required this.context,
    @required this.initialValue,
  }) : super(key: key);

  final BuildContext context;
  final bool initialValue;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: initialValue,
      onChanged: (value) {
        context.bloc<SettingsCubit>().setOtherNotifications(value);
        if (value) {
          context
              .repository<NotificationService>()
              .subscribe(NotificationChannels.kOtherNotifications, 1);
          context
              .repository<AnalyticsService>()
              .logOtherNotificatoon(notify: true);
        } else
          context
              .repository<NotificationService>()
              .unSubscribe(NotificationChannels.kOtherNotifications);
        context
            .repository<AnalyticsService>()
            .logOtherNotificatoon(notify: false);
      },
      activeColor: Theme.of(context).accentColor,
    );
  }
}

class MessageNotificationSwitch extends StatelessWidget {
  const MessageNotificationSwitch({
    Key key,
    @required this.context,
    @required this.initialValue,
  }) : super(key: key);

  final BuildContext context;
  final bool initialValue;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: initialValue,
      onChanged: (value) {
        context.bloc<SettingsCubit>().setMessageNotifications(value);
        if (value) {
          context
              .repository<NotificationService>()
              .subscribe(NotificationChannels.kMessageNotifications, 1);
          context
              .repository<AnalyticsService>()
              .logMessageNotification(notify: true);
        } else
          context
              .repository<NotificationService>()
              .unSubscribe(NotificationChannels.kMessageNotifications);
        context
            .repository<AnalyticsService>()
            .logMessageNotification(notify: false);
      },
      activeColor: Theme.of(context).accentColor,
    );
  }
}

class CommentNotificationSwitch extends StatelessWidget {
  const CommentNotificationSwitch({
    Key key,
    @required this.context,
    @required this.initialValue,
  }) : super(key: key);

  final BuildContext context;
  final bool initialValue;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: initialValue,
      onChanged: (value) {
        context.bloc<SettingsCubit>().setCommentNotifications(value);
        if (value) {
          context
              .repository<NotificationService>()
              .subscribe(NotificationChannels.kCommentNotifications, 1);
          context
              .repository<AnalyticsService>()
              .logCommentNotification(notify: true);
        } else
          context
              .repository<NotificationService>()
              .unSubscribe(NotificationChannels.kCommentNotifications);
        context
            .repository<AnalyticsService>()
            .logCommentNotification(notify: false);
      },
      activeColor: Theme.of(context).accentColor,
    );
  }
}

class TrendingNotificationSwitch extends StatelessWidget {
  const TrendingNotificationSwitch({
    Key key,
    @required this.context,
    @required this.initialValue,
  }) : super(key: key);

  final BuildContext context;
  final bool initialValue;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: initialValue,
      onChanged: (value) {
        context.bloc<SettingsCubit>().setTrendingNotifications(value);
        if (value) {
          context
              .repository<NotificationService>()
              .subscribe(NotificationChannels.kTrendingNotifications, 1);
          context
              .repository<AnalyticsService>()
              .logTrendingNotificatoon(notify: true);
        } else
          context
              .repository<NotificationService>()
              .unSubscribe(NotificationChannels.kTrendingNotifications);
        context
            .repository<AnalyticsService>()
            .logTrendingNotificatoon(notify: false);
      },
      activeColor: Theme.of(context).accentColor,
    );
  }
}
