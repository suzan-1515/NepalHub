import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:samachar_hub/common/service/services.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/dto/feed_dto.dart';
import 'package:samachar_hub/data/feed_activity_event.dart';
import 'package:samachar_hub/data/mapper/feed_mapper.dart';

import 'managers.dart';

abstract class FeedActivityManager {
  final AuthenticationManager _authenticationManager;
  final FeedActivityService _activityService;
  final AnalyticsService _analyticsService;
  final FeedActivityEvent _feedActivityEvent;

  FeedActivityManager(this._authenticationManager, this._analyticsService,
      this._activityService, this._feedActivityEvent);

  static const int DATA_LIMIT = 20;

  resetLastFetchedDocument() => _activityService.resetLastFetchedDocument();

  String generateActivityId(String feedId,String userId, String activityType) =>
      '$userId:$feedId:$activityType';

  Future<void> addFeedActivity({@required feedId, @required feedData}) async {
    var activityId = generateActivityId(
      feedId,
        _authenticationManager.currentUser.uId, _feedActivityEvent.asString());
    return doesActivityExist(feedId: feedId).then((onValue) {
      if (onValue) {
        return null;
      }
      feedData['user_id'] = _authenticationManager.currentUser.uId;
      feedData['event'] = _feedActivityEvent.asString();
      feedData['timestamp'] = FieldValue.serverTimestamp();
      return _activityService
          .addActivity(activityId: activityId, data: feedData)
          .then((value) {
        return _analyticsService.logFeedActivityAdded(
            userId: _authenticationManager.currentUser.uId,
            feedId: feedId,
            event: _feedActivityEvent.asString());
      });
    });
  }

  Future<void> removeFeedActivity({@required feedId}) async {
    return await _activityService
        .removeActivity(
            activityId: generateActivityId(
              feedId,
                _authenticationManager.currentUser.uId,
                _feedActivityEvent.asString()))
        .then((onValue) {
      return _analyticsService.logFeedActivityRemoved(
          userId: _authenticationManager.currentUser.uId,
          feedId: feedId,
          event: _feedActivityEvent.asString());
    });
  }

  Future<bool> doesActivityExist({@required feedId}) async {
    return await _activityService.doesActivityExist(
        activityId: generateActivityId(feedId,_authenticationManager.currentUser.uId,
            _feedActivityEvent.asString()));
  }

  Stream<List<Feed>> fetchFeedActivitiesAsStream() {
    return _activityService
        .fetchActivitiesAsStream(
            userId: _authenticationManager.currentUser.uId,
            event: _feedActivityEvent.asString(),
            limit: DATA_LIMIT)
        .where((snapshot) => snapshot != null)
        .map((snapshot) => snapshot.documents
            .where((snapshot) => snapshot != null && snapshot.exists)
            .map((snapshot) => FeedFirestoreResponse.fromJson(snapshot.data))
            .map((feed)=>FeedMapper.fromFeedFirestore(feed))
            .toList());
  }

  Future<List<Feed>> fetchFeedActivity() async {
    return _activityService
        .fetchActivity(
            userId: _authenticationManager.currentUser.uId,
            event: _feedActivityEvent.asString(),
            limit: DATA_LIMIT)
        .then((onValue) {
      if (onValue != null &&
          onValue.documents != null &&
          onValue.documents.isNotEmpty) {
        return onValue.documents
            .where((snapshot) => snapshot != null && snapshot.exists)
            .map((snapshot) => FeedFirestoreResponse.fromJson(snapshot.data))
            .map((feed)=>FeedMapper.fromFeedFirestore(feed))
            .toList();
      }
      return List<Feed>();
    }).then((onValue) {
      _analyticsService.logFeedActivityFetched(
          userId: _authenticationManager.currentUser.uId,
          event: _feedActivityEvent.asString());
      return onValue;
    });
  }
}
