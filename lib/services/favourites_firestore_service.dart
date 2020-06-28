import 'package:cloud_firestore/cloud_firestore.dart';

class FavouritesFirestoreService {
  final CollectionReference _favouritesCollectionReference =
      Firestore.instance.collection('favourites');
}
