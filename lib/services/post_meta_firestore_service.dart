import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:samachar_hub/data/api/response/post_meta_firestore_response.dart';

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
    return metaActivityCollectionReference(postId)
        .document(activityId)
        .get()
        .then((value) {
      if (!value.exists) {
        var batch = Firestore.instance.batch();
        batch.setData(
            metaActivityCollectionReference(postId).document(activityId),
            activityData,
            merge: true);
        batch.setData(_metaCollectionReference.document(postId), metaData,
            merge: true);
        batch.commit();
      }
    });
  }

  Future<void> removeMeta({
    @required String postId,
    @required Map<String, dynamic> metaData,
    @required String activityId,
  }) async {
    return metaActivityCollectionReference(postId)
        .document(activityId)
        .get()
        .then((value) {
      if (value.exists) {
        var batch = Firestore.instance.batch();
        batch.delete(
            metaActivityCollectionReference(postId).document(activityId));
        batch.updateData(_metaCollectionReference.document(postId), metaData);
        batch.commit();
      }
    });
  }

  Future<List<PostMetaActivityFirestoreResponse>> fetchMetaActivities(
      {@required String postId, @required String userId}) {
    return metaActivityCollectionReference(postId)
        .where('user_id', isEqualTo: userId)
        .getDocuments()
        .then((value) {
      return value.documents
          .where((e) => e.exists)
          .map((e) => PostMetaActivityFirestoreResponse.fromJson(e.data))
          .toList();
    });
  }

  Future<PostMetaFirestoreResponse> fetchMeta({@required String postId}) {
    return _metaCollectionReference.document(postId).get().then((value) {
      if (!value.exists) return null;
      value.data['post_id'] = value.documentID;
      return PostMetaFirestoreResponse.fromJson(value.data);
    });
  }

  Stream<PostMetaFirestoreResponse> fetchMetaAsStream(
      {@required String postId}) {
    return _metaCollectionReference
        .document(postId)
        .snapshots()
        .where((event) => event.exists)
        .map((event) {
      event.data['post_id'] = event.documentID;
      return PostMetaFirestoreResponse.fromJson(event.data);
    });
  }
}
