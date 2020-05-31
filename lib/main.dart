import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:samachar_hub/pages/authentication/login/login_screen.dart';
import 'package:samachar_hub/pages/category/categories_store.dart';
import 'package:samachar_hub/pages/corona/corona_api_service.dart';
import 'package:samachar_hub/pages/corona/corona_repository.dart';
import 'package:samachar_hub/pages/forex/forex_api_service.dart';
import 'package:samachar_hub/pages/forex/forex_repository.dart';
import 'package:samachar_hub/pages/home/home_screen_store.dart';
import 'package:samachar_hub/pages/horoscope/horoscope_api_service.dart';
import 'package:samachar_hub/pages/horoscope/horoscope_repository.dart';
import 'package:samachar_hub/pages/news/news_api_service.dart';
import 'package:samachar_hub/pages/news/news_repository.dart';
import 'package:samachar_hub/pages/personalised/personalised_store.dart';
import 'package:samachar_hub/pages/settings/settings_store.dart';
import 'package:samachar_hub/repository/post_meta_repository.dart';
import 'package:samachar_hub/repository/repositories.dart';
import 'package:samachar_hub/services/services.dart';
import 'package:samachar_hub/stores/stores.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'common/themes.dart' as Themes;
import 'pages/bookmark/bookmark_firestore_service.dart';
import 'pages/bookmark/bookmark_repository.dart';
import 'pages/bookmark/bookmark_store.dart';
import 'pages/corona/corona_store.dart';

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
        ProxyProvider<AnalyticsService, ShareService>(
          update: (_, _analyticsService, __) => ShareService(_analyticsService),
        ),

        //repository
        ProxyProvider<AnalyticsService, AuthenticationRepository>(
          update: (_, _analyticsService, __) => AuthenticationRepository(
              AuthenticationService(FirebaseAuth.instance), _analyticsService),
        ),
        ProxyProvider2<AnalyticsService, PreferenceService, PostMetaRepository>(
          update: (_, _analyticsService, _preferenceService, __) =>
              PostMetaRepository(PostMetaFirestoreService(), _analyticsService,
                  _preferenceService),
        ),

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
        ProxyProvider3<AnalyticsService, PreferenceService, PostMetaRepository,
            BookmarkRepository>(
          update: (_, _analyticsService, _preferenceService,
                  _postMetaRepository, __) =>
              BookmarkRepository(BookmarkFirestoreService(),
                  _postMetaRepository, _analyticsService, _preferenceService),
        ),

        //store
        ProxyProvider<AuthenticationRepository, AuthenticationStore>(
          update: (_, _authenticationRepository, __) =>
              AuthenticationStore(_authenticationRepository),
        ),
        ProxyProvider<PreferenceService, HomeScreenStore>(
          update: (_, preferenceService, __) =>
              HomeScreenStore(preferenceService),
        ),
        ProxyProvider4<NewsRepository, ForexRepository, HoroscopeRepository,
            CoronaRepository, PersonalisedFeedStore>(
          update: (_, _newsRepository, _forexRepository, _horoscopeRepository,
                  _coronaRepository, __) =>
              PersonalisedFeedStore(_newsRepository, _horoscopeRepository,
                  _forexRepository, _coronaRepository),
        ),
        ProxyProvider<NewsRepository, CategoriesStore>(
          update: (_, _newsRepository, __) => CategoriesStore(_newsRepository),
          dispose: (context, categoriesStore) => categoriesStore.dispose(),
        ),
        ProxyProvider2<BookmarkRepository, AuthenticationStore, BookmarkStore>(
          update: (_, _bookmarkRepository, _authenticationStore, __) =>
              BookmarkStore(_bookmarkRepository, _authenticationStore.user),
        ),

        ProxyProvider<CoronaRepository, CoronaStore>(
          update: (_, _coronaRepository, __) => CoronaStore(_coronaRepository),
          dispose: (context, value) => value.dispose(),
        ),
        ProxyProvider<PreferenceService, SettingsStore>(
          update: (_, preferenceService, __) =>
              SettingsStore(preferenceService),
        ),
      ],
      child: Consumer2<SettingsStore, AnalyticsService>(
        builder: (context, settingStore, _analyticsService, _) {
          return Observer(
            builder: (_) {
              return MaterialApp(
                theme: _getTheme(settingStore),
                home: LoginScreen(),
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
