import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class FavouritesFirestoreService {
  final CollectionReference _favouritesCollectionReference =
      Firestore.instance.collection('favourites');
}
