import 'package:flutter/foundation.dart';
import 'package:samachar_hub/feature_auth/data/datasources/local/local_data_source.dart';
import 'package:samachar_hub/feature_auth/data/storage/storage.dart';

class AuthLocalDataSource with LocalDataSource {
  final Storage _storage;

  AuthLocalDataSource(this._storage);
  @override
  String loadUserToken() {
    return _storage.loadUserToken();
  }

  @override
  Future saveUserToken({@required String token}) {
    return _storage.saveUserToken(token: token);
  }
}
