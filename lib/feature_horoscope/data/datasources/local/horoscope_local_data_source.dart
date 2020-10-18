import 'package:flutter/foundation.dart';
import 'package:samachar_hub/feature_horoscope/data/datasources/local/local_data_source.dart';
import 'package:samachar_hub/feature_horoscope/data/storage/storage.dart';

class HoroscopeLocalDataSource with LocalDataSource {
  final Storage _storage;

  HoroscopeLocalDataSource(this._storage);

  @override
  int loadDefaultHoroscopeSignIndex() {
    return _storage.loadDefaultHoroscopeSignIndex();
  }

  @override
  Future saveDefaultHoroscopeSign({@required int signIndex}) {
    return _storage.saveDefaultHoroscopeSign(signIndex: signIndex);
  }
}
