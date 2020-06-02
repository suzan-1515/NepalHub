import 'package:flutter/widgets.dart';
import 'package:samachar_hub/data/api/api_provider.dart' as Api;
import 'package:samachar_hub/data/api/response/forex_api_response.dart';

class ForexApiService {
  Future<List<ForexApiResponse>> fetchTodayForex() async {
    return Api.fetchTodayForex();
  }

  Future<List<ForexApiResponse>> fetchForexByCountry(
      {@required String currencyCode,
      @required String fromDate,
      @required String toDate}) async {
    return Api.fetchForexByCountry(
        currencyCode: currencyCode, fromDate: fromDate, toDate: toDate);
  }
}
