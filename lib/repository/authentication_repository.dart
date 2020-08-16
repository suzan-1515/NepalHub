import 'package:flutter/foundation.dart';
import 'package:samachar_hub/data/models/user_model.dart';
import 'package:samachar_hub/services/services.dart';

class AuthenticationRepository {
  final AuthenticationService _authenticationService;
  final AnalyticsService _analyticsService;

  AuthenticationRepository(this._authenticationService, this._analyticsService);

  Future<UserModel> loginWithEmail({
    @required String email,
    @required String password,
  }) async {
    return await _authenticationService
        .loginWithEmail(email: email, password: password)
        .then((auth) async {
      if (auth != null) {
        return await _authenticationService
            .getUserProfile(uid: auth.user.uid)
            .then((value) {
          _analyticsService.setUser(userId: auth.user.email);
          _analyticsService.logLogin();
          return UserModel.fromJson(value.data);
        });
      }

      throw Exception('Error logging in. Try again later.');
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

  Future<UserModel> signInWithGoogle() async {
    return _authenticationService.signInWithGoogle().then((value) {
      if (value != null) {
        if (value.additionalUserInfo.isNewUser)
          _analyticsService.logSignUp(method: 'google');
        else
          _analyticsService.logLogin(method: 'google');
      }
      return UserModel.fromFirebaseUser(value.user);
    });
  }

  Future<UserModel> signInWithFacebook() async {
    return _authenticationService.signInWithFacebook().then((value) {
      if (value != null) {
        if (value.additionalUserInfo.isNewUser)
          _analyticsService.logSignUp(method: 'facebook');
        else
          _analyticsService.logLogin(method: 'facebook');
      }
      return UserModel.fromFirebaseUser(value.user);
    });
  }

  Future<UserModel> signInAnonymously() async {
    return _authenticationService.signInAnonymously().then((value) {
      if (value != null) {
        if (value.additionalUserInfo.isNewUser)
          _analyticsService.logSignUp(method: 'anonymous');
        else
          _analyticsService.logLogin(method: 'anonymous');
      }
      return UserModel.fromFirebaseUser(value.user);
    });
  }

  Future<UserModel> getCurrentUser() async {
    return await _authenticationService.getCurrentUser().then((value) {
      if (value != null) return UserModel.fromFirebaseUser(value);
      return null;
    });
  }

  Future<void> logout() async {
    return await _authenticationService
        .logout()
        .then((onValue) => _analyticsService.logLogout());
  }
}
