import 'dart:developer';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class CrashAnalyticsService {
  CrashAnalyticsService() {
    log('[CrashAnalyticsService] CrashAnalyticsService');
  }

  Future setUser({@required String userId}) {
    return FirebaseCrashlytics.instance.setUserIdentifier(userId);
  }
}
