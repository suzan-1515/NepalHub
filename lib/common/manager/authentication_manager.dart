import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:samachar_hub/common/service/services.dart';
import 'package:samachar_hub/data/api/api.dart';

class AuthenticationManager {
  final AuthenticationService _authenticationService;
  final AnalyticsService _analyticsService;

  User _currentUser;

  AuthenticationManager(this._authenticationService, this._analyticsService);

  User get currentUser => _currentUser;
  DocumentReference get userReference =>
      _authenticationService.getUserDocumentReference(userId: _currentUser.uId);

  Future<bool> loginWithEmail({
    @required String email,
    @required String password,
  }) async {
    return await _authenticationService
        .loginWithEmail(email: email, password: password)
        .then((auth) {
      if (auth != null) {
        _authenticationService.getUserProfile(uid: auth.user.uid).then((value) {
          _currentUser = User.fromJson(value.data);
          _analyticsService.setUser(userId: auth.user.email);
          _analyticsService.logLogin();
        });
      }

      return auth.user != null;
    });
  }

  Future<bool> signUpWithEmail({
    @required String email,
    @required String password,
    @required String fullName,
    @required String avatar,
  }) async {
    return await _authenticationService
        .signUpWithEmail(
            email: email,
            password: password,
            fullName: fullName,
            avatar: avatar)
        .then((auth) {
      if (auth != null) {
        _analyticsService.logSignUp();
      }
      return auth != null;
    });
  }

  Future<bool> isUserLoggedIn() async {
    return await _authenticationService.isLoggedIn();
  }

  Future<void> logout() async {
    return await _authenticationService
        .logout()
        .then((onValue) => _analyticsService.logLogout());
  }
}
