import 'package:flutter/foundation.dart';

mixin LocalDataSource {
  Future saveDefaultForexCurrency({@required String currencyCode});
  String loadDefaultForexCurrencyCode();
}
