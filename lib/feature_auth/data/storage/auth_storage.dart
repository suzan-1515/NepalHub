import 'package:meta/meta.dart';
import 'package:samachar_hub/feature_auth/data/storage/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthStorage with Storage {
  static const USER_TOKEN = 'user_token_key';

  final SharedPreferences _sharedPreferences;

  AuthStorage(this._sharedPreferences);
  @override
  String loadUserToken() {
    return _sharedPreferences.getString(USER_TOKEN);
  }

  @override
  Future saveUserToken({@required String token}) {
    return _sharedPreferences.setString(USER_TOKEN, token);
  }
}
