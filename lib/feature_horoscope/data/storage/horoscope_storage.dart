import 'package:samachar_hub/feature_horoscope/data/storage/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HoroscopeStorage with Storage {
  static const DEFAULT_SIGN = 'default_horoscope_sign_key';
  final SharedPreferences _sharedPreferences;

  HoroscopeStorage(this._sharedPreferences);

  @override
  int loadDefaultHoroscopeSignIndex() {
    return _sharedPreferences.getInt(DEFAULT_SIGN);
  }

  @override
  Future saveDefaultHoroscopeSign({int signIndex}) {
    return _sharedPreferences.setInt(DEFAULT_SIGN, signIndex);
  }
}
