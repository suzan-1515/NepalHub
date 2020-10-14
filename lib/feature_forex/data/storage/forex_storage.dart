import 'package:samachar_hub/feature_forex/data/storage/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForexStorage with Storage {
  static const DEFAULT_CURRENCY = 'default_forex_currency_key';
  final SharedPreferences _sharedPreferences;

  ForexStorage(this._sharedPreferences);
  @override
  String loadDefaultForexCurrencyCode() {
    return _sharedPreferences.getString(DEFAULT_CURRENCY);
  }

  @override
  Future saveDefaultForexCurrency({String currencyCode}) {
    return _sharedPreferences.setString(DEFAULT_CURRENCY, currencyCode);
  }
}
