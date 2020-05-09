import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NewsFirestoreService {
  final CollectionReference _feedCollectionReference =
      Firestore.instance.collection('feeds_meta');

  CollectionReference get feedCollectionReference => _feedCollectionReference;

  DocumentSnapshot _lastDocument;
  DocumentSnapshot get lastFetchedDocument => _lastDocument;
  void resetLastFetchedDocument() => _lastDocument = null;

  Future<void> addFeed({@required feedId, @required data}) async {
    return Firestore.instance.runTransaction((Transaction t) async {
      await t
          .get(feedCollectionReference.document(feedId))
          .then((onValue) async {
        if (!onValue.exists) {
          await t.set(feedCollectionReference.document(feedId), data);
        }
      });
    });
  }

  Future<void> removeFeed({@required feedId}) async {
    return await _feedCollectionReference.document(feedId).delete();
  }

  Future<bool> doesFeedExist(
      {@required feedId, Source source = Source.serverAndCache}) async {
    return await _feedCollectionReference
        .document(feedId)
        .get(source: source)
        .then((onValue) => onValue.exists);
  }

  Stream<QuerySnapshot> fetchFeedsAsStream({@required int limit}) {
    var pageQuery = _feedCollectionReference
        .orderBy('timestamp', descending: true)
        .limit(limit);

    return pageQuery.snapshots().map((onValue) {
      if (onValue != null &&
          onValue.documents != null &&
          onValue.documents.isNotEmpty) _lastDocument = onValue.documents.last;
      return onValue;
    });
  }

  Future<QuerySnapshot> fetchFeeds({@required int limit}) {
    var pageQuery = _feedCollectionReference
        .orderBy('timestamp', descending: true)
        .limit(limit);

    if (_lastDocument != null) {
      pageQuery = pageQuery.startAfterDocument(_lastDocument);
    }

    return pageQuery.getDocuments().then((onValue) {
      if (onValue != null &&
          onValue.documents != null &&
          onValue.documents.isNotEmpty) _lastDocument = onValue.documents.last;
      return onValue;
    });
  }
}
