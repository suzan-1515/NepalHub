import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:samachar_hub/manager/bookmark_manager.dart';
import 'package:samachar_hub/service/analytics_service.dart';
import 'package:samachar_hub/service/authentication_service.dart';
import 'package:samachar_hub/service/bookmark_service.dart';
import 'package:samachar_hub/service/cloud_storage_service.dart';
import 'package:samachar_hub/service/everything_service.dart';
import 'package:samachar_hub/service/firestore_service.dart';
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
        Provider<FirestoreService>(
          create: (_) => FirestoreService(),
        ),
        Provider<CloudStorageService>(
          create: (_) => CloudStorageService(),
        ),
        ProxyProvider2<FirestoreService, AnalyticsService,
            AuthenticationService>(
          update: (_, _firestoreService, _analyticsService, __) =>
              AuthenticationService(
                  FirebaseAuth.instance, _firestoreService, _analyticsService),
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
        ProxyProvider3<BookmarkService, AnalyticsService, AuthenticationService,
            BookmarkManager>(
          update: (_, _bookmarkService, _analyticsService,
                  _authenticationService, __) =>
              BookmarkManager(
                  _authenticationService, _bookmarkService, _analyticsService),
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
      child: Consumer3<SettingsStore, AuthenticationService, AnalyticsService>(
        builder: (context, settingStore, _authenticationService,
            _analyticsService, _) {
          return Observer(
            builder: (_) {
              _authenticationService.loginWithEmail(
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
