import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:samachar_hub/core/handlers/notification_handler.dart';
import 'package:samachar_hub/core/network/http_manager/app_http_manager.dart';
import 'package:samachar_hub/core/network/network_info.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalProvider {
  GlobalProvider._();
  static List<RepositoryProvider> get coreRepositoryProviders => [
        RepositoryProvider<AppHttpManager>(
          create: (context) => AppHttpManager(),
        ),
        RepositoryProvider<PreferenceService>(
          create: (context) =>
              PreferenceService(context.repository<SharedPreferences>()),
        ),
        RepositoryProvider<NotificationService>(
          create: (context) =>
              NotificationService(FlutterLocalNotificationsPlugin()),
        ),
        RepositoryProvider<AnalyticsService>(
          create: (context) => AnalyticsService(),
        ),
      ];
  static List<RepositoryProvider> get core2RepositoryProviders => [
        RepositoryProvider<NetworkInfoImpl>(
          create: (context) => NetworkInfoImpl(DataConnectionChecker()),
        ),
        RepositoryProvider<NavigationService>(
          create: (context) => NavigationService(),
        ),
        RepositoryProvider<InAppMessagingService>(
          create: (context) => InAppMessagingService(),
        ),
        RepositoryProvider<NotificationHandler>(
          lazy: false,
          create: (context) => NotificationHandler(
              context.repository<NotificationService>(),
              context.repository<PreferenceService>()),
        ),
        RepositoryProvider<ShareService>(
          create: (context) =>
              ShareService(context.repository<AnalyticsService>()),
        ),
      ];
}
