import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';

class InAppMessagingService {
  Future trigger(String event) {
    return FirebaseInAppMessaging.instance.triggerEvent(event);
  }

  Future disable(bool value) {
    return FirebaseInAppMessaging.instance.setMessagesSuppressed(value);
  }
}
