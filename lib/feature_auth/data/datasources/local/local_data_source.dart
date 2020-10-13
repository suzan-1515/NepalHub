mixin LocalDataSource {
  String loadUserToken();
  Future saveUserToken({String token});
}
