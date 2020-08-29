import 'dart:developer';

import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:samachar_hub/services/notification_service.dart';
import 'package:samachar_hub/services/preference_service.dart';

class NotificationHandler {
  final NotificationService _notificationService;
  final PreferenceService _preferenceService;
  NotificationHandler(this._notificationService, this._preferenceService) {
    _handleOneSignal();
    _handleLocal();
  }

  _handleOneSignal() {
    log('[NotificationHandler] _handleOneSignal');
    OneSignal.shared
        .setNotificationReceivedHandler((OSNotification notification) {
      // will be called whenever a notification is received
      log('[NotificationHandler] Notification recieved: ${notification.jsonRepresentation()}');
    });

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      // will be called whenever a notification is opened/button pressed.
      log('[NotificationHandler] Notification opened: ${result.action.type}');
    });

    OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
      // will be called whenever the permission changes
      // (ie. user taps Allow on the permission prompt in iOS)
      log('[NotificationHandler] Notification permission changed: ${changes.jsonRepresentation()}');
    });

    OneSignal.shared
        .setSubscriptionObserver((OSSubscriptionStateChanges changes) {
      // will be called whenever the subscription changes
      //(ie. user gets registered with OneSignal and gets a user ID)
      log('[NotificationHandler] Onesignal subscription changed: ${changes.jsonRepresentation()}');
      if (!changes.from.subscribed && changes.to.subscribed) {
        log('[NotificationHandler] Onesignal first time subscription ');
        _notificationService.setDefaultRemoteNotification();
      }
    });

    OneSignal.shared.setEmailSubscriptionObserver(
        (OSEmailSubscriptionStateChanges emailChanges) {
      // will be called whenever then user's email subscription changes
      // (ie. OneSignal.setEmail(email) is called and the user gets registered
      log('[NotificationHandler] Onesignal email subscription changed: ${emailChanges.jsonRepresentation()}');
    });
  }

  _handleLocal() {
    log('[NotificationHandler] _handleLocal');
    _notificationService.selectNotificationStream.listen((event) {
      log('Local notification received: $event');
    }, cancelOnError: true);
    if (!_preferenceService.defaultLocalNotifications) {
      _preferenceService.defaultLocalNotifications = true;
      _notificationService.setDefaultLocalNotification();
    }
  }

  dispose() {}
}
