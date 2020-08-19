import 'package:cloud_firestore/cloud_firestore.dart';

class FollowingFirestoreService {
  final CollectionReference _favouritesCollectionReference =
      FirebaseFirestore.instance.collection('favourites');
}
