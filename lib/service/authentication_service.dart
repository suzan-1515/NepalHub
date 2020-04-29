import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  final CollectionReference _usersCollectionReference =
      Firestore.instance.collection('users');

  AuthenticationService(this._firebaseAuth);

  Future<AuthResult> loginWithEmail({
    @required String email,
    @required String password,
  }) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<AuthResult> signUpWithEmail({
    @required String email,
    @required String password,
    @required String fullName,
    @required String avatar,
  }) async {
    return await _firebaseAuth
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((auth) {
      if (auth != null) {
        return _usersCollectionReference.document(auth.user.uid).setData({
          'id': auth.user.uid,
          'full_name': fullName,
          'email': email,
          'avatar': avatar
        }, merge: true).then((onValue) => auth);
      }
      return auth;
    });
  }

  Future<DocumentSnapshot> getUserProfile({@required String uid}) async {
    return await _usersCollectionReference.document(uid).get();
  }

  Future<bool> isLoggedIn() async {
    return (await _firebaseAuth.currentUser()) != null;
  }

  Future<void> logout() async {
    return await _firebaseAuth.signOut();
  }

  DocumentReference getUserDocumentReference({@required String userId}) =>
      _usersCollectionReference.document(userId);
}
