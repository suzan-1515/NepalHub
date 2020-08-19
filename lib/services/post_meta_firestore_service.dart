import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:samachar_hub/data/api/response/post_meta_firestore_response.dart';

class PostMetaFirestoreService {
  final CollectionReference _metaCollectionReference =
      FirebaseFirestore.instance.collection('posts_meta');

  CollectionReference get metaCollectionReference => _metaCollectionReference;
  CollectionReference metaActivityCollectionReference(String postId) =>
      _metaCollectionReference.doc(postId).collection('meta_activities');

  Future<void> addMeta(
      {@required String postId,
      @required Map<String, dynamic> metaData,
      @required String activityId,
      @required Map<String, dynamic> activityData}) async {
    return metaActivityCollectionReference(postId)
        .doc(activityId)
        .get()
        .then((value) {
      if (!value.exists) {
        return FirebaseFirestore.instance.runTransaction((transaction) {
          return transaction
              .get(_metaCollectionReference.doc(postId))
              .then((value) {
            transaction.set(
                metaActivityCollectionReference(postId).doc(activityId),
                activityData,
                SetOptions(merge: true));
            transaction.set(_metaCollectionReference.doc(postId), metaData,
                SetOptions(merge: true));
          });
        });
      }
    });
  }

  Future<void> removeMeta({
    @required String postId,
    @required Map<String, dynamic> metaData,
    @required String activityId,
  }) async {
    return metaActivityCollectionReference(postId)
        .doc(activityId)
        .get()
        .then((value) {
      if (value.exists) {
        return FirebaseFirestore.instance.runTransaction((transaction) {
          return transaction
              .get(_metaCollectionReference.doc(postId))
              .then((value) {
            transaction.delete(
                metaActivityCollectionReference(postId).doc(activityId));
            transaction.update(_metaCollectionReference.doc(postId), metaData);
          });
        });
      }
    });
  }

  Future<List<PostMetaActivityFirestoreResponse>> fetchMetaActivities(
      {@required String postId, @required String userId}) {
    return metaActivityCollectionReference(postId)
        .where('user_id', isEqualTo: userId)
        .get()
        .then((value) {
      return value.docs
          .where((e) => e.exists)
          .map((e) => PostMetaActivityFirestoreResponse.fromJson(e.data()))
          .toList();
    });
  }

  Future<PostMetaFirestoreResponse> fetchMeta({@required String postId}) {
    return _metaCollectionReference.doc(postId).get().then((value) {
      if (!value.exists) return null;
      value.data()['post_id'] = value.id;
      return PostMetaFirestoreResponse.fromJson(value.data());
    });
  }

  Stream<PostMetaFirestoreResponse> fetchMetaAsStream(
      {@required String postId}) {
    return _metaCollectionReference
        .doc(postId)
        .snapshots()
        .where((event) => event.exists)
        .map((event) {
      event.data()['post_id'] = event.id;
      return PostMetaFirestoreResponse.fromJson(event.data());
    });
  }
}
