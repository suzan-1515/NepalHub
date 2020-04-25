import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:samachar_hub/data/model/feed.dart';
import 'package:samachar_hub/service/analytics_service.dart';
import 'package:samachar_hub/service/authentication_service.dart';
import 'package:samachar_hub/service/bookmark_service.dart';

class BookmarkManager {
  final AuthenticationService _authenticationService;
  final BookmarkService _bookmarkService;
  final AnalyticsService _analyticsService;

  BookmarkManager(this._authenticationService, this._bookmarkService,
      this._analyticsService);

  static const int DATA_LIMIT = 20;

  Future<void> addBookmarkedFeed({@required id, @required data}) async {
    data['timestamp'] = FieldValue.serverTimestamp();
    data['user_id'] = _authenticationService.currentUser.uid;
    return await _bookmarkService
        .addBookmarkedFeed(id: id, data: data)
        .then((onValue) {
      _analyticsService.logFeedBookmarkAdded(
          userId: _authenticationService.currentUser.uid, feedId: id);
    });
  }

  Future<void> removeBookmarkedFeed({@required feedId}) async {
    return await _bookmarkService
        .removeBookmarkedFeed(feedId: feedId)
        .then((onValue) {
      _analyticsService.logFeedBookmarkRemoved(
          userId: _authenticationService.currentUser.uid, feedId: feedId);
    });
  }

  Stream<List<Feed>> fetchBookmarksAsStream() {
    return _bookmarkService
        .fetchBookmarksAsStream(
            userId: _authenticationService.currentUser.uid, limit: DATA_LIMIT)
        .where((snapshot) => snapshot != null && snapshot.documents.isNotEmpty)
        .map((snapshot) => snapshot.documents
            .where((snapshot) => snapshot != null && snapshot.exists)
            .map((snapshot) => Feed.fromSnapshot(snapshot.data))
            .toList());
  }

  Future<List<Feed>> fetchBookmarks({resetPage}) async {
    return _bookmarkService
        .fetchBookmarks(
            userId: _authenticationService.currentUser.uid,
            limit: DATA_LIMIT,
            resetPage: resetPage)
        .then((onValue) {
      if (onValue != null &&
          onValue.documents != null &&
          onValue.documents.isNotEmpty) {
        return onValue.documents
            .where((snapshot) => snapshot != null && snapshot.exists)
            .map((snapshot) => Feed.fromSnapshot(snapshot.data))
            .toList();
      }
      return [];
    });
  }
}
