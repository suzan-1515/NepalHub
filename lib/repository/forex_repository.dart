import 'package:flutter/widgets.dart';
import 'package:samachar_hub/data/mappers/mappers.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/services/forex_api_service.dart';
import 'package:samachar_hub/services/analytics_service.dart';
import 'package:samachar_hub/services/preference_service.dart';

class ForexRepository {
  final PreferenceService _preferenceService;
  final ForexApiService _forexApiService;
  final AnalyticsService _analyticsService;

  ForexRepository(
      this._preferenceService, this._forexApiService, this._analyticsService);

  Future<List<ForexModel>> getToday() async {
    var defaultCurrency = _preferenceService.defaultForexCurrency;
    return _forexApiService.fetchTodayForex().then((onValue) {
      return onValue
          .map((e) => ForexMapper.fromApi(e, defaultCurrency))
          .toList();
    });
  }

  Future<List<ForexModel>> getByCountry(
      {@required String currencyCode,
      @required String fromDate,
      @required String toDate}) async {
    var defaultCurrency = _preferenceService.defaultForexCurrency;
    return _forexApiService
        .fetchForexByCountry(
            currencyCode: currencyCode, fromDate: fromDate, toDate: toDate)
        .then((onValue) {
      return onValue
          .map((e) => ForexMapper.fromApi(e, defaultCurrency))
          .toList();
    });
  }
}
