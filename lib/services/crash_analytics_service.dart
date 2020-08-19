import 'dart:developer';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:samachar_hub/repository/repositories.dart';

class CrashAnalyticsService {
  final AuthenticationRepository _authenticationRepository;

  CrashAnalyticsService(this._authenticationRepository) {
    log('[CrashAnalyticsService] CrashAnalyticsService');
    _authenticationRepository.authStateChanges().listen((event) {
      if (event != null) Crashlytics.instance.setUserIdentifier(event.uid);
    });
  }
}
