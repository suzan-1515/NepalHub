import 'package:samachar_hub/feature_forex/data/datasources/local/local_data_source.dart';
import 'package:samachar_hub/feature_forex/data/storage/storage.dart';

class ForexLocalDataSource with LocalDataSource {
  final Storage _storage;

  ForexLocalDataSource(this._storage);
  @override
  String loadDefaultForexCurrencyCode() {
    return _storage.loadDefaultForexCurrencyCode();
  }

  @override
  Future saveDefaultForexCurrency({String currencyCode}) {
    return _storage.saveDefaultForexCurrency(currencyCode: currencyCode);
  }
}
