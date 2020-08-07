import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:samachar_hub/data/api/api.dart';

class BookmarkFirestoreService {
  final CollectionReference _bookmarkCollectionReference =
      Firestore.instance.collection('bookmarks');

  Future<void> addBookmark(
      {@required String bookmarkId,
      @required Map<String, dynamic> metaActivityData,
      @required Map<String, dynamic> metaData,
      @required Map<String, dynamic> bookmarkData,
      @required DocumentReference metaActivityDocumentRef,
      @required DocumentReference metaDocumentRef}) async {
    var batch = Firestore.instance.batch();
    batch.setData(
        _bookmarkCollectionReference.document(bookmarkId), bookmarkData,
        merge: true);
    batch.setData(metaActivityDocumentRef, metaActivityData, merge: true);
    batch.setData(metaDocumentRef, metaData, merge: true);
    return batch.commit();
  }

  Future<void> removeBookmark({
    @required String bookmarkId,
    @required DocumentReference metaDocumentRef,
    @required DocumentReference metaActivityDocumentRef,
    @required Map<String, dynamic> metaData,
  }) async {
    var batch = Firestore.instance.batch();
    batch.delete(_bookmarkCollectionReference.document(bookmarkId));
    batch.delete(metaActivityDocumentRef);
    batch.updateData(metaDocumentRef, metaData);
    return batch.commit();
  }

  Future<bool> doesBookmarkExist({@required String bookmarkId}) async {
    return await _bookmarkCollectionReference
        .document(bookmarkId)
        .get()
        .then((onValue) => onValue.exists);
  }

  Stream<List<BookmarkFirestoreResponse>> fetchBookmarksAsStream(
      {@required String userId, @required int limit}) {
    var pageQuery = _bookmarkCollectionReference
        .orderBy('timestamp', descending: true)
        .where('user_id', isEqualTo: userId)
        .limit(limit);

    return pageQuery.snapshots().map((value) {
      return value.documents
          .where((snapshot) => snapshot != null && snapshot.exists)
          .map((snapshot) => BookmarkFirestoreResponse.fromJson(snapshot.data))
          .toList();
    });
  }

  Future<List<BookmarkFirestoreResponse>> fetchBookmarks(
      {@required String userId, @required int limit, String after}) {
    var pageQuery = _bookmarkCollectionReference
        .orderBy('timestamp', descending: true)
        .where('user_id', isEqualTo: userId)
        .limit(limit);

    if (after != null) {
      pageQuery = pageQuery.startAfter([after]);
    }

    return pageQuery.getDocuments().then((value) {
      return value.documents
          .where((snapshot) => snapshot != null && snapshot.exists)
          .map((snapshot) => BookmarkFirestoreResponse.fromJson(snapshot.data))
          .toList();
    });
  }
}
