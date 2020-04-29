import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:samachar_hub/manager/authentication_manager.dart';
import 'package:samachar_hub/manager/bookmark_manager.dart';
import 'package:samachar_hub/manager/feed_manager.dart';
import 'package:samachar_hub/manager/like_manager.dart';
import 'package:samachar_hub/service/analytics_service.dart';
import 'package:samachar_hub/service/authentication_service.dart';
import 'package:samachar_hub/service/bookmark_activity_service.dart';
import 'package:samachar_hub/service/bookmark_service.dart';
import 'package:samachar_hub/service/cloud_storage_service.dart';
import 'package:samachar_hub/service/everything_service.dart';
import 'package:samachar_hub/service/feed_service.dart';
import 'package:samachar_hub/service/like_activity_service.dart';
import 'package:samachar_hub/service/personalised_service.dart';
import 'package:samachar_hub/service/preference_service.dart';
import 'package:samachar_hub/store/bookmark_store.dart';
import 'package:samachar_hub/store/everything_store.dart';
import 'package:samachar_hub/store/home_screen_store.dart';
import 'package:samachar_hub/store/personalised_store.dart';
import 'package:samachar_hub/store/settings_store.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'routes/routes.dart';
import 'common/themes.dart' as Themes;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  final SharedPreferences sp = await SharedPreferences.getInstance();
  runApp(App(sp));
}

class App extends StatelessWidget {
  App(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  ThemeData _getTheme(SettingsStore settingStore) {
    return settingStore.useDarkMode
        ? settingStore.usePitchBlack ? Themes.pitchBlack : Themes.darkTheme
        : Themes.lightTheme;
  }

  ThemeMode _getThemeMode(SettingsStore settingStore) {
    return settingStore.themeSetBySystem
        ? ThemeMode.system
        : (settingStore.useDarkMode ? ThemeMode.dark : ThemeMode.light);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<PreferenceService>(
          create: (_) => PreferenceService(_sharedPreferences),
        ),
        Provider<AnalyticsService>(
          create: (_) => AnalyticsService(),
        ),
        Provider<CloudStorageService>(
          create: (_) => CloudStorageService(),
        ),
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        Provider<FeedService>(
          create: (_) => FeedService(),
        ),
        Provider<EverythingService>(
          create: (_) => EverythingService(),
        ),
        Provider<BookmarkService>(
          create: (_) => BookmarkService(),
        ),
        Provider<PersonalisedFeedService>(
          create: (_) => PersonalisedFeedService(),
        ),
        ProxyProvider2<AnalyticsService, AuthenticationService,
            AuthenticationManager>(
          update: (_, _analyticsService, _authenticationService, __) =>
              AuthenticationManager(_authenticationService, _analyticsService),
        ),
        ProxyProvider3<AnalyticsService, AuthenticationManager, FeedService,
            FeedManager>(
          update: (_, _analyticsService, _authenticationManager, _feedService,
                  __) =>
              FeedManager(
                  _authenticationManager, _feedService, _analyticsService),
        ),
        ProxyProvider2<AnalyticsService, AuthenticationManager,
            BookmarkManager>(
          update: (_, _analyticsService, _authenticationManager, __) =>
              BookmarkManager(
                  authenticationManager: _authenticationManager,
                  activityService: BookmarkActivityService(),
                  analyticsService: _analyticsService),
        ),
        ProxyProvider2<AnalyticsService, AuthenticationManager,
            LikeManager>(
          update: (_, _analyticsService, _authenticationManager,
                  __) =>
              LikeManager(
                  authenticationManager: _authenticationManager,
                  activityService: LikeActivityService(),
                  analyticsService: _analyticsService),
        ),
        ProxyProvider<PreferenceService, HomeScreenStore>(
          update: (_, preferenceService, __) =>
              HomeScreenStore(preferenceService),
        ),
        ProxyProvider2<PreferenceService, PersonalisedFeedService,
            PersonalisedFeedStore>(
          update: (_, preferenceService, personalisedFeedService, __) =>
              PersonalisedFeedStore(preferenceService, personalisedFeedService),
        ),
        ProxyProvider2<PreferenceService, EverythingService, EverythingStore>(
          update: (_, preferenceService, everythingService, __) =>
              EverythingStore(everythingService),
          dispose: (context, everythingStore) => everythingStore.dispose(),
        ),
        ProxyProvider2<PreferenceService, BookmarkManager, BookmarkStore>(
          update: (_, preferenceService, _favouriteManager, __) =>
              BookmarkStore(preferenceService, _favouriteManager),
        ),
        ProxyProvider<PreferenceService, SettingsStore>(
          update: (_, preferenceService, __) =>
              SettingsStore(preferenceService),
        ),
      ],
      child: Consumer3<SettingsStore, AuthenticationManager, AnalyticsService>(
        builder: (context, settingStore, _authenticationManager,
            _analyticsService, _) {
          return Observer(
            builder: (_) {
              _authenticationManager.loginWithEmail(
                  email: 'admin@gmail.com', password: '12345678');
              return MaterialApp(
                theme: _getTheme(settingStore),
                home: HomeScreen(),
                themeMode: settingStore.themeSetBySystem
                    ? ThemeMode.system
                    : _getThemeMode(settingStore),
                darkTheme: settingStore.usePitchBlack
                    ? Themes.pitchBlack
                    : Themes.darkTheme,
                navigatorObservers: [
                  _analyticsService.getAnalyticsObserver(),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
