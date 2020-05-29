import 'package:flutter/widgets.dart';
import 'package:samachar_hub/data/api/api_provider.dart' as Api;
import 'package:samachar_hub/data/api/response/forex_api_response.dart';

class ForexApiService {
  Future<ForexApiResponse> fetchTodayForex() async {
    return await Api.fetchTodayForex();
  }

  Future<ForexApiResponse> fetchForexByCountry(
      {@required String currencyCode,
      @required String fromDate,
      @required String toDate}) async {
    return await Api.fetchForexByCountry(
        currencyCode: currencyCode, fromDate: fromDate, toDate: toDate);
  }
}
