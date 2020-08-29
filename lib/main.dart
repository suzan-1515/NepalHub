import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:samachar_hub/handlers/dynamic_link_handler.dart';
import 'package:samachar_hub/handlers/notification_handler.dart';
import 'package:samachar_hub/pages/splash/splash_screen.dart';
import 'package:samachar_hub/pages/settings/settings_store.dart';
import 'package:samachar_hub/pages/splash/widgets/splash_view.dart';
import 'package:samachar_hub/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'common/themes.dart' as Themes;
import 'repository/authentication_repository.dart';
import 'services/crash_analytics_service.dart';
import 'services/dynamic_link_service.dart';
import 'services/notification_service.dart';
import 'stores/auth/auth_store.dart';
import 'stores/main/main_store.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
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
              child: Center(
                child: Text(
                    'Oops something went run.\nPlease restart application.'),
              ),
            ),
          );
        }

        if (snapshot.hasData) {
          final sfs = snapshot.data
              .firstWhere((element) => element is SharedPreferences);
          return MultiProvider(
            providers: [
              Provider<PreferenceService>(
                create: (_) => PreferenceService(sfs),
              ),
              Provider<AnalyticsService>(
                create: (_) => AnalyticsService(),
              ),
              Provider<NavigationService>(
                create: (_) => NavigationService(),
              ),
              //Notification
              Provider<FlutterLocalNotificationsPlugin>(
                create: (_) => FlutterLocalNotificationsPlugin(),
              ),
              ProxyProvider<FlutterLocalNotificationsPlugin,
                  NotificationService>(
                update: (_, _flutterLocalNotificationsPlugin, __) =>
                    NotificationService(_flutterLocalNotificationsPlugin),
                dispose: (context, value) => value.dispose(),
              ),
              ProxyProvider2<NotificationService, PreferenceService,
                  NotificationHandler>(
                lazy: false,
                update: (_, _notificationService, _preferenceService, __) =>
                    NotificationHandler(
                        _notificationService, _preferenceService),
                dispose: (context, value) => value.dispose(),
              ),
              Provider<DynamicLinkService>(
                create: (_) => DynamicLinkService(),
                dispose: (context, value) => value.dispose(),
              ),
              ProxyProvider<DynamicLinkService, DynamicLinkHandler>(
                update: (_, _dynamicLinkService, __) =>
                    DynamicLinkHandler(_dynamicLinkService),
              ),

              //repository
              ProxyProvider2<AnalyticsService, NotificationService,
                  AuthenticationRepository>(
                update: (_, _analyticsService, _notificationService, __) =>
                    AuthenticationRepository(
                        AuthenticationService(FirebaseAuth.instance,
                            GoogleSignIn(), FacebookAuth.instance),
                        _analyticsService,
                        _notificationService),
              ),

              //store
              ProxyProvider<AuthenticationRepository, AuthenticationStore>(
                update: (_, _authenticationRepository, __) =>
                    AuthenticationStore(_authenticationRepository),
              ),
              Provider<MainStore>(
                create: (_) => MainStore(),
                dispose: (context, value) => value.dispose(),
              ),
              ProxyProvider<PreferenceService, SettingsStore>(
                update: (_, preferenceService, __) =>
                    SettingsStore(preferenceService),
              ),

              ProxyProvider<AuthenticationRepository, CrashAnalyticsService>(
                lazy: false,
                update: (_, _authenticationRepository, __) =>
                    CrashAnalyticsService(_authenticationRepository),
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
        return MaterialApp(
          home: SplashView(),
        );
      },
    );
  }
}
