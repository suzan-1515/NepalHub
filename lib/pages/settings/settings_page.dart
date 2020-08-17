import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/common/notification_channels.dart';
import 'package:samachar_hub/pages/settings/settings_store.dart';
import 'package:samachar_hub/pages/settings/widgets/section_heading.dart';
import 'package:samachar_hub/services/notification_service.dart';
import 'package:samachar_hub/stores/auth/auth_store.dart';
import 'package:samachar_hub/utils/forex_currency.dart';
import 'package:samachar_hub/utils/horoscope_signs.dart';
import 'package:samachar_hub/utils/extensions.dart';

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
      padding: const EdgeInsets.only(left: 4, top: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 8),
          ListTile(
            dense: true,
            onTap: () {
              context.read<SettingsStore>().message = 'Comming soon!';
            },
            title: Text(
              'Default news read mode',
              style: Theme.of(context).textTheme.bodyText1,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Show daily news at 7 am',
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
                    user = '${authStore.user.fullName} 🌅';
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
                      child: Text(entry.value),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Default Horoscope',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            DropdownButton<int>(
                value: settingsStore.defaultHoroscopeSign,
                onChanged: settingsStore.setdefaultHoroscopeSign,
                items: horoscopeSigns
                    .map(
                      (e) => DropdownMenuItem<int>(
                        value: horoscopeSigns.indexOf(e),
                        child: Text(e),
                      ),
                    )
                    .toList()),
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
            IgnorePointer(
              ignoring: !settingsStore.useDarkMode,
              child: Opacity(
                opacity: !settingsStore.useDarkMode ? 0.45 : 1.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
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
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: AbsorbPointer(
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
            )
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
            onTap: () {
              context.read<SettingsStore>().message = 'Comming soon!';
            },
            title: Text(
              'Privacy Policy',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          ListTile(
            dense: true,
            onTap: () {
              context.read<SettingsStore>().message = 'Comming soon!';
            },
            title: Text(
              'Rate us',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          ListTile(
            dense: true,
            onTap: () {
              context.read<SettingsStore>().message = 'Comming soon!';
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
