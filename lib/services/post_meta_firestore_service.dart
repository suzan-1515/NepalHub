import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostMetaFirestoreService {
  final CollectionReference _metaCollectionReference =
      Firestore.instance.collection('posts_meta');

  CollectionReference get metaCollectionReference => _metaCollectionReference;
  CollectionReference metaActivityCollectionReference(String postId) =>
      _metaCollectionReference.document(postId).collection('meta_activities');

  Future<void> addMeta(
      {@required String postId,
      @required Map<String, dynamic> metaData,
      @required String activityId,
      @required Map<String, dynamic> activityData}) async {
    var batch = Firestore.instance.batch();
    batch.setData(metaActivityCollectionReference(postId).document(activityId),
        activityData,
        merge: true);
    batch.setData(_metaCollectionReference.document(postId), metaData,
        merge: true);
    return batch.commit();
  }

  Future<void> removeMeta({
    @required String postId,
    @required Map<String, dynamic> metaData,
    @required String activityId,
  }) async {
    var batch = Firestore.instance.batch();
    batch.delete(metaActivityCollectionReference(postId).document(activityId));
    batch.setData(_metaCollectionReference.document(postId), metaData,
        merge: true);
    return batch.commit();
  }

  Future<DocumentSnapshot> fetchMeta({@required String postId}) {
    return _metaCollectionReference.document(postId).get();
  }

  Stream<DocumentSnapshot> fetchMetaAsStream({@required String postId}) {
    return _metaCollectionReference.document(postId).snapshots();
  }
}
