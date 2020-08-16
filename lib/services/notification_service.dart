import 'dart:async';
import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final SelectNotificationCallback selectNotificationCallback;
  final Future<dynamic> Function(int, String, String, String)
      onDidReceiveLocalNotification;

  final StreamController<String> _selectNotificationController =
      StreamController<String>();

  Stream<String> get selectNotificationStream =>
      _selectNotificationController.stream;

  NotificationService(this.flutterLocalNotificationsPlugin,
      {this.selectNotificationCallback, this.onDidReceiveLocalNotification}) {
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
          log('notification payload: $payload');
        }
        _selectNotificationController.add(payload);
      },
    );
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

  dispose() {
    _selectNotificationController.close();
  }
}
