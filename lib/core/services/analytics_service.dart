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

  Future logLogout() async {
    return await _analytics.logEvent(name: "logout");
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

  Future logCommentPost({@required String commentId}) async {
    await _analytics.logEvent(
      name: 'comment_post',
      parameters: {'id': commentId},
    );
  }

  Future logCommentUpdate({@required String commentId}) async {
    await _analytics.logEvent(
      name: 'comment_update',
      parameters: {'id': commentId},
    );
  }

  Future logCommentLike({@required String commentId}) async {
    await _analytics.logEvent(
      name: 'comment_like',
      parameters: {'id': commentId},
    );
  }

  Future logCommentUnlike({@required String commentId}) async {
    await _analytics.logEvent(
      name: 'comment_unlike',
      parameters: {'id': commentId},
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

  Future logNewsTopicUnFollow({@required String topic}) {
    return _analytics.logEvent(
      name: 'news_topic_unfollow',
      parameters: {'topic': topic},
    );
  }

  Future logNewsReadMode({@required String mode}) {
    return _analytics
        .logEvent(name: 'news_read_mode', parameters: {'mode': mode});
  }

  Future logNewsDailyMorningNotificatoon({@required bool notify}) {
    return _analytics.logEvent(
        name: 'news_morning_notification', parameters: {'enable': notify});
  }

  Future logNewsNotificatoon({@required bool notify}) {
    return _analytics
        .logEvent(name: 'news_notification', parameters: {'enable': notify});
  }

  Future logHoroscopeDailyMorningNotificatoon({@required bool notify}) {
    return _analytics.logEvent(
        name: 'horoscope_morning_notification', parameters: {'enable': notify});
  }

  Future logTrendingNotificatoon({@required bool notify}) {
    return _analytics.logEvent(
        name: 'trending_notification', parameters: {'enable': notify});
  }

  Future logCommentNotification({@required bool notify}) {
    return _analytics
        .logEvent(name: 'comment_notification', parameters: {'enable': notify});
  }

  Future logMessageNotification({@required bool notify}) {
    return _analytics
        .logEvent(name: 'message_notification', parameters: {'enable': notify});
  }

  Future logOtherNotificatoon({@required bool notify}) {
    return _analytics
        .logEvent(name: 'other_notification', parameters: {'enable': notify});
  }

  Future logShare({String postId, String method, String contentType = 'feed'}) {
    return _analytics.logShare(
      contentType: contentType,
      itemId: postId,
      method: method,
    );
  }

  Future logDarkMode({@required bool enable}) {
    return _analytics
        .logEvent(name: 'dark_mode', parameters: {'enable': enable});
  }

  Future logDefaultHoroscopeSign({@required int signIndex}) {
    return _analytics.logEvent(
        name: 'default_horoscope_sign', parameters: {'sign_index': signIndex});
  }

  Future logUseSystemTheme({@required bool value}) {
    return _analytics
        .logEvent(name: 'system_theme', parameters: {'enable': value});
  }

  Future logPitchBlackMode({@required bool value}) {
    return _analytics
        .logEvent(name: 'pitch_black_mode', parameters: {'enable': value});
  }

  Future logCommentDelete({@required String commentId}) {
    return _analytics
        .logEvent(name: 'comment_delete', parameters: {'id': commentId});
  }

// Forex
  Future logForexView({@required String forexId}) {
    return _analytics.logEvent(name: 'forex_view', parameters: {'id': forexId});
  }

  Future logForexUnlike({@required String forexId}) {
    return _analytics
        .logEvent(name: 'forex_unlike', parameters: {'id': forexId});
  }

  Future logForexShare({@required String forexId}) {
    return _analytics
        .logEvent(name: 'forex_share', parameters: {'id': forexId});
  }

  Future logForexLike({@required String forexId}) {
    return _analytics.logEvent(name: 'forex_like', parameters: {'id': forexId});
  }

  Future logDefaultForexCurrency({@required String currencyId}) {
    return _analytics.logEvent(
        name: 'default_forex_currency',
        parameters: {'currency_id': currencyId});
  }
}
