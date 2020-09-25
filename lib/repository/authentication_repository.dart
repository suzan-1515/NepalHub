import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/data/models/user_model.dart';
import 'package:samachar_hub/services/authentication_service.dart';

class AuthenticationRepository {
  final AuthenticationService _authenticationService;
  final AnalyticsService _analyticsService;
  final NotificationService _notificationService;

  AuthenticationRepository(
    this._authenticationService,
    this._analyticsService,
    this._notificationService,
  );

  Future<UserModel> loginWithEmail({
    @required String email,
    @required String password,
  }) {
    return _authenticationService
        .loginWithEmail(email: email, password: password)
        .then((auth) {
      return _authenticationService
          .getUserProfile(uid: auth.user.uid)
          .then((value) {
        if (value.exists) {
          _analyticsService.setUser(userId: auth.user.uid);
          _analyticsService.logLogin(method: auth.credential.signInMethod);
          return UserModel.fromJson(value.data());
        }
        logout(auth.credential.signInMethod);
        return null;
      });
    });
  }

  Future<UserModel> signUpWithEmail({
    @required String email,
    @required String password,
    @required String fullName,
    @required String avatar,
  }) {
    return _authenticationService
        .signUpWithEmail(email: email, password: password)
        .then((auth) {
      final user = UserModel(
          uId: auth.user.uid,
          fullName: fullName,
          avatar: avatar,
          email: email,
          isAnonymous: false,
          provider: auth.credential.signInMethod,
          createdAt: auth.user.metadata.creationTime);
      return _authenticationService.saveUserProfile(user: user).then((_) {
        _analyticsService.logSignUp(method: auth.credential.signInMethod);
        _notificationService.setEmail(email);
        return _authenticationService
            .getUserProfile(uid: auth.user.uid)
            .then((data) {
          if (data.exists) {
            _analyticsService.logLogin(method: auth.credential.signInMethod);
            _analyticsService.setUser(userId: auth.user.uid);
            return UserModel.fromJson(data.data());
          }
          logout(auth.credential.signInMethod);
          return null;
        });
      });
    });
  }

  Future<UserModel> signInWithGoogle() async {
    return _authenticationService.signInWithGoogle().then((value) {
      if (value.additionalUserInfo.isNewUser) {
        return _authenticationService
            .saveUserProfile(user: UserModel.fromFirebaseUser(value))
            .then((_) {
          _analyticsService.logSignUp(method: value.credential.signInMethod);
          _notificationService.setEmail(value.user.email);
          return _authenticationService
              .getUserProfile(uid: value.user.uid)
              .then((data) {
            if (data.exists) {
              _analyticsService.logLogin(method: value.credential.signInMethod);
              _analyticsService.setUser(userId: value.user.uid);
              return UserModel.fromJson(data.data());
            }
            logout(value.credential.signInMethod);
            return null;
          });
        });
      }
      return _authenticationService
          .getUserProfile(uid: value.user.uid)
          .then((data) {
        if (data.exists) {
          _analyticsService.logLogin(method: value.credential.signInMethod);
          _analyticsService.setUser(userId: value.user.uid);
          return UserModel.fromJson(data.data());
        }
        logout(value.credential.signInMethod);
        return null;
      });
    });
  }

  Future<UserModel> signInWithFacebook() async {
    return _authenticationService.signInWithFacebook().then((value) {
      if (value.additionalUserInfo.isNewUser) {
        return _authenticationService
            .saveUserProfile(user: UserModel.fromFirebaseUser(value))
            .then((_) {
          _analyticsService.logSignUp(method: value.credential.signInMethod);
          _notificationService.setEmail(value.user.email);
          return _authenticationService
              .getUserProfile(uid: value.user.uid)
              .then((data) {
            if (data.exists) {
              _analyticsService.logLogin(method: value.credential.signInMethod);
              _analyticsService.setUser(userId: value.user.uid);
              return UserModel.fromJson(data.data());
            }
            logout(value.credential.signInMethod);
            return null;
          });
        });
      }
      return _authenticationService
          .getUserProfile(uid: value.user.uid)
          .then((data) {
        if (data.exists) {
          _analyticsService.logLogin(method: value.credential.signInMethod);
          _analyticsService.setUser(userId: value.user.uid);
          return UserModel.fromJson(data.data());
        }
        logout(value.credential.signInMethod);
        return null;
      });
    });
  }

  Future<UserModel> signInWithTwitter() async {
    return _authenticationService.signInWithTwitter().then((value) {
      if (value.additionalUserInfo.isNewUser) {
        return _authenticationService
            .saveUserProfile(user: UserModel.fromFirebaseUser(value))
            .then((_) {
          _analyticsService.logSignUp(method: value.credential.signInMethod);
          _notificationService.setEmail(value.user.email);
          return _authenticationService
              .getUserProfile(uid: value.user.uid)
              .then((data) {
            if (data.exists) {
              _analyticsService.logLogin(method: value.credential.signInMethod);
              _analyticsService.setUser(userId: value.user.uid);
              return UserModel.fromJson(data.data());
            }
            logout(value.credential.signInMethod);
            return null;
          });
        });
      }
      return _authenticationService
          .getUserProfile(uid: value.user.uid)
          .then((data) {
        if (data.exists) {
          _analyticsService.logLogin(method: value.credential.signInMethod);
          _analyticsService.setUser(userId: value.user.uid);
          return UserModel.fromJson(data.data());
        }
        logout(value.credential.signInMethod);
        return null;
      });
    });
  }

  Future<UserModel> signInAnonymously() async {
    return _authenticationService.signInAnonymously().then((value) {
      if (value.additionalUserInfo.isNewUser) {
        return _authenticationService
            .saveUserProfile(user: UserModel.fromFirebaseUser(value))
            .then((_) {
          _analyticsService.logSignUp(method: value.credential.signInMethod);
          return _authenticationService
              .getUserProfile(uid: value.user.uid)
              .then((data) {
            if (data.exists) {
              _analyticsService.logLogin(method: value.credential.signInMethod);
              _analyticsService.setUser(userId: value.user.uid);
              return UserModel.fromJson(data.data());
            }
            logout(value.credential.signInMethod);
            return null;
          });
        });
      }
      return _authenticationService
          .getUserProfile(uid: value.user.uid)
          .then((data) {
        if (data.exists) {
          _analyticsService.logLogin(method: value.credential.signInMethod);
          _analyticsService.setUser(userId: value.user.uid);
          return UserModel.fromJson(data.data());
        }
        logout(value.credential.signInMethod);
        return null;
      });
    });
  }

  Future<UserModel> silentSignIn() {
    return _authenticationService.currentUser().then((value) {
      if (value == null) return null;
      return _authenticationService.getUserProfile(uid: value.uid).then((data) {
        if (data.exists) {
          _analyticsService.logLogin(method: data.data()['provider']);
          _analyticsService.setUser(userId: value.uid);
          return UserModel.fromJson(data.data());
        }
        _authenticationService.logout();
        return null;
      });
    });
  }

  Stream<User> authStateChanges() => _authenticationService.authStateChanges();

  Future<void> logout(String provider) async {
    return await _authenticationService
        .logout()
        .then((onValue) => _analyticsService.logLogout(method: provider));
  }
}
