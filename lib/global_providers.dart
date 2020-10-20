import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:samachar_hub/core/handlers/notification_handler.dart';
import 'package:samachar_hub/core/network/http_manager/app_http_manager.dart';
import 'package:samachar_hub/core/network/http_manager/http_manager.dart';
import 'package:samachar_hub/core/network/network_info.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalProvider {
  GlobalProvider._();
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
