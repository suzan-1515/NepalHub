import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:samachar_hub/notifier/forex_setting_notifier.dart';
import 'package:samachar_hub/notifier/horoscope_setting_notifier.dart';
import 'package:samachar_hub/notifier/news_setting_notifier.dart';
import 'package:samachar_hub/pages/corona/corona_api_service.dart';
import 'package:samachar_hub/pages/corona/corona_repository.dart';
import 'package:samachar_hub/pages/following/following_store.dart';
import 'package:samachar_hub/pages/splash/splash_screen.dart';
import 'package:samachar_hub/services/forex_api_service.dart';
import 'package:samachar_hub/repository/forex_repository.dart';
import 'package:samachar_hub/services/horoscope_api_service.dart';
import 'package:samachar_hub/repository/horoscope_repository.dart';
import 'package:samachar_hub/services/news_api_service.dart';
import 'package:samachar_hub/repository/news_repository.dart';
import 'package:samachar_hub/pages/settings/settings_store.dart';
import 'package:samachar_hub/repository/following_repository.dart';
import 'package:samachar_hub/repository/post_meta_repository.dart';
import 'package:samachar_hub/repository/repositories.dart';
import 'package:samachar_hub/services/following_firestore_service.dart';
import 'package:samachar_hub/services/services.dart';
import 'package:samachar_hub/stores/stores.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'common/themes.dart' as Themes;
import 'services/bookmark_firestore_service.dart';
import 'repository/bookmark_repository.dart';
import 'pages/corona/corona_store.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        ProxyProvider<AnalyticsService, ShareService>(
          update: (_, _analyticsService, __) => ShareService(_analyticsService),
        ),
        ChangeNotifierProvider(
          create: (_) => NewsSettingNotifier(),
        ),
        ChangeNotifierProvider(
          create: (_) => ForexSettingNotifier(),
        ),
        ChangeNotifierProvider(
          create: (_) => HoroscopeSettingNotifier(),
        ),

        //repository
        ProxyProvider<AnalyticsService, AuthenticationRepository>(
          update: (_, _analyticsService, __) => AuthenticationRepository(
              AuthenticationService(FirebaseAuth.instance, GoogleSignIn()),
              _analyticsService),
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
        ProxyProvider2<PreferenceService, AnalyticsService, ForexRepository>(
          update: (_, preferenceService, analyticsService, __) =>
              ForexRepository(
                  preferenceService, ForexApiService(), analyticsService),
        ),
        ProxyProvider2<PreferenceService, AnalyticsService,
            HoroscopeRepository>(
          update: (_, preferenceService, analyticsService, __) =>
              HoroscopeRepository(
                  preferenceService, HoroscopeApiService(), analyticsService),
        ),

        ProxyProvider2<AnalyticsService, PreferenceService,
            FollowingRepository>(
          update: (_, _analyticsService, _preferenceService, __) =>
              FollowingRepository(FollowingFirestoreService(),
                  _analyticsService, _preferenceService),
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
        ProxyProvider4<NewsRepository, ForexRepository, HoroscopeRepository,
            CoronaRepository, HomeStore>(
          update: (_, _newsRepository, _forexRepository, _horoscopeRepository,
                  _coronaRepository, __) =>
              HomeStore(_newsRepository, _horoscopeRepository, _forexRepository,
                  _coronaRepository),
        ),
        ProxyProvider<NewsRepository, PersonalisedNewsStore>(
          update: (_, _newsRepository, __) =>
              PersonalisedNewsStore(_newsRepository),
          dispose: (context, value) => value.dispose(),
        ),
        ProxyProvider<NewsRepository, NewsCategoryScreenStore>(
          update: (_, _newsRepository, __) =>
              NewsCategoryScreenStore(_newsRepository),
          dispose: (context, categoriesStore) => categoriesStore.dispose(),
        ),

        ProxyProvider<NewsRepository, FollowingStore>(
          update: (_, _newsRepository, __) => FollowingStore(_newsRepository),
          dispose: (context, value) => value.dispose(),
        ),

        ProxyProvider<CoronaRepository, CoronaStore>(
          update: (_, _coronaRepository, __) => CoronaStore(_coronaRepository),
          dispose: (context, value) => value.dispose(),
        ),
        ProxyProvider<PreferenceService, SettingsStore>(
          update: (_, preferenceService, __) =>
              SettingsStore(preferenceService),
        ),
        ProxyProvider<PreferenceService, MoreMenuStore>(
          update: (_, preferenceService, __) =>
              MoreMenuStore(preferenceService),
        ),
      ],
      child: Consumer2<SettingsStore, AnalyticsService>(
        builder: (context, settingStore, _analyticsService, _) {
          return Observer(
            builder: (_) {
              return MaterialApp(
                theme: _getTheme(settingStore),
                home: SplashScreen(),
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
