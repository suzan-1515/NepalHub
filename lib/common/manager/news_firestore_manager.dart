import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:samachar_hub/common/service/services.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/dto/dto.dart';
import 'package:samachar_hub/data/mapper/news_mapper.dart';

import 'managers.dart';

class NewsFirestoreManager {
  final AuthenticationController _authenticationManager;
  final NewsFirestoreService _feedService;
  final AnalyticsService _analyticsService;

  NewsFirestoreManager(
      this._authenticationManager, this._feedService, this._analyticsService);

  static const int DATA_LIMIT = 20;

  CollectionReference get feedCollectionReference =>
      _feedService.feedCollectionReference;

  Future<void> addFeed({@required id, @required data}) async {
    return await doesFeedExist(feedId: id).then((onValue) {
      if (onValue) {
        return null;
      }
      data['meta'] = {
        'like_count': 0,
        'bookmark_count': 0,
        'share_count': 0,
        'comment_count': 0,
        'view_count': 0,
      };
      data['timestamp'] = FieldValue.serverTimestamp();
      return _feedService.addFeed(feedId: id, data: data).then((onValue) {
        return _analyticsService.logFeedAdded(
            userId: _authenticationManager.currentUser.uId, feedId: id);
      });
    });
  }

  Future<void> removeFeed({@required feedId}) async {
    return await _feedService.removeFeed(feedId: feedId).then((onValue) {
      _analyticsService.logFeedRemoved(
          userId: _authenticationManager.currentUser.uId, feedId: feedId);
    });
  }

  Future<bool> doesFeedExist({@required feedId}) async {
    return await _feedService.doesFeedExist(feedId: feedId);
  }

  Stream<List<Feed>> fetchFeedsAsStream() {
    return _feedService
        .fetchFeedsAsStream(limit: DATA_LIMIT)
        .where((snapshot) => snapshot != null && snapshot.documents.isNotEmpty)
        .map((snapshot) => snapshot.documents
            .where((snapshot) => snapshot != null && snapshot.exists)
            .map((snapshot) => FeedFirestoreResponse.fromJson(snapshot.data))
            .map((feed) => NewsMapper.fromFeedFirestore(feed))
            .toList());
  }

  Future<List<Feed>> fetchFeeds() async {
    return _feedService.fetchFeeds(limit: DATA_LIMIT).then((onValue) {
      if (onValue != null &&
          onValue.documents != null &&
          onValue.documents.isNotEmpty) {
        return onValue.documents
            .where((snapshot) => snapshot != null && snapshot.exists)
            .map((snapshot) => FeedFirestoreResponse.fromJson(snapshot.data))
            .map((feed) => NewsMapper.fromFeedFirestore(feed))
            .toList();
      }
      return List<Feed>();
    });
  }
}
