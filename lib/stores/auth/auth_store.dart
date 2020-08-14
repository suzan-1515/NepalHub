import 'dart:developer';

import 'package:mobx/mobx.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/repository/repositories.dart';

part 'auth_store.g.dart';

class AuthenticationStore = _AuthenticationStore with _$AuthenticationStore;

abstract class _AuthenticationStore with Store {
  final AuthenticationRepository _authenticationRepository;
  _AuthenticationStore(this._authenticationRepository);

  @observable
  UserModel user;

  @observable
  bool isLoggedIn;

  @observable
  bool isLoading = false;

  @observable
  String error;

  @action
  Future signInWithGoogle() async {
    if (isLoading) return false;
    isLoading = true;
    return _authenticationRepository.signInWithGoogle().then((value) {
      if (value != null) {
        user = value;
      }
      isLoggedIn = value != null;
    }).catchError((onError) {
      log('signInWithGoogle: ', error: onError);
      this.error = 'Error signing in.';
      isLoggedIn = false;
    }).whenComplete(() {
      isLoading = false;
    });
  }

  @action
  Future signInAnonymously() async {
    if (isLoading) return false;
    isLoading = true;
    return _authenticationRepository.signInAnonymously().then((value) {
      if (value != null) {
        user = value;
      }
      isLoggedIn = value != null;
    }).catchError((onError) {
      log('signInAnonymously: ', error: onError);
      this.error = 'Error signing in.';
      isLoggedIn = false;
    }).whenComplete(() {
      isLoading = false;
    });
  }

  @action
  Future silentSignIn() async {
    return _authenticationRepository.getCurrentUser().then((value) {
      if (value != null) {
        user = value;
      }
      isLoggedIn = value != null;
    }).catchError((onError) {
      log('silentSignIn: ', error: onError);
      isLoggedIn = false;
    });
  }

  @action
  Future logOut() async {
    return _authenticationRepository.logout().then((value) {
      user = null;
      isLoggedIn = false;
    }).catchError((onError) {
      log('logout', error: onError);
      this.error = 'Error logging out.';
    });
  }
}
