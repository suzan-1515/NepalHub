import 'package:flutter/material.dart';

mixin Storage {
  Future saveDefaultForexCurrency({@required String currencyCode});
  String loadDefaultForexCurrencyCode();
}
