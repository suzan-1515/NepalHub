import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:samachar_hub/data/api/api.dart';

class CommentFirestoreService {
  final CollectionReference _commentCollectionReference =
      FirebaseFirestore.instance.collection('comments');

  Future<void> saveComment(
      {@required String commentId,
      @required Map<String, dynamic> commentData}) async {
    return _commentCollectionReference
        .doc(commentId)
        .set(commentData, SetOptions(merge: true));
  }

  Future<void> addCommentLike({
    @required String commentId,
    @required String userId,
  }) async {
    return FirebaseFirestore.instance.runTransaction((transaction) {
      return transaction
          .get(_commentCollectionReference.doc(commentId))
          .then((value) {
        if (value.exists) {
          final List<String> likedUsers =
              value.data()['liked_users'].cast<String>();
          if (likedUsers.contains(userId)) return;
          likedUsers.add(userId);
          final data = {
            'liked_users': likedUsers,
            'like_count': FieldValue.increment(1),
          };
          transaction.update(_commentCollectionReference.doc(commentId), data);
        } else
          transaction.update(_commentCollectionReference.doc(commentId), {});
      });
    });
  }

  Future<void> removeCommentLike({
    @required String commentId,
    @required String userId,
  }) async {
    return FirebaseFirestore.instance.runTransaction((transaction) async {
      return await transaction
          .get(_commentCollectionReference.doc(commentId))
          .then((value) {
        if (value.exists) {
          final List<String> likedUsers = value.data()['liked_users'];
          if (!likedUsers.contains(userId)) return;
          likedUsers.remove(userId);
          final data = {
            'liked_users': likedUsers,
            'like_count': FieldValue.increment(-1),
          };
          int likeCount = value.data()['like_count'];
          if (likeCount < 0) data['like_count'] = 0;
          transaction.update(_commentCollectionReference.doc(commentId), data);
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
    return FirebaseFirestore.instance.runTransaction((transaction) async {
      return await transaction
          .get(_commentCollectionReference.doc(commentId))
          .then((value) {
        if (value.exists) {
          transaction.delete(metaActivityDocumentRef);
          transaction.update(metaDocumentRef, metaData);
          transaction.delete(_commentCollectionReference.doc(commentId));
        }
      });
    });
  }

  Future<bool> doesCommentExist({@required String commentId}) async {
    return await _commentCollectionReference
        .doc(commentId)
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
      return value.docs
          .where((snapshot) => snapshot != null && snapshot.exists)
          .map((snapshot) => CommentFirestoreResponse.fromJson(snapshot.data()))
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

    return pageQuery.get().then((value) {
      return value.docs
          .where((snapshot) => snapshot != null && snapshot.exists)
          .map((snapshot) => CommentFirestoreResponse.fromJson(snapshot.data()))
          .toList();
    });
  }
}
