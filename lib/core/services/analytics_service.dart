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

  Future logLogin({String method = 'google'}) async {
    return await _analytics.logLogin(loginMethod: method);
  }

  Future logSignUp({String method = 'google'}) async {
    return await _analytics.logSignUp(signUpMethod: method);
  }

  Future logLogout({String method = 'google'}) async {
    return await _analytics
        .logEvent(name: "logout", parameters: {'logout_method': method});
  }

  Future logLike({@required String postId, @required String postType}) async {
    return await _analytics.logEvent(
      name: 'like',
      parameters: {'thread_id': postId, 'thread_type': postType},
    );
  }

  Future logUnLike({@required String postId, @required String postType}) async {
    return await _analytics.logEvent(
      name: 'unlike',
      parameters: {'thread_id': postId, 'thread_type': postType},
    );
  }

  Future logView({@required String postId, @required String postType}) async {
    return await _analytics.logEvent(
      name: 'view',
      parameters: {'thread_id': postId, 'thread_type': postType},
    );
  }

  Future logBookmark(
      {@required String postId, String threadType = 'news_feed'}) async {
    return await _analytics.logEvent(
      name: 'bookmark',
      parameters: {'thread_id': postId, 'thread_type': threadType},
    );
  }

  Future logUnBookmark(
      {@required String postId, String threadType = 'news_feed'}) async {
    return await _analytics.logEvent(
      name: 'unbookmark',
      parameters: {'thread_id': postId, 'thread_type': threadType},
    );
  }

  Future logCommentPost(
      {@required String threadId, @required String threadType}) async {
    await _analytics.logEvent(
      name: 'comment_post',
      parameters: {'thread_id': threadId, 'thread_type': threadType},
    );
  }

  Future logCommentLike(
      {@required String threadId, @required String threadType}) async {
    await _analytics.logEvent(
      name: 'comment_like',
      parameters: {'thread_id': threadId, 'thread_type': threadType},
    );
  }

  Future logCommentUnlike(
      {@required String threadId, @required String threadType}) async {
    await _analytics.logEvent(
      name: 'comment_unlike',
      parameters: {'thread_id': threadId, 'thread_type': threadType},
    );
  }

  Future logNewsSourceFollow({@required String sourceCode}) async {
    await _analytics.logEvent(
      name: 'news_source_follow',
      parameters: {'source_code': sourceCode},
    );
  }

  Future logNewsSourceUnFollow({@required String sourceCode}) async {
    await _analytics.logEvent(
      name: 'news_source_unfollow',
      parameters: {'source_code': sourceCode},
    );
  }

  Future logNewsCategoryFollow({@required String categoryCode}) async {
    await _analytics.logEvent(
      name: 'news_category_follow',
      parameters: {'category_code': categoryCode},
    );
  }

  Future logNewsCategoryUnFollow({@required String categoryCode}) async {
    await _analytics.logEvent(
      name: 'news_category_unfollow',
      parameters: {'category_code': categoryCode},
    );
  }

  Future logNewsTopicFollow({@required String topic}) async {
    await _analytics.logEvent(
      name: 'news_topic_follow',
      parameters: {'topic': topic},
    );
  }

  Future logNewsTopicUnFollow({@required String topic}) async {
    await _analytics.logEvent(
      name: 'news_topic_unfollow',
      parameters: {'topic': topic},
    );
  }

  Future logNewsReadMode({@required String mode}) async {
    await _analytics.logEvent(
      name: 'news_read_mode_$mode',
    );
  }

  Future logNewsDailyMorningNotificatoon({@required bool notify}) async {
    await _analytics.logEvent(
        name: 'news_morning_notification', parameters: {'notify': notify});
  }

  Future logNewsNotificatoon({@required bool notify}) async {
    await _analytics
        .logEvent(name: 'news_notification', parameters: {'notify': notify});
  }

  Future logHoroscopeDailyMorningNotificatoon({@required bool notify}) async {
    await _analytics.logEvent(
        name: 'horoscope_morning_notification', parameters: {'notify': notify});
  }

  Future logTrendingNotificatoon({@required bool notify}) async {
    await _analytics.logEvent(
        name: 'trending_notification', parameters: {'notify': notify});
  }

  Future logCommentNotificatoon({@required bool notify}) async {
    await _analytics
        .logEvent(name: 'comment_notification', parameters: {'notify': notify});
  }

  Future logMessageNotificatoon({@required bool notify}) async {
    await _analytics
        .logEvent(name: 'message_notification', parameters: {'notify': notify});
  }

  Future logOtherNotificatoon({@required bool notify}) async {
    await _analytics
        .logEvent(name: 'other_notification', parameters: {'notify': notify});
  }

  Future logShare(
      {String postId, String method, String contentType = 'feed'}) async {
    await _analytics.logShare(
      contentType: contentType,
      itemId: postId,
      method: method,
    );
  }
}
