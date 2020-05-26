import 'package:mobx/mobx.dart';
import 'package:samachar_hub/data/api/api.dart';

part 'auth_store.g.dart';

class AuthenticationStore = _AuthenticationStore with _$AuthenticationStore;

abstract class _AuthenticationStore with Store {
  _AuthenticationStore();

  @observable
  User user;

  @computed
  bool get isLoggedIn => user != null;

  @action
  setUser(User user) {
    this.user = user;
  }
}
