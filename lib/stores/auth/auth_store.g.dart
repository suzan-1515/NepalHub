// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthenticationStore on _AuthenticationStore, Store {
  final _$userAtom = Atom(name: '_AuthenticationStore.user');

  @override
  UserModel get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(UserModel value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$isLoggedInAtom = Atom(name: '_AuthenticationStore.isLoggedIn');

  @override
  bool get isLoggedIn {
    _$isLoggedInAtom.reportRead();
    return super.isLoggedIn;
  }

  @override
  set isLoggedIn(bool value) {
    _$isLoggedInAtom.reportWrite(value, super.isLoggedIn, () {
      super.isLoggedIn = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_AuthenticationStore.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$errorAtom = Atom(name: '_AuthenticationStore.error');

  @override
  String get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  final _$signInWithGoogleAsyncAction =
      AsyncAction('_AuthenticationStore.signInWithGoogle');

  @override
  Future<dynamic> signInWithGoogle() {
    return _$signInWithGoogleAsyncAction.run(() => super.signInWithGoogle());
  }

  final _$signInWithFacebookAsyncAction =
      AsyncAction('_AuthenticationStore.signInWithFacebook');

  @override
  Future<dynamic> signInWithFacebook() {
    return _$signInWithFacebookAsyncAction
        .run(() => super.signInWithFacebook());
  }

  final _$signInWithTwitterAsyncAction =
      AsyncAction('_AuthenticationStore.signInWithTwitter');

  @override
  Future<dynamic> signInWithTwitter() {
    return _$signInWithTwitterAsyncAction.run(() => super.signInWithTwitter());
  }

  final _$signInAnonymouslyAsyncAction =
      AsyncAction('_AuthenticationStore.signInAnonymously');

  @override
  Future<dynamic> signInAnonymously() {
    return _$signInAnonymouslyAsyncAction.run(() => super.signInAnonymously());
  }

  final _$logOutAsyncAction = AsyncAction('_AuthenticationStore.logOut');

  @override
  Future<dynamic> logOut() {
    return _$logOutAsyncAction.run(() => super.logOut());
  }

  final _$_AuthenticationStoreActionController =
      ActionController(name: '_AuthenticationStore');

  @override
  Future<dynamic> silentSignIn() {
    final _$actionInfo = _$_AuthenticationStoreActionController.startAction(
        name: '_AuthenticationStore.silentSignIn');
    try {
      return super.silentSignIn();
    } finally {
      _$_AuthenticationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
user: ${user},
isLoggedIn: ${isLoggedIn},
isLoading: ${isLoading},
error: ${error}
    ''';
  }
}
