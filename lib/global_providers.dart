import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:samachar_hub/core/handlers/notification_handler.dart';
import 'package:samachar_hub/core/services/services.dart';

class GlobalProvider {
  GlobalProvider._();
  static List<RepositoryProvider> get coreRepositoryProviders => [
        RepositoryProvider(
          create: (context) => AnalyticsService(),
        ),
        RepositoryProvider(
          create: (context) => NavigationService(),
        ),
        RepositoryProvider(
          create: (context) => InAppMessagingService(),
        ),
        RepositoryProvider(
          create: (context) =>
              ShareService(context.repository<AnalyticsService>()),
        ),
        RepositoryProvider(
            create: (context) => FlutterLocalNotificationsPlugin()),
        RepositoryProvider(
          create: (context) => NotificationService(
              context.repository<FlutterLocalNotificationsPlugin>()),
        ),
        RepositoryProvider(
          create: (context) => NotificationHandler(
              context.repository<NotificationService>(),
              context.repository<PreferenceService>()),
        ),
        RepositoryProvider(
          create: (context) =>
              ShareService(context.repository<AnalyticsService>()),
        ),
      ];

  static List<RepositoryProvider> get commentRepositoryProviders => [];
  static List<RepositoryProvider> get forexRepositoryProviders => [];
  static List<RepositoryProvider> get horoscopeRepositoryProviders => [];
  static List<RepositoryProvider> get goldRepositoryProviders => [];
  static List<RepositoryProvider> get newsRepositoryProviders => [];
  static List<RepositoryProvider> get profileRepositoryProviders => [];
}
