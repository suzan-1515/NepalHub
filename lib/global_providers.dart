import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/handlers/notification_handler.dart';
import 'package:samachar_hub/core/network/http_manager/app_http_manager.dart';
import 'package:samachar_hub/core/network/http_manager/http_manager.dart';
import 'package:samachar_hub/core/network/network_info.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_auth/utils/providers.dart';
import 'package:samachar_hub/feature_comment/utils/providers.dart';
import 'package:samachar_hub/feature_forex/utils/provider.dart';
import 'package:samachar_hub/feature_horoscope/utils/provider.dart';
import 'package:samachar_hub/feature_main/utils/provider.dart';
import 'package:samachar_hub/feature_news/utils/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalProvider {
  GlobalProvider._();
  static setup(SharedPreferences sharedPreferences) {
    GetIt.I.registerLazySingleton<SharedPreferences>(
      () => sharedPreferences,
    );
    GetIt.I.registerLazySingleton<PreferenceService>(
      () => PreferenceService(GetIt.I.get<SharedPreferences>()),
    );
    GetIt.I.registerLazySingleton<HttpManager>(
      () => AppHttpManager(),
    );
    GetIt.I.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(DataConnectionChecker()),
    );
    GetIt.I.registerLazySingleton<CrashAnalyticsService>(
      () => CrashAnalyticsService(),
    );
    GetIt.I.registerLazySingleton<AnalyticsService>(
      () => AnalyticsService(),
    );
    GetIt.I.registerLazySingleton<DynamicLinkService>(
      () => DynamicLinkService(),
      dispose: (param) => param.dispose(),
    );
    GetIt.I.registerLazySingleton<NavigationService>(
      () => NavigationService(),
    );
    GetIt.I.registerLazySingleton<InAppMessagingService>(
      () => InAppMessagingService(),
    );
    GetIt.I.registerLazySingleton<ShareService>(
      () => ShareService(GetIt.I.get<AnalyticsService>()),
    );
    GetIt.I.registerLazySingleton<NotificationService>(
      () => NotificationService(FlutterLocalNotificationsPlugin()),
      dispose: (param) => param.dispose(),
    );
    GetIt.I.registerSingleton<NotificationHandler>(
      NotificationHandler(
        GetIt.I.get<NotificationService>(),
        GetIt.I.get<PreferenceService>(),
      ),
      dispose: (param) => param.dispose(),
    );

    AuthProviders.setup();
    CommentProvider.setup();
    ForexProvider.setup();
    HoroscopeProvider.setup();
    NewsProvider.setup();
    HomeProvider.setup();
    SettingsProvider.setup();
  }

  static List<RepositoryProvider> get coreRepositoryProviders => [
        RepositoryProvider<PreferenceService>(
          create: (context) =>
              PreferenceService(context.repository<SharedPreferences>()),
        ),
        RepositoryProvider<HttpManager>(
          create: (context) => AppHttpManager(),
        ),
        RepositoryProvider<NetworkInfo>(
          create: (context) => NetworkInfoImpl(DataConnectionChecker()),
        ),
        RepositoryProvider<CrashAnalyticsService>(
          create: (context) => CrashAnalyticsService(),
        ),
        RepositoryProvider<AnalyticsService>(
          create: (context) => AnalyticsService(),
        ),
        RepositoryProvider<DynamicLinkService>(
          create: (context) => DynamicLinkService(),
        ),
        RepositoryProvider<NavigationService>(
          create: (context) => NavigationService(),
        ),
        RepositoryProvider<InAppMessagingService>(
          create: (context) => InAppMessagingService(),
        ),
        RepositoryProvider<ShareService>(
          create: (context) =>
              ShareService(context.repository<AnalyticsService>()),
        ),
        RepositoryProvider<NotificationService>(
          create: (context) =>
              NotificationService(FlutterLocalNotificationsPlugin()),
        ),
        RepositoryProvider<NotificationHandler>(
          lazy: false,
          create: (context) => NotificationHandler(
              context.repository<NotificationService>(),
              context.repository<PreferenceService>()),
        ),
      ];
}
