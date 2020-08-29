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

  Future logPostLike({@required String postId}) async {
    return await _analytics.logEvent(
      name: 'post_like',
      parameters: {'post_id': postId},
    );
  }

  Future logPostUnLike({@required String postId}) async {
    return await _analytics.logEvent(
      name: 'post_unlike',
      parameters: {'post_id': postId},
    );
  }

  Future logPostView({@required String postId}) async {
    return await _analytics.logEvent(
      name: 'post_view',
      parameters: {'post_id': postId},
    );
  }

  Future logPostShare({@required String postId}) async {
    return await _analytics.logEvent(
      name: 'post_share',
      parameters: {'post_id': postId},
    );
  }

  Future logPostComment({@required String postId}) async {
    return await _analytics.logEvent(
      name: 'post_comment',
      parameters: {'post_id': postId},
    );
  }

  Future logPostCommentDelete({@required String postId}) async {
    return await _analytics.logEvent(
      name: 'post_comment_delete',
      parameters: {'post_id': postId},
    );
  }

  Future logPostBookmark({@required String postId}) async {
    return await _analytics.logEvent(
      name: 'post_bookmark',
      parameters: {'post_id': postId},
    );
  }

  Future logPostBookmarkRemoved({@required String postId}) async {
    return await _analytics.logEvent(
      name: 'post_bookmark_removed',
      parameters: {'post_id': postId},
    );
  }

  Future logFeedBookmarkFetched({String page}) async =>
      await _analytics.logEvent(
        name: 'bookmark_fetched',
        parameters: {'page': page},
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

  Future logForexFetched({String currency}) async {
    await _analytics.logEvent(
      name: 'forex_fetched',
      parameters: {'currency_code': currency},
    );
  }

  Future logHoroscopeFetched() async {
    await _analytics.logEvent(
      name: 'horoscope_fetched',
    );
  }

  Future logNewsSourceFollowed({String sourceCode}) async {
    await _analytics.logEvent(
      name: 'news_source_followed',
      parameters: {'source_code': sourceCode},
    );
  }

  Future logNewsSourceUnFollowed({String sourceCode}) async {
    await _analytics.logEvent(
      name: 'news_source_unfollowed',
      parameters: {'source_code': sourceCode},
    );
  }

  Future logNewsCategoryFollowed({String sourceCode}) async {
    await _analytics.logEvent(
      name: 'news_category_followed',
      parameters: {'category_code': sourceCode},
    );
  }

  Future logNewsCategoryUnFollowed({String categoryCode}) async {
    await _analytics.logEvent(
      name: 'news_category_unfollowed',
      parameters: {'category_code': categoryCode},
    );
  }

  Future logNewsTopicFollowed({String topic}) async {
    await _analytics.logEvent(
      name: 'news_topic_followed',
      parameters: {'topic': topic},
    );
  }

  Future logNewsTopicUnFollowed({String topic}) async {
    await _analytics.logEvent(
      name: 'news_topic_unfollowed',
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
