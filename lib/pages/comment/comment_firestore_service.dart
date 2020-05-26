import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class CommentFirestoreService {
  final CollectionReference _commentCollectionReference =
      Firestore.instance.collection('comments');

  DocumentSnapshot _lastDocument;
  DocumentSnapshot get lastFetchedDocument => _lastDocument;
  void resetLastFetchedDocument() => _lastDocument = null;

  Future<void> saveComment(
      {@required String postId,
      @required String commentId,
      @required Map<String, dynamic> commentMetaData,
      @required Map<String, dynamic> commentData}) async {
    var batch = Firestore.instance.batch();
    batch.setData(_commentCollectionReference.document(postId), commentMetaData,
        merge: true);
    batch.setData(
        _commentCollectionReference
            .document(postId)
            .collection('comments')
            .document(commentId),
        commentData,
        merge: true);
    return batch.commit();
  }

  Future<void> updateCommentMeta(
      {@required String postId,
      @required String commentId,
      @required Map<String, dynamic> commentMetaData,
      @required Map<String, dynamic> commentData}) async {
    var batch = Firestore.instance.batch();
    batch.setData(
        _commentCollectionReference.document(postId), commentMetaData);
    batch.setData(
        _commentCollectionReference
            .document(postId)
            .collection('comments')
            .document(commentId),
        commentData,
        merge: true);
    return batch.commit();
  }

  Future<void> updateCommentLikes(
      {@required String postId, @required String commentId}) async {
    var batch = Firestore.instance.batch();
    batch.setData(
        _commentCollectionReference
            .document(postId)
            .collection('comments')
            .document(commentId),
        {'likes_count': FieldValue.increment(1)});
    batch.setData(_commentCollectionReference.document(postId),
        {'likes_count': FieldValue.increment(1)},
        merge: true);
    return batch.commit();
  }

  Future<void> removeComment(
      {@required String commentId, @required String postId}) async {
    return await _commentCollectionReference
        .document(postId)
        .collection('comments')
        .document(commentId)
        .delete();
  }

  Future<bool> doesCommentExist(
      {@required String commentId, @required String postId}) async {
    return await _commentCollectionReference
        .document(postId)
        .collection('comments')
        .document(commentId)
        .get()
        .then((onValue) => onValue.exists);
  }

  Future<QuerySnapshot> fetchComments(
      {@required String postId, @required int limit, String after}) {
    var pageQuery = _commentCollectionReference
        .document(postId)
        .collection('comments')
        .orderBy('timestamp', descending: true)
        .limit(limit);

    if (after != null) {
      pageQuery = pageQuery.startAfter([after]);
    }

    return pageQuery.getDocuments().then((onValue) {
      if (onValue != null &&
          onValue.documents != null &&
          onValue.documents.isNotEmpty) _lastDocument = onValue.documents.last;
      return onValue;
    });
  }

  Future<DocumentSnapshot> fetchCommentsMeta({@required String postId}) {
    return _commentCollectionReference.document(postId).get();
  }
}
