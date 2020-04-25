import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class BookmarkService {
  final CollectionReference _bookmarkedCollectionReference =
      Firestore.instance.collection('bookmarks');

  DocumentSnapshot _lastDocument;

  Future<void> addBookmarkedFeed({id, data}) async {
    return await _bookmarkedCollectionReference.document(id).setData(data);
  }

  Future<void> removeBookmarkedFeed({feedId}) async {
    return await _bookmarkedCollectionReference.document(feedId).delete();
  }

  Stream<QuerySnapshot> fetchBookmarksAsStream({userId, limit}) {
    var pageQuery = _bookmarkedCollectionReference
        .where('user_id', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .limit(limit);

    return pageQuery.snapshots().map((onValue) {
      if (onValue != null &&
          onValue.documents != null &&
          onValue.documents.isNotEmpty) _lastDocument = onValue.documents.last;
      return onValue;
    });
  }

  Future<QuerySnapshot> fetchBookmarks({userId, limit, resetPage = false}) {
    var pageQuery = _bookmarkedCollectionReference
        .where('user_id', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .limit(limit);

    if (resetPage) _lastDocument = null;

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
