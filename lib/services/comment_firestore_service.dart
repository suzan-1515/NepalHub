import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:samachar_hub/data/api/response/comments_firestore_response.dart';

class CommentFirestoreService {
  final CollectionReference _commentCollectionReference =
      Firestore.instance.collection('comments');

  Future<void> saveComment(
      {@required String commentId,
      @required Map<String, dynamic> metaActivityData,
      @required Map<String, dynamic> metaData,
      @required Map<String, dynamic> commentData,
      @required DocumentReference metaActivityDocumentRef,
      @required DocumentReference metaDocumentRef}) async {
    var batch = Firestore.instance.batch();
    batch.setData(_commentCollectionReference.document(commentId), commentData,
        merge: true);
    batch.setData(metaActivityDocumentRef, metaActivityData, merge: true);
    batch.setData(metaDocumentRef, metaData, merge: true);
    return batch.commit();
  }

  Future<void> addCommentLike({
    @required String commentId,
    @required String userId,
  }) async {
    return Firestore.instance.runTransaction((transaction) async {
      return await transaction
          .get(_commentCollectionReference.document(commentId))
          .then((value) {
        if (value.exists) {
          final List<String> likedUsers = value.data['liked_users'];
          likedUsers.add(userId);
          final data = {
            'liked_users': likedUsers,
            'like_count': FieldValue.increment(1),
          };
          transaction.update(
              _commentCollectionReference.document(commentId), data);
        }
      });
    });
  }

  Future<void> removeCommentLike({
    @required String commentId,
    @required String userId,
  }) async {
    return Firestore.instance.runTransaction((transaction) async {
      return await transaction
          .get(_commentCollectionReference.document(commentId))
          .then((value) {
        if (value.exists) {
          final List<String> likedUsers = value.data['liked_users'];
          likedUsers.remove(userId);
          final data = {
            'liked_users': likedUsers,
            'like_count': FieldValue.increment(-1),
          };
          int likeCount = value.data['like_count'];
          if (likeCount < 0) data['like_count'] = 0;
          transaction.update(
              _commentCollectionReference.document(commentId), data);
        }
      });
    });
  }

  Future<void> removeComment({
    @required String commentId,
    @required DocumentReference metaDocumentRef,
    @required DocumentReference metaActivityDocumentRef,
    @required Map<String, dynamic> metaData,
  }) async {
    return Firestore.instance.runTransaction((transaction) async {
      return await transaction
          .get(_commentCollectionReference.document(commentId))
          .then((value) {
        if (value.exists) {
          transaction.delete(metaActivityDocumentRef);
          transaction.update(metaDocumentRef, metaData);
          transaction.delete(_commentCollectionReference.document(commentId));
        }
      });
    });
  }

  Future<bool> doesCommentExist({@required String commentId}) async {
    return await _commentCollectionReference
        .document(commentId)
        .get()
        .then((onValue) => onValue.exists);
  }

  Stream<List<CommentFirestoreResponse>> fetchCommentsAsStream(
      {@required String postId, @required int limit}) {
    var pageQuery = _commentCollectionReference
        .orderBy('timestamp', descending: true)
        .where('post_id', isEqualTo: postId)
        .limit(limit);

    return pageQuery.snapshots().map((value) {
      return value.documents
          .where((snapshot) => snapshot != null && snapshot.exists)
          .map((snapshot) => CommentFirestoreResponse.fromJson(snapshot.data))
          .toList();
    });
  }

  Future<List<CommentFirestoreResponse>> fetchComments(
      {@required String postId, @required int limit, String after}) {
    var pageQuery = _commentCollectionReference
        .orderBy('timestamp', descending: true)
        .where('post_id', isEqualTo: postId)
        .limit(limit);

    if (after != null) {
      pageQuery = pageQuery.startAfter([after]);
    }

    return pageQuery.getDocuments().then((value) {
      return value.documents
          .where((snapshot) => snapshot != null && snapshot.exists)
          .map((snapshot) => CommentFirestoreResponse.fromJson(snapshot.data))
          .toList();
    });
  }
}
