import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:samachar_hub/common/auth_service.dart';
import 'package:samachar_hub/routes/home/logic/home_screen_store.dart';
import 'package:samachar_hub/routes/home/pages/everything/logic/everything_service.dart';
import 'package:samachar_hub/routes/home/pages/everything/logic/everything_store.dart';
import 'package:samachar_hub/routes/home/pages/favourites/logic/favourites_service.dart';
import 'package:samachar_hub/routes/home/pages/favourites/logic/favourites_store.dart';
import 'package:samachar_hub/routes/home/pages/personalised/logic/personalised_service.dart';
import 'package:samachar_hub/routes/home/pages/personalised/logic/personalised_store.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'common/preference_service.dart';
import 'routes/home/pages/settings/logic/settings_store.dart';
import 'routes/routes.dart';
import 'common/themes.dart' as Themes;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  final SharedPreferences sp = await SharedPreferences.getInstance();
  final FirebaseAnalytics analytics = FirebaseAnalytics();
  runApp(App(sp, analytics));
}

class App extends StatelessWidget {
  App(this._sharedPreferences, this._analytics);

  final SharedPreferences _sharedPreferences;
  final FirebaseAnalytics _analytics;

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
        Provider<EverythingService>(
          create: (_) => EverythingService(),
        ),
        Provider<FavouritesService>(
          create: (_) => FavouritesService(),
        ),
        Provider<PersonalisedFeedService>(
          create: (_) => PersonalisedFeedService(),
        ),
        ProxyProvider<PreferenceService, AuthService>(
          update: (_, _preferenceService, __) =>
              AuthService(_preferenceService),
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
        ProxyProvider3<PreferenceService, AuthService, FavouritesService, FavouritesStore>(
          update: (_, preferenceService, authService, favouriteService, __) =>
              FavouritesStore(preferenceService, authService, favouriteService),
        ),
        ProxyProvider<PreferenceService, SettingsStore>(
          update: (_, preferenceService, __) =>
              SettingsStore(preferenceService),
        ),
      ],
      child: Consumer2<SettingsStore, PreferenceService>(
        builder: (context, settingStore, preferenceService, _) {
          return Observer(
            builder: (_) => MaterialApp(
              theme: _getTheme(settingStore),
              home: HomeScreen(),
              themeMode: settingStore.themeSetBySystem
                  ? ThemeMode.system
                  : _getThemeMode(settingStore),
              darkTheme: settingStore.usePitchBlack
                  ? Themes.pitchBlack
                  : Themes.darkTheme,
              navigatorObservers: [
                FirebaseAnalyticsObserver(analytics: _analytics),
              ],
            ),
          );
        },
      ),
    );
  }
}
