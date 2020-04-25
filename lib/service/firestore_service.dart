import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:samachar_hub/data/model/user_data.dart';

class FirestoreService {
  final CollectionReference _usersCollectionReference =
      Firestore.instance.collection('users');
  final CollectionReference _bookmarkedCollectionReference =
      Firestore.instance.collection('bookmarks');
  final CollectionReference _likesCollectionReference =
      Firestore.instance.collection('likes');
  // final CollectionReference _commentsCollectionReference =
  //     Firestore.instance.collection('comments');
  final CollectionReference _sharesCollectionReference =
      Firestore.instance.collection('shares');

  static const int DATA_LIMIT = 20;


  Future createUser(User user) async {
    return await _usersCollectionReference
        .document(user.id)
        .setData(user.toJson());
  }

  Future<DocumentSnapshot> getUserProfile({String uid}) async {
    return await _usersCollectionReference.document(uid).get();
  }

  Future<void> addBookmarkedFeed({data}) async {
    return await _bookmarkedCollectionReference
        .document(data['uuid'])
        .setData(data);
  }

  Future<void> addLikedFeed({data}) async {
    return await _likesCollectionReference.document(data['uuid']).setData(data);
  }

  Future<void> addSharedFeed({data}) async {
    return await _sharesCollectionReference
        .document(data['uuid'])
        .setData(data);
  }

  Future<void> removeBookmarkedFeed({feedId}) async {
    return await _bookmarkedCollectionReference.document(feedId).delete();
  }

  Future<void> removeLikedFeed({feedId}) async {
    return await _likesCollectionReference.document(feedId).delete();
  }

  Future<void> removeSharedFeed({feedId}) async {
    return await _sharesCollectionReference.document(feedId).delete();
  }
}
