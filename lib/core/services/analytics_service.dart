import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/foundation.dart';

class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics();

  FirebaseAnalyticsObserver getAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: _analytics);

//User
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

//Comment
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

//News
  Future logNewsSourceFollow({@required String sourceId}) async {
    await _analytics.logEvent(
      name: 'news_source_follow',
      parameters: {'id': sourceId},
    );
  }

  Future logNewsSourceUnFollow({@required String sourceId}) async {
    await _analytics.logEvent(
      name: 'news_source_unfollow',
      parameters: {'id': sourceId},
    );
  }

  Future logNewsCategoryFollow({@required String categoryId}) async {
    await _analytics.logEvent(
      name: 'news_category_follow',
      parameters: {'id': categoryId},
    );
  }

  Future logNewsCategoryUnFollow({@required String categoryId}) async {
    await _analytics.logEvent(
      name: 'news_category_unfollow',
      parameters: {'id': categoryId},
    );
  }

  Future logNewsTopicFollow({@required String topicId}) async {
    await _analytics.logEvent(
      name: 'news_topic_follow',
      parameters: {'id': topicId},
    );
  }

  Future logNewsTopicUnFollow({@required String topicId}) {
    return _analytics.logEvent(
      name: 'news_topic_unfollow',
      parameters: {'id': topicId},
    );
  }

  Future logNewsDislike({@required String feedId}) {
    return _analytics
        .logEvent(name: 'news_dislike', parameters: {'id': feedId});
  }

  Future logNewsLike({@required String feedId}) {
    return _analytics.logEvent(name: 'news_like', parameters: {'id': feedId});
  }

  Future logNewsShare({@required String feedId}) {
    return _analytics.logEvent(name: 'news_share', parameters: {'id': feedId});
  }

  Future logNewsUndislike({@required String feedId}) {
    return _analytics
        .logEvent(name: 'news_undislike', parameters: {'id': feedId});
  }

  Future logNewsUnlike({@required String feedId}) {
    return _analytics.logEvent(name: 'news_unlike', parameters: {'id': feedId});
  }

  Future logNewsView({@required String feedId}) {
    return _analytics.logEvent(name: 'news_view', parameters: {'id': feedId});
  }

  Future logNewsBookmark({@required String feedId}) async {
    return await _analytics.logEvent(
      name: 'news_bookmark',
      parameters: {'id': feedId},
    );
  }

  Future logNewsUnBookmark({@required String feedId}) async {
    return await _analytics.logEvent(
      name: 'news_unbookmark',
      parameters: {'id': feedId},
    );
  }

  // Settings
  Future logNewsReadMode({@required int mode}) {
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

  Future logForexDisLike({@required String forexId}) {
    return _analytics
        .logEvent(name: 'forex_dislike', parameters: {'id': forexId});
  }

  Future logForexUndisLike({@required String forexId}) {
    return _analytics
        .logEvent(name: 'forex_undislike', parameters: {'id': forexId});
  }

  Future logDefaultForexCurrency({@required String currencyId}) {
    return _analytics.logEvent(
        name: 'default_forex_currency',
        parameters: {'currency_id': currencyId});
  }

// Horoscope
  Future logHoroscopeUnlike({@required String horoscopeId}) {
    return _analytics
        .logEvent(name: 'horoscope_unlike', parameters: {'id': horoscopeId});
  }

  Future logHoroscopeView({@required String horoscopeId}) {
    return _analytics
        .logEvent(name: 'horoscope_view', parameters: {'id': horoscopeId});
  }

  Future logHoroscopeLike({@required String horoscopeId}) {
    return _analytics
        .logEvent(name: 'horoscope_like', parameters: {'id': horoscopeId});
  }

  Future logHoroscopeDisLike({@required String horoscopeId}) {
    return _analytics
        .logEvent(name: 'horoscope_dislike', parameters: {'id': horoscopeId});
  }

  Future logHoroscopeUndisLike({@required String horoscopeId}) {
    return _analytics
        .logEvent(name: 'horoscope_undislike', parameters: {'id': horoscopeId});
  }

  Future logDefaultHoroscopeSign({@required int signIndex}) {
    return _analytics.logEvent(
        name: 'default_horoscope_sign', parameters: {'sign_index': signIndex});
  }

  Future logHoroscopeShare({@required String horoscopeId}) {
    return _analytics
        .logEvent(name: 'horoscope_share', parameters: {'id': horoscopeId});
  }

  Future logReportPost({@required String reportId}) {
    return _analytics
        .logEvent(name: 'report_post', parameters: {'id': reportId});
  }
}
