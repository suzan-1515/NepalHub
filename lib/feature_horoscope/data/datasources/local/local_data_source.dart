import 'package:flutter/foundation.dart';

mixin LocalDataSource {
  Future saveDefaultHoroscopeSign({@required int signIndex});
  int loadDefaultHoroscopeSignIndex();
}
