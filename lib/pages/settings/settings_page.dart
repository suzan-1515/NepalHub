import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:launch_review/launch_review.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/common/notification_channels.dart';
import 'package:samachar_hub/pages/settings/settings_store.dart';
import 'package:samachar_hub/pages/settings/widgets/news_read_mode.dart';
import 'package:samachar_hub/pages/settings/widgets/section_heading.dart';
import 'package:samachar_hub/services/navigation_service.dart';
import 'package:samachar_hub/services/notification_service.dart';
import 'package:samachar_hub/stores/auth/auth_store.dart';
import 'package:samachar_hub/utils/desclaimer.dart';
import 'package:samachar_hub/utils/forex_currency.dart';
import 'package:samachar_hub/utils/horoscope_signs.dart';
import 'package:samachar_hub/utils/extensions.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Reaction disposers
  List<ReactionDisposer> _disposers;

  @override
  void initState() {
    _setupObserver();
    super.initState();
  }

  @override
  void dispose() {
    // Dispose reactions
    for (final d in _disposers) {
      d();
    }
    super.dispose();
  }

  _setupObserver() {
    _disposers = [
      // Listens for error message
      autorun((_) {
        final String message = context.read<SettingsStore>().message;
        if (message != null) context.showMessage(message);
      }),
    ];
  }

  Widget _buildGeneralSettings(
      BuildContext context, SettingsStore settingsStore) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 8),
          ListTile(
            dense: true,
            onTap: () {
              context.showBottomSheet(
                child: NewsReadMode(
                  store: settingsStore,
                ),
              );
            },
            title: Text(
              'Default news read mode',
              style:
                  Theme.of(context).textTheme.bodyText1.copyWith(height: 1.5),
            ),
            subtitle: Text(
              'Switches between summark view or detail view when opening a particular news.',
              softWrap: true,
              style: Theme.of(context).textTheme.caption,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsSettings(BuildContext context, SettingsStore settingsStore) {
    return Observer(
      builder: (_) => Padding(
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
                Switch(
                  value: settingsStore.showDailyMorningNews,
                  onChanged: (value) {
                    settingsStore.setShowDailyMorningNews(value);
                    if (value) {
                      var user = '';
                      final authStore = context.read<AuthenticationStore>();
                      if (authStore.isLoggedIn && !authStore.user.isAnonymous) {
                        user = '${authStore.user.fullName}';
                      }
                      context.read<NotificationService>().scheduleNotificationDaily(
                          NotificationChannels.kMorningNewsId,
                          'Good Morning $user 🌅',
                          'Your personalised daily news is ready. Click to read. 📰',
                          NotificationChannels.kMorningNewsChannelId,
                          NotificationChannels.kMorningNewsChannelName,
                          NotificationChannels.kMorningNewsChannelDesc,
                          Time(7, 0, 0));
                    } else
                      context
                          .read<NotificationService>()
                          .flutterLocalNotificationsPlugin
                          .cancel(NotificationChannels.kMorningNewsId);
                  },
                  activeColor: Theme.of(context).accentColor,
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
                Switch(
                  value: settingsStore.otherNotifications,
                  onChanged: (value) {
                    settingsStore.setOtherNotifications(value);
                    if (value) {
                      context.read<NotificationService>().subscribe(
                          NotificationChannels.kNewsNotifications, 1);
                    } else
                      context
                          .read<NotificationService>()
                          .unSubscribe(NotificationChannels.kNewsNotifications);
                  },
                  activeColor: Theme.of(context).accentColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForexSettings(
      BuildContext context, SettingsStore settingsStore) {
    return Observer(
      builder: (_) => Padding(
        padding: const EdgeInsets.only(left: 16.0, top: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Default Currency',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            DropdownButton<String>(
              value: settingsStore.defaultForexCurrency,
              onChanged: settingsStore.setdefaultForexCurrency,
              items: forexCurrencies.entries
                  .map(
                    (entry) => DropdownMenuItem<String>(
                      value: entry.key,
                      child: Text(
                        entry.value,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHoroscopeSettings(
      BuildContext context, SettingsStore settingsStore) {
    return Observer(
      builder: (_) => Padding(
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
                DropdownButton<int>(
                    value: settingsStore.defaultHoroscopeSign,
                    onChanged: settingsStore.setdefaultHoroscopeSign,
                    items: horoscopeSigns
                        .map(
                          (e) => DropdownMenuItem<int>(
                            value: horoscopeSigns.indexOf(e),
                            child: Text(
                              e,
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ),
                        )
                        .toList()),
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
                Switch(
                  value: settingsStore.showDailyMorningHoroscope,
                  onChanged: (value) {
                    settingsStore.setShowDailyMorningHoroscope(value);
                    if (value) {
                      var user = '';
                      final authStore = context.read<AuthenticationStore>();
                      if (authStore.isLoggedIn && !authStore.user.isAnonymous) {
                        user = '${authStore.user.fullName}';
                      }
                      context
                          .read<NotificationService>()
                          .scheduleNotificationDaily(
                              NotificationChannels.kMorningHoroscopeId,
                              'Good Morning $user 🌅',
                              'Your daily horoscope is here. Click to read. 📰',
                              NotificationChannels.kMorningHoroscopeChannelId,
                              NotificationChannels.kMorningHoroscopeChannelName,
                              NotificationChannels.kMorningHoroscopeChannelDesc,
                              Time(7, 0, 0));
                    } else
                      context
                          .read<NotificationService>()
                          .flutterLocalNotificationsPlugin
                          .cancel(NotificationChannels.kMorningHoroscopeId);
                  },
                  activeColor: Theme.of(context).accentColor,
                ),
              ],
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildAppThemeSettings(
      SettingsStore settingsStore, BuildContext context) {
    return Observer(
      builder: (_) => Padding(
        padding: const EdgeInsets.only(left: 16, top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AbsorbPointer(
              absorbing: settingsStore.themeSetBySystem,
              child: Opacity(
                opacity: settingsStore.themeSetBySystem ? 0.45 : 1.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Use dark theme',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Switch(
                      value: settingsStore.useDarkMode,
                      onChanged: settingsStore.setDarkMode,
                      activeColor: Theme.of(context).accentColor,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 8),
            IgnorePointer(
              ignoring: !settingsStore.useDarkMode,
              child: Opacity(
                opacity: !settingsStore.useDarkMode ? 0.45 : 1.0,
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
                      value: settingsStore.usePitchBlack,
                      onChanged: settingsStore.setPitchBlack,
                      activeColor: Theme.of(context).accentColor,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 8),
            AbsorbPointer(
              absorbing: settingsStore.useDarkMode,
              child: Opacity(
                opacity: settingsStore.useDarkMode ? 0.45 : 1.0,
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
                      value: settingsStore.themeSetBySystem,
                      onChanged: settingsStore.setSystemTheme,
                      activeColor: Theme.of(context).accentColor,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationSettings(
      BuildContext context, SettingsStore settingsStore) {
    return Observer(
      builder: (_) => Padding(
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
                Switch(
                  value: settingsStore.trendingNotifications,
                  onChanged: (value) {
                    settingsStore.setTrendingNotifications(value);
                    if (value) {
                      context.read<NotificationService>().subscribe(
                          NotificationChannels.kTrendingNotifications, 1);
                    } else
                      context.read<NotificationService>().unSubscribe(
                          NotificationChannels.kTrendingNotifications);
                  },
                  activeColor: Theme.of(context).accentColor,
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
                Switch(
                  value: settingsStore.commentNotifications,
                  onChanged: (value) {
                    settingsStore.setCommentNotifications(value);
                    if (value) {
                      context.read<NotificationService>().subscribe(
                          NotificationChannels.kCommentNotifications, 1);
                    } else
                      context.read<NotificationService>().unSubscribe(
                          NotificationChannels.kCommentNotifications);
                  },
                  activeColor: Theme.of(context).accentColor,
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
                Switch(
                  value: settingsStore.messageNotifications,
                  onChanged: (value) {
                    settingsStore.setMessageNotifications(value);
                    if (value) {
                      context.read<NotificationService>().subscribe(
                          NotificationChannels.kMessageNotifications, 1);
                    } else
                      context.read<NotificationService>().unSubscribe(
                          NotificationChannels.kMessageNotifications);
                  },
                  activeColor: Theme.of(context).accentColor,
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
                Switch(
                  value: settingsStore.otherNotifications,
                  onChanged: (value) {
                    settingsStore.setOtherNotifications(value);
                    if (value) {
                      context.read<NotificationService>().subscribe(
                          NotificationChannels.kOtherNotifications, 1);
                    } else
                      context.read<NotificationService>().unSubscribe(
                          NotificationChannels.kOtherNotifications);
                  },
                  activeColor: Theme.of(context).accentColor,
                ),
              ],
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutSettings(
      BuildContext context, SettingsStore settingsStore) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, top: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 8),
          ListTile(
            dense: true,
            onTap: () => context.read<NavigationService>().toWebViewScreen(
                'Privacy Policy',
                'https://github.com/suzan-1515/Samachar-Hub/blob/master/privacy-policy.html',
                context),
            title: Text(
              'Privacy Policy',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          ListTile(
            dense: true,
            onTap: () {
              LaunchReview.launch(androidAppId: "com.cognota.nepalhub");
            },
            title: Text(
              'Rate us',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          ListTile(
            dense: true,
            onTap: () {
              showAboutDialog(
                  context: context,
                  applicationName: 'Nepal Hub',
                  applicationVersion: '1.0.0',
                  applicationLegalese: kDesclaimer,
                  applicationIcon: Image.asset(
                    'assets/icons/logo.png',
                    width: 32,
                    height: 32,
                  ),
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    Divider(),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Developed by:',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Sujan Parajuli',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    SelectableText(
                      'Email: suzanparajuli@gmail.com',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ]);
            },
            title: Text(
              'About',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<SettingsStore>(
            builder: (_, SettingsStore settingsStore, Widget child) {
              return ListView(
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  SectionHeading(
                    title: 'General',
                    icon: FontAwesomeIcons.sitemap,
                  ),
                  _buildGeneralSettings(context, settingsStore),
                  SizedBox(height: 16),
                  SectionHeading(
                    title: 'News',
                    icon: FontAwesomeIcons.newspaper,
                  ),
                  _buildNewsSettings(context, settingsStore),
                  SizedBox(height: 16),
                  SectionHeading(
                    title: 'Forex',
                    icon: FontAwesomeIcons.chartLine,
                  ),
                  _buildForexSettings(context, settingsStore),
                  SizedBox(height: 16),
                  SectionHeading(
                    title: 'Horoscope',
                    icon: FontAwesomeIcons.starOfDavid,
                  ),
                  _buildHoroscopeSettings(context, settingsStore),
                  SizedBox(height: 16),
                  SectionHeading(
                    title: 'App Theme',
                    icon: FontAwesomeIcons.adjust,
                  ),
                  _buildAppThemeSettings(settingsStore, context),
                  SizedBox(height: 16),
                  SectionHeading(
                    title: 'Notification',
                    icon: FontAwesomeIcons.bell,
                  ),
                  _buildNotificationSettings(context, settingsStore),
                  SizedBox(height: 16),
                  SectionHeading(
                    title: 'About',
                    icon: FontAwesomeIcons.infoCircle,
                  ),
                  _buildAboutSettings(context, settingsStore),
                  SizedBox(height: 16),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
