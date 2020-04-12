import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:samachar_hub/routes/home/logic/home_screen_store.dart';
import 'package:samachar_hub/routes/home/pages/everything/logic/everything_service.dart';
import 'package:samachar_hub/routes/home/pages/everything/logic/everything_store.dart';
import 'package:samachar_hub/routes/home/pages/personalised/logic/personalised_service.dart';
import 'package:samachar_hub/routes/home/pages/personalised/logic/personalised_store.dart';
import 'package:samachar_hub/routes/home/pages/settings/settings_store.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'common/preference_service.dart';
import 'routes/routes.dart';
import 'common/themes.dart' as Themes;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences sp = await SharedPreferences.getInstance();
  runApp(App(sp));
}

class App extends StatelessWidget {
  App(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  ThemeData _getTheme(SettingsStore settingStore) {
    return settingStore.useDarkMode ? settingStore.usePitchBlack ? Themes.pitchBlack : Themes.darkTheme : Themes.lightTheme;
  }

  ThemeMode _getThemeMode(SettingsStore settingStore) {
    return settingStore.themeSetBySystem ? ThemeMode.system : (settingStore.useDarkMode ? ThemeMode.dark : ThemeMode.light);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<PreferenceService>(
          create: (_) => PreferenceService(_sharedPreferences),
        ),
        ProxyProvider<PreferenceService, SettingsStore>(
          update: (_, preferenceService, __) => SettingsStore(preferenceService),
        ),
        ProxyProvider<PreferenceService, EverythingStore>(
          update: (_, preferenceService, __) => EverythingStore(EverythingService()),
        ),
        ProxyProvider<PreferenceService, PersonalisedFeedStore>(
          update: (_, preferenceService, __) => PersonalisedFeedStore(PersonalisedFeedService()),
        ),
        ProxyProvider<PreferenceService, HomeScreenStore>(
          update: (_, preferenceService, __) => HomeScreenStore(preferenceService),
        )
      ],
      child: Consumer<SettingsStore>(
        builder: (context, settingStore, _) {
          return Observer(
            builder: (_) => MaterialApp(
              theme: _getTheme(settingStore),
              home: HomeScreen(),
              themeMode: settingStore.themeSetBySystem ? ThemeMode.system : _getThemeMode(settingStore),
              darkTheme: settingStore.usePitchBlack ? Themes.pitchBlack : Themes.darkTheme,
            ),
          );
        },
      ),
    );
  }
}
