import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/foundation.dart';

class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics();

  FirebaseAnalyticsObserver getAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  Future setUserProperties({@required String userId, String userRole}) async {
    await _analytics.setUserId(userId);
    await _analytics.setUserProperty(name: 'user_role', value: userRole);
  }

  Future logLogin() async {
    return await _analytics.logLogin(loginMethod: 'email');
  }

  Future logSignUp() async {
    return await _analytics.logSignUp(signUpMethod: 'email');
  }

  Future logFeedBookmarkAdded({String userId, String feedId}) async {
    return await _analytics.logEvent(
      name: 'bookmarked_feed',
      parameters: {'user_id': userId, 'feed_id': feedId, 'action': 'added'},
    );
  }

  Future logFeedBookmarkRemoved({String userId, String feedId}) async {
    return await _analytics.logEvent(
      name: 'bookmarked_feed',
      parameters: {'user_id': userId, 'feed_id': feedId, 'action': 'removed'},
    );
  }

  Future logFeedBookmarkFetched({String userId, String page}) async =>
      await _analytics.logEvent(
        name: 'bookmarked_feed',
        parameters: {'user_id': userId, 'feed_page': page, 'action': 'fetched'},
      );

  Future logLikedFeed({String userId, String feedId}) async {
    await _analytics.logEvent(
      name: 'liked_feed',
      parameters: {'user_id': userId, 'feed_id': feedId},
    );
  }

  Future logCommentedFeed({String userId, String feedId}) async {
    await _analytics.logEvent(
      name: 'commented_feed',
      parameters: {'user_id': userId, 'feed_id': feedId},
    );
  }

  Future logSharedFeed({String userId, String feedId}) async {
    await _analytics.logEvent(
      name: 'shared_feed',
      parameters: {'user_id': userId, 'feed_id': feedId},
    );
  }
}
