import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:samachar_hub/data/model/user_data.dart';
import 'package:samachar_hub/service/analytics_service.dart';
import 'package:samachar_hub/service/firestore_service.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  final FirestoreService _firestoreService;
  final AnalyticsService _analyticsService;

  FirebaseUser _currentUser;

  AuthenticationService(
      this._firebaseAuth, this._firestoreService, this._analyticsService);

  FirebaseUser get currentUser => _currentUser;

  Future<bool> loginWithEmail({
    @required String email,
    @required String password,
  }) async {
    return await _firebaseAuth
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((auth) {
      if (auth != null) {
        _analyticsService.logLogin();
      }

      _currentUser = auth.user;

      return auth.user != null;
    }, onError: (error) {
      print('Error login: '+error.toString());
    });
  }

  Future<bool> signUpWithEmail({
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
        // create a new user profile on firestore
        var _currentUser = User(
          id: auth.user.uid,
          email: email,
          fullName: fullName,
          avatar: avatar,
        );

        _firestoreService.createUser(_currentUser).whenComplete(() {
          _analyticsService.logSignUp();
        });
        return true;
      }
      return false;
    });
  }

  Future<bool> isUserLoggedIn() async {
    return (await _firebaseAuth.currentUser()) != null;
  }
}
