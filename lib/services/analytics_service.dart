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

  Future logPostMeta(
      {@required String postId, @required String metaName}) async {
    return await _analytics.logEvent(
      name: 'post_meta',
      parameters: {'post_id': postId, 'meta': metaName},
    );
  }

  Future logFeedBookmarkAdded({String feedId}) async {
    return await _analytics.logEvent(
      name: 'bookmarked_feed',
      parameters: {'feed_id': feedId, 'action': 'added'},
    );
  }

  Future logFeedBookmarkRemoved({String feedId}) async {
    return await _analytics.logEvent(
      name: 'bookmarked_feed',
      parameters: {'feed_id': feedId, 'action': 'removed'},
    );
  }

  Future logFeedBookmarkFetched({String page}) async =>
      await _analytics.logEvent(
        name: 'bookmarked_feed',
        parameters: {'feed_page': page, 'action': 'fetched'},
      );

  Future logCommentPosted({String postId}) async {
    await _analytics.logEvent(
      name: 'comment_posted',
      parameters: {'post_id': postId},
    );
  }

  Future logCommentFetched({String postId}) async {
    await _analytics.logEvent(
      name: 'comment_fetched',
      parameters: {'post_id': postId},
    );
  }

  Future logCommentLiked({String postId, String commentId}) async {
    await _analytics.logEvent(
      name: 'comment_liked',
      parameters: {'post_id': postId, 'comment_id': commentId},
    );
  }

   Future logCommentLikeRemoved({String postId, String commentId}) async {
    await _analytics.logEvent(
      name: 'comment_unlike',
      parameters: {'post_id': postId, 'comment_id': commentId},
    );
  }

  Future logShare({String postId}) async {
    await _analytics.logShare(
      contentType: 'feed',
      itemId: postId,
      method: 'open',
    );
  }
}
