import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:samachar_hub/common/notification_channels.dart';
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
        _initFirstTimeSubscribtion();
        _initFirstTimeLocalSubscription();
      }
    });

    OneSignal.shared.setEmailSubscriptionObserver(
        (OSEmailSubscriptionStateChanges emailChanges) {
      // will be called whenever then user's email subscription changes
      // (ie. OneSignal.setEmail(email) is called and the user gets registered
      log('[NotificationHandler] Onesignal email subscription changed: ${emailChanges.jsonRepresentation()}');
    });
  }

  _initFirstTimeSubscribtion() {
    log('[NotificationHandler] _initFirstTimeSubscribtion');
    _notificationService.subscribe(NotificationChannels.kNewsNotifications, 1);
    _notificationService.subscribe(
        NotificationChannels.kTrendingNotifications, 1);
    _notificationService.subscribe(
        NotificationChannels.kCommentNotifications, 1);
    _notificationService.subscribe(
        NotificationChannels.kMessageNotifications, 1);
    _notificationService.subscribe(NotificationChannels.kOtherNotifications, 1);
  }

  _initFirstTimeLocalSubscription() {
    log('[NotificationHandler] _initFirstTimeLocalSubscription');
    _notificationService.scheduleNotificationDaily(
        NotificationChannels.kMorningNewsId,
        'Good Morning 🌅',
        'Your personalised daily news is ready. Click to read. 📰',
        NotificationChannels.kMorningNewsChannelId,
        NotificationChannels.kMorningNewsChannelName,
        NotificationChannels.kMorningNewsChannelDesc,
        Time(7, 0, 0));

    _notificationService.scheduleNotificationDaily(
        NotificationChannels.kMorningHoroscopeId,
        'Good Morning 🌅',
        'Your daily horoscope is here. Click to read. 📰',
        NotificationChannels.kMorningHoroscopeChannelId,
        NotificationChannels.kMorningHoroscopeChannelName,
        NotificationChannels.kMorningHoroscopeChannelDesc,
        Time(7, 0, 0));
  }

  _handleLocal() {
    log('[NotificationHandler] _handleLocal');
    _notificationService.selectNotificationStream.listen((event) {
      log('Local notification received: $event');
    }, cancelOnError: true);
  }

  dispose() {}
}
