import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_auth/utils/providers.dart';
import 'package:samachar_hub/feature_comment/utils/providers.dart';
import 'package:samachar_hub/feature_forex/utils/provider.dart';
import 'package:samachar_hub/feature_horoscope/utils/provider.dart';
import 'package:samachar_hub/feature_main/presentation/blocs/settings/settings_cubit.dart';
import 'package:samachar_hub/feature_main/presentation/ui/splash/splash_screen.dart';
import 'package:samachar_hub/feature_main/presentation/ui/splash/widgets/splash_view.dart';
import 'package:samachar_hub/feature_main/utils/provider.dart';
import 'package:samachar_hub/feature_news/utils/provider.dart';
import 'package:samachar_hub/global_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/themes.dart' as Themes;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  ThemeData _getTheme(bool darkMode, bool pitchBlackMode) {
    return darkMode
        ? pitchBlackMode ? Themes.pitchBlack : Themes.darkTheme
        : Themes.lightTheme;
  }

  ThemeMode _getThemeMode(bool themeSetBySystem, bool darkMode) {
    return themeSetBySystem
        ? ThemeMode.system
        : (darkMode ? ThemeMode.dark : ThemeMode.light);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: Future.wait([
        Firebase.initializeApp(),
        SharedPreferences.getInstance(),
        Future.value(NepaliUtils(Language.nepali)),
      ]),
      builder: (_, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasError) {
          return MaterialApp(
            home: Container(
              color: Colors.white,
              child: Center(
                child: Text(
                  'Oops something went run. Please restart application.',
                ),
              ),
            ),
          );
        }

        if (snapshot.hasData) {
          final sfs = snapshot.data
              .firstWhere((element) => element is SharedPreferences);
          return MultiRepositoryProvider(
            providers: [
              RepositoryProvider<SharedPreferences>.value(
                value: sfs,
              ),
              ...GlobalProvider.coreRepositoryProviders,
            ],
            child: MultiRepositoryProvider(
              providers: [
                ...GlobalProvider.core2RepositoryProviders,
                ...AuthProviders.authRepositoryProviders,
              ],
              child: MultiRepositoryProvider(
                providers: [
                  ...CommentProvider.commentRepositoryProviders,
                  ...ForexProvider.forexRepositoryProviders,
                  ...HoroscopeProvider.horoscopeRepositoryProviders,
                  ...NewsProvider.newsRepositoryProviders,
                  ...SettingsProvider.settingsRepositoryProviders,
                ],
                child: MultiRepositoryProvider(
                  providers: [
                    ...AuthProviders.auth2RepositoryProviders,
                    ...CommentProvider.comment2RepositoryProviders,
                    ...ForexProvider.forex2RepositoryProviders,
                    ...HoroscopeProvider.horoscope2RepositoryProviders,
                    ...NewsProvider.news2RepositoryProviders,
                    ...SettingsProvider.settings2RepositoryProviders,
                  ],
                  child: SettingsProvider.settingsBlocProvider(
                    child: BlocConsumer<SettingsCubit, SettingsState>(
                      listener: (context, state) {
                        if (state is SettingsInitialState) {
                          context.bloc<SettingsCubit>().getSettings();
                        }
                      },
                      buildWhen: (previous, current) =>
                          (current is SettingsInitialState) ||
                          (current is SettingsDarkModeChangedState) ||
                          (current is SettingsPitchBlackModeChangedState) ||
                          (current is SettingsLoadSuccess) ||
                          (current is SettingsSystemThemeChangedState),
                      builder: (context, state) {
                        if (state is SettingsLoadSuccess ||
                            state is SettingsDarkModeChangedState ||
                            state is SettingsPitchBlackModeChangedState ||
                            state is SettingsSystemThemeChangedState) {
                          var settings = context.bloc<SettingsCubit>().settings;
                          return MaterialApp(
                            theme: _getTheme(
                                settings.useDarkMode, settings.usePitchBlack),
                            home: SplashScreen(),
                            themeMode: settings.themeSetBySystem
                                ? ThemeMode.system
                                : _getThemeMode(settings.themeSetBySystem,
                                    settings.useDarkMode),
                            darkTheme: settings.usePitchBlack
                                ? Themes.pitchBlack
                                : Themes.darkTheme,
                            navigatorObservers: [
                              context
                                  .repository<AnalyticsService>()
                                  .getAnalyticsObserver(),
                            ],
                          );
                        }

                        return MaterialApp(
                          home: SplashView(),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          );
        }

        return MaterialApp(
          home: SplashView(),
        );
      },
    );
  }
}
