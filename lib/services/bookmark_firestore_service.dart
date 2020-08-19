import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:samachar_hub/data/api/api.dart';

class BookmarkFirestoreService {
  final CollectionReference _bookmarkCollectionReference =
      FirebaseFirestore.instance.collection('bookmarks');

  Future<void> addBookmark(
      {@required String bookmarkId,
      @required Map<String, dynamic> bookmarkData}) async {
    return _bookmarkCollectionReference
        .doc(bookmarkId)
        .set(bookmarkData, SetOptions(merge: true));
  }

  Future<void> removeBookmark({
    @required String bookmarkId,
  }) async {
    return _bookmarkCollectionReference.doc(bookmarkId).delete();
  }

  Future<bool> doesBookmarkExist({@required String bookmarkId}) async {
    return await _bookmarkCollectionReference
        .doc(bookmarkId)
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
      return value.docs
          .where((snapshot) => snapshot != null && snapshot.exists)
          .map(
              (snapshot) => BookmarkFirestoreResponse.fromJson(snapshot.data()))
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

    return pageQuery.get().then((value) {
      return value.docs
          .where((snapshot) => snapshot != null && snapshot.exists)
          .map(
              (snapshot) => BookmarkFirestoreResponse.fromJson(snapshot.data()))
          .toList();
    });
  }
}
