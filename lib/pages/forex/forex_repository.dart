import 'package:flutter/widgets.dart';
import 'package:samachar_hub/data/mappers/mappers.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/pages/forex/forex_api_service.dart';
import 'package:samachar_hub/services/analytics_service.dart';

class ForexRepository {
  final ForexApiService _forexApiService;
  final AnalyticsService _analyticsService;

  ForexRepository(this._forexApiService, this._analyticsService);

  Future<List<ForexModel>> getToday() async {
    return _forexApiService
        .fetchTodayForex()
        .then((onValue) => onValue.map((e) => ForexMapper.fromApi(e)).toList());
  }

  Future<List<ForexModel>> getByCountry(
      {@required String currencyCode,
      @required String fromDate,
      @required String toDate}) async {
    return _forexApiService
        .fetchForexByCountry(
            currencyCode: currencyCode, fromDate: fromDate, toDate: toDate)
        .then((onValue) => onValue.map((e) => ForexMapper.fromApi(e)).toList())
        .then((value) {
      _analyticsService.logForexFetched(currency: currencyCode);
      return value;
    });
  }
}
