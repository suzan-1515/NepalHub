import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:samachar_hub/common/manager/managers.dart';
import 'package:samachar_hub/common/service/corona_api_service.dart';
import 'package:samachar_hub/common/service/forex_api_service.dart';
import 'package:samachar_hub/common/service/horoscope_api_service.dart';
import 'package:samachar_hub/common/service/navigation_service.dart';
import 'package:samachar_hub/common/service/news_api_service.dart';
import 'package:samachar_hub/common/service/services.dart';
import 'package:samachar_hub/common/store/corona_store.dart';
import 'package:samachar_hub/common/store/like_store.dart';
import 'package:samachar_hub/pages/bookmark/bookmark_activity_service.dart';
import 'package:samachar_hub/pages/bookmark/bookmark_manager.dart';
import 'package:samachar_hub/pages/bookmark/bookmark_store.dart';
import 'package:samachar_hub/pages/category/categories_store.dart';
import 'package:samachar_hub/pages/home/home_screen_store.dart';
import 'package:samachar_hub/pages/pages.dart';
import 'package:samachar_hub/pages/settings/settings_store.dart';
import 'package:samachar_hub/repository/corona_repository.dart';
import 'package:samachar_hub/repository/forex_repository.dart';
import 'package:samachar_hub/repository/horoscope_repository.dart';
import 'package:samachar_hub/repository/news_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'common/themes.dart' as Themes;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  final SharedPreferences sp = await SharedPreferences.getInstance();
  NepaliUtils(Language.nepali);
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
        Provider<NavigationService>(
          create: (_) => NavigationService(),
        ),
        Provider<AnalyticsService>(
          create: (_) => AnalyticsService(),
        ),
        Provider<CloudStorageService>(
          create: (_) => CloudStorageService(),
        ),

        //manager
        ProxyProvider<AnalyticsService, AuthenticationManager>(
          update: (_, _analyticsService, __) => AuthenticationManager(
              AuthenticationService(FirebaseAuth.instance), _analyticsService),
        ),
        ProxyProvider2<AnalyticsService, AuthenticationManager,
            NewsFirestoreManager>(
          update: (_, _analyticsService, _authenticationManager, __) =>
              NewsFirestoreManager(_authenticationManager,
                  NewsFirestoreService(), _analyticsService),
        ),
        ProxyProvider2<AnalyticsService, AuthenticationManager,
            BookmarkManager>(
          update: (_, _analyticsService, _authenticationManager, __) =>
              BookmarkManager(
                  authenticationManager: _authenticationManager,
                  activityService: BookmarkActivityService(),
                  analyticsService: _analyticsService),
        ),
        ProxyProvider2<AnalyticsService, AuthenticationManager, LikeManager>(
          update: (_, _analyticsService, _authenticationManager, __) =>
              LikeManager(
                  authenticationManager: _authenticationManager,
                  activityService: LikeActivityService(),
                  analyticsService: _analyticsService),
        ),

        //repository
        ProxyProvider<PreferenceService, NewsRepository>(
          update: (_, _preferenceService, __) =>
              NewsRepository(NewsApiService(), _preferenceService),
        ),
        Provider<CoronaRepository>(
          create: (_) => CoronaRepository(CoronaApiService()),
        ),
        Provider<ForexRepository>(
          create: (_) => ForexRepository(ForexApiService()),
        ),
        Provider<HoroscopeRepository>(
          create: (_) => HoroscopeRepository(HoroscopeApiService()),
        ),

        //store
        ProxyProvider<PreferenceService, HomeScreenStore>(
          update: (_, preferenceService, __) =>
              HomeScreenStore(preferenceService),
        ),
        ProxyProvider<NewsRepository, CategoriesStore>(
          update: (_, _newsRepository, __) => CategoriesStore(_newsRepository),
          dispose: (context, categoriesStore) => categoriesStore.dispose(),
        ),
        ProxyProvider2<PreferenceService, BookmarkManager, BookmarkStore>(
          update: (_, preferenceService, _favouriteManager, __) =>
              BookmarkStore(preferenceService, _favouriteManager),
        ),

        ProxyProvider2<PreferenceService, LikeManager, LikeStore>(
          update: (_, preferenceService, _likeManager, __) =>
              LikeStore(preferenceService, _likeManager),
        ),

        ProxyProvider2<PreferenceService, CoronaRepository, CoronaStore>(
          update: (_, preferenceService, _coronaRepository, __) =>
              CoronaStore(preferenceService, _coronaRepository),
          dispose: (context, value) => value.dispose(),
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
