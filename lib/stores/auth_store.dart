import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/repository/repositories.dart';

part 'auth_store.g.dart';

class AuthenticationStore = _AuthenticationStore with _$AuthenticationStore;

abstract class _AuthenticationStore with Store {
  final AuthenticationRepository _authenticationRepository;
  _AuthenticationStore(this._authenticationRepository);

  @observable
  UserModel user = UserModel.anonymous();

  @observable
  bool isLoggedIn = false;

  @action
  setLoggedIn(bool value) {
    this.isLoggedIn = value;
  }

  @action
  Future<bool> loginWithEmail({@required String email, @required String password}) async{
    return _authenticationRepository
        .loginWithEmail(email: email, password: password)
        .then((value) {
      if (value != null) {
        this.user = value;
      }
      isLoggedIn = value != null;
      return isLoggedIn;
    }).catchError((onError) {
      isLoggedIn = false;
      return false;
    });
  }
}
