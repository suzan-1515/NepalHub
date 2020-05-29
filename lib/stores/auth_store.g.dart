// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthenticationStore on _AuthenticationStore, Store {
  final _$userAtom = Atom(name: '_AuthenticationStore.user');

  @override
  UserModel get user {
    _$userAtom.context.enforceReadPolicy(_$userAtom);
    _$userAtom.reportObserved();
    return super.user;
  }

  @override
  set user(UserModel value) {
    _$userAtom.context.conditionallyRunInAction(() {
      super.user = value;
      _$userAtom.reportChanged();
    }, _$userAtom, name: '${_$userAtom.name}_set');
  }

  final _$isLoggedInAtom = Atom(name: '_AuthenticationStore.isLoggedIn');

  @override
  bool get isLoggedIn {
    _$isLoggedInAtom.context.enforceReadPolicy(_$isLoggedInAtom);
    _$isLoggedInAtom.reportObserved();
    return super.isLoggedIn;
  }

  @override
  set isLoggedIn(bool value) {
    _$isLoggedInAtom.context.conditionallyRunInAction(() {
      super.isLoggedIn = value;
      _$isLoggedInAtom.reportChanged();
    }, _$isLoggedInAtom, name: '${_$isLoggedInAtom.name}_set');
  }

  final _$loginWithEmailAsyncAction = AsyncAction('loginWithEmail');

  @override
  Future<bool> loginWithEmail(
      {@required String email, @required String password}) {
    return _$loginWithEmailAsyncAction
        .run(() => super.loginWithEmail(email: email, password: password));
  }

  final _$_AuthenticationStoreActionController =
      ActionController(name: '_AuthenticationStore');

  @override
  dynamic setLoggedIn(bool value) {
    final _$actionInfo = _$_AuthenticationStoreActionController.startAction();
    try {
      return super.setLoggedIn(value);
    } finally {
      _$_AuthenticationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'user: ${user.toString()},isLoggedIn: ${isLoggedIn.toString()}';
    return '{$string}';
  }
}
