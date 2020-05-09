import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

abstract class NewsFirestoreActivityService {
  final CollectionReference _activityCollectionReference =
      Firestore.instance.collection('feed_activities');

  DocumentSnapshot _lastDocument;

  DocumentSnapshot get lastFetchedDocument => _lastDocument;
  void resetLastFetchedDocument() => _lastDocument = null;

  Future addActivity({@required activityId, @required data}) async {
    return _activityCollectionReference
        .document(activityId)
        .setData(data, merge: true);
  }

  Future<void> removeActivity({@required activityId}) async {
    return await _activityCollectionReference.document(activityId).delete();
  }

  Future<bool> doesActivityExist({@required activityId}) async {
    return await _activityCollectionReference
        .document(activityId)
        .get()
        .then((onValue) => onValue.exists);
  }

  Stream<QuerySnapshot> fetchActivitiesAsStream(
      {@required userId, @required event, @required int limit}) {
    var pageQuery = _activityCollectionReference
        .where('user_id', isEqualTo: userId)
        .where('event', isEqualTo: event)
        .orderBy('timestamp', descending: true)
        .limit(limit);

    return pageQuery.snapshots().map((onValue) {
      if (onValue != null &&
          onValue.documents != null &&
          onValue.documents.isNotEmpty) _lastDocument = onValue.documents.last;
      return onValue;
    });
  }

  Future<QuerySnapshot> fetchActivity(
      {@required userId, @required event, @required int limit}) {
    var pageQuery = _activityCollectionReference
        .where('user_id', isEqualTo: userId)
        .where('event', isEqualTo: event)
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
