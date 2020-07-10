import 'package:cloud_firestore/cloud_firestore.dart';

class FollowingFirestoreService {
  final CollectionReference _favouritesCollectionReference =
      Firestore.instance.collection('favourites');
}
