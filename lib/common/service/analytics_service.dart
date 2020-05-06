import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/foundation.dart';

class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics();

  FirebaseAnalyticsObserver getAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  Future setUser({@required String userId}) async {
    await _analytics.setUserId(userId);
  }

  Future logLogin() async {
    return await _analytics.logLogin(loginMethod: 'email');
  }

  Future logSignUp() async {
    return await _analytics.logSignUp(signUpMethod: 'email');
  }

  Future logLogout() async {
    return await _analytics
        .logEvent(name: "logout", parameters: {'logout_method': 'email'});
  }

  Future logFeedAdded({String userId, String feedId}) async {
    return await _analytics.logEvent(
      name: 'feed',
      parameters: {'user_id': userId, 'feed_id': feedId, 'action': 'added'},
    );
  }

  Future logFeedRemoved({String userId, String feedId}) async {
    return await _analytics.logEvent(
      name: 'feed',
      parameters: {'user_id': userId, 'feed_id': feedId, 'action': 'removed'},
    );
  }

  Future logFeedBookmarkAdded({String userId, String feedId}) async {
    return await _analytics.logEvent(
      name: 'bookmarked_feed',
      parameters: {'user_id': userId, 'feed_id': feedId, 'action': 'added'},
    );
  }

  Future logFeedActivityAdded(
      {String userId, String feedId, String event}) async {
    return await _analytics.logEvent(
      name: 'feed_activity',
      parameters: {
        'user_id': userId,
        'feed_id': feedId,
        'event': event,
        'action': 'added'
      },
    );
  }

  Future logFeedActivityRemoved(
      {String userId, String feedId, String event}) async {
    return await _analytics.logEvent(
      name: 'feed_activity',
      parameters: {
        'user_id': userId,
        'feed_id': feedId,
        'event': event,
        'action': 'removed'
      },
    );
  }

  Future logFeedActivityFetched(
      {String userId, String event}) async {
    return await _analytics.logEvent(
      name: 'feed_activity',
      parameters: {
        'user_id': userId,
        'event': event,
        'action': 'fetched'
      },
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
