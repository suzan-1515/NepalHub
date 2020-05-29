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

  Future<bool> isUserLoggedIn() async {
    return await _authenticationService.isLoggedIn();
  }

  Future<void> logout() async {
    return await _authenticationService
        .logout()
        .then((onValue) => _analyticsService.logLogout());
  }
}
