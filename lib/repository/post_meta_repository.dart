import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:samachar_hub/data/models/post_meta_model.dart';
import 'package:samachar_hub/services/services.dart';

class PostMetaRepository {
  final PostMetaFirestoreService _postMetaService;
  final AnalyticsService _analyticsService;
  final PreferenceService _preferenceService;

  PostMetaRepository(
      this._postMetaService, this._analyticsService, this._preferenceService);

  CollectionReference get metaCollectionReference =>
      _postMetaService.metaCollectionReference;
  CollectionReference metaActivityCollectionReference(String postId) =>
      _postMetaService.metaActivityCollectionReference(postId);

  String generateActivityId(String postId, String userId, String metaName) =>
      '$postId:$userId:$metaName';

  Future<void> postLike(
      {@required String postId, @required String userId}) async {
    var metaData = {
      'like_count': FieldValue.increment(1),
    };
    var activityId = generateActivityId(postId, userId, 'like');
    var metaActivityData = {
      'id': activityId,
      'meta_name': 'like',
      'post_id': postId,
      'user_id': userId,
      'timestamp': FieldValue.serverTimestamp(),
    };
    return _postMetaService
        .addMeta(
            postId: postId,
            metaData: metaData,
            activityId: activityId,
            activityData: metaActivityData)
        .then((onValue) {
      var likes = _preferenceService.likedFeeds;
      likes.add(postId);
      _preferenceService.likedFeeds = likes;
      return _analyticsService.logPostMeta(postId: postId, metaName: 'like');
    });
  }

  Future<void> removeLike({@required String postId, @required String userId}) {
    var activityId = generateActivityId(postId, userId, 'like');
    var metaData = {
      'like_count': FieldValue.increment(-1),
    };
    return _postMetaService
        .removeMeta(postId: postId, metaData: metaData, activityId: activityId)
        .then((value) {
      var likes = _preferenceService.likedFeeds;
      likes.remove(postId);
      _preferenceService.likedFeeds = likes;
    });
  }

  Future<void> postComment(
      {@required String postId, @required String userId}) async {
    var metaData = {
      'comment_count': FieldValue.increment(1),
    };
    var activityId = generateActivityId(postId, userId, 'comment');
    var metaActivityData = {
      'id': activityId,
      'meta_name': 'comment',
      'post_id': postId,
      'user_id': userId,
      'timestamp': FieldValue.serverTimestamp(),
    };
    return _postMetaService
        .addMeta(
            postId: postId,
            metaData: metaData,
            activityId: activityId,
            activityData: metaActivityData)
        .then((onValue) {
      return _analyticsService.logPostMeta(postId: postId, metaName: 'comment');
    });
  }

  Future<void> postView({@required postId, @required String userId}) async {
    var metaData = {
      'view_count': FieldValue.increment(1),
    };
    var activityId = generateActivityId(postId, userId, 'view');
    var metaActivityData = {
      'id': activityId,
      'meta_name': 'view',
      'post_id': postId,
      'user_id': userId,
      'timestamp': FieldValue.serverTimestamp(),
    };
    return _postMetaService
        .addMeta(
            postId: postId,
            metaData: metaData,
            activityId: activityId,
            activityData: metaActivityData)
        .then((onValue) {
      return _analyticsService.logPostMeta(postId: postId, metaName: 'view');
    });
  }

  Future<void> postShare({@required postId, @required String userId}) async {
    var metaData = {
      'share_count': FieldValue.increment(1),
    };
    var activityId = generateActivityId(postId, userId, 'share');
    var metaActivityData = {
      'id': activityId,
      'meta_name': 'share',
      'post_id': postId,
      'user_id': userId,
      'timestamp': FieldValue.serverTimestamp(),
    };
    return _postMetaService
        .addMeta(
            postId: postId,
            metaData: metaData,
            activityId: activityId,
            activityData: metaActivityData)
        .then((onValue) {
      return _analyticsService.logPostMeta(postId: postId, metaName: 'share');
    });
  }

  Future<PostMetaModel> getMeta({@required String postId}) async {
    return _postMetaService.fetchMeta(postId: postId).then((onValue) {
      if (onValue.exists) {
        onValue.data['post_id'] = onValue.documentID;
        return PostMetaModel.fromJson(onValue.data);
      }
      return null;
    });
  }

  Stream<PostMetaModel> getMetaAsStream({@required String postId}) {
    return _postMetaService.fetchMetaAsStream(postId: postId).map((onValue) {
      if (onValue.exists) {
        onValue.data['post_id'] = onValue.documentID;
        return PostMetaModel.fromJson(onValue.data);
      }
      return null;
    });
  }
}
