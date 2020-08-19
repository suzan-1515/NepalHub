import 'dart:async';
import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:samachar_hub/common/api_keys.dart';
import 'package:samachar_hub/repository/repositories.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final AuthenticationRepository _authenticationRepository;

  final SelectNotificationCallback selectNotificationCallback;
  final Future<dynamic> Function(int, String, String, String)
      onDidReceiveLocalNotification;

  final StreamController<String> _selectNotificationController =
      StreamController<String>();

  Stream<String> get selectNotificationStream =>
      _selectNotificationController.stream;

  NotificationService(
      this.flutterLocalNotificationsPlugin, this._authenticationRepository,
      {this.selectNotificationCallback, this.onDidReceiveLocalNotification}) {
    _initLocal();
    _initOneSignal();
  }

  _initLocal() {
    log('[NotificationService] _initLocal');
    const initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    final initializationSettings = InitializationSettings(
      initializationSettingsAndroid,
      initializationSettingsIOS,
    );
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String payload) async {
        if (payload != null) {
          log('[NotificationService] notification payload: $payload');
        }
        _selectNotificationController.add(payload);
      },
    );
  }

  _initOneSignal() async {
    log('[NotificationService] _initOneSignal');
    //Remove this method to stop OneSignal Debugging
    OneSignal.shared.setLogLevel(OSLogLevel.none, OSLogLevel.none);

    OneSignal.shared.init(ApiKeys.ONESIGNAL_APP_ID, iOSSettings: {
      OSiOSSettings.autoPrompt: true,
      OSiOSSettings.inAppLaunchUrl: false
    });
    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);

// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    await OneSignal.shared
        .promptUserForPushNotificationPermission(fallbackToSettings: true);

    _authenticationRepository.authStateChanges().listen((event) {
      if (event != null && !event.isAnonymous) {
        log('[NotificationService] setEmail');
        OneSignal.shared.setEmail(email: event.email).catchError((onError) {
          log('[NotificationService] setEmail', error: onError);
        });
      }
    });
  }

  Future<void> show(
    int id,
    String title,
    String message, {
    String channelId,
    String channelName,
    String channelDescription,
  }) async {
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription,
      priority: Priority.Max,
      importance: Importance.Max,
      visibility: NotificationVisibility.Public,
    );
    const iOSPlatformChannelSpecifics = IOSNotificationDetails();
    final platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics,
      iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      message,
      platformChannelSpecifics,
    );
  }

  Future<void> scheduleNotificationPeriodically(
      int id,
      String title,
      String message,
      String channelId,
      String channelName,
      String channelDescription,
      RepeatInterval interval) async {
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription,
      priority: Priority.Max,
      importance: Importance.Max,
      visibility: NotificationVisibility.Public,
    );
    const iOSPlatformChannelSpecifics = IOSNotificationDetails();
    final platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics,
      iOSPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.periodicallyShow(
      id,
      title,
      message,
      interval,
      platformChannelSpecifics,
    );
  }

  Future<void> scheduleNotificationDaily(
      int id,
      String title,
      String message,
      String channelId,
      String channelName,
      String channelDescription,
      Time time) async {
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription,
      priority: Priority.Max,
      importance: Importance.Max,
      visibility: NotificationVisibility.Public,
    );
    const iOSPlatformChannelSpecifics = IOSNotificationDetails();
    final platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics,
      iOSPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.showDailyAtTime(
      id,
      title,
      message,
      time,
      platformChannelSpecifics,
    );
  }

  Future<void> subscribe(String key, dynamic value) async {
    return OneSignal.shared.sendTag(key, value);
  }

  Future<void> unSubscribe(String key) async {
    return OneSignal.shared.deleteTag(key);
  }

  Future<void> subscribeAll(Map<String, String> tags) async {
    return OneSignal.shared.sendTags(tags);
  }

  Future<void> unSubscribeAll(List<String> tags) async {
    return OneSignal.shared.deleteTags(tags);
  }

  dispose() {
    _selectNotificationController.close();
  }
}
