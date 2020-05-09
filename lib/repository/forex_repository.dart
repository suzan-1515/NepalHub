import 'package:flutter/widgets.dart';
import 'package:samachar_hub/common/service/forex_api_service.dart';
import 'package:samachar_hub/data/api/api_provider.dart' as Api;
import 'package:samachar_hub/data/dto/forex_dto.dart';
import 'package:samachar_hub/data/mapper/forex_mappper.dart';

class ForexRepository {
  final ForexApiService forexApiService;

  ForexRepository(this.forexApiService);

  Future<Forex> getToday() async {
    return await Api.fetchTodayForex()
        .then((onValue) => ForexMapper.fromApi(onValue));
  }

  Future<Forex> getByCountry(
      {@required String currencyCode,
      @required String fromDate,
      @required String toDate}) async {
    return await Api.fetchForexByCountry(
            currencyCode: currencyCode, fromDate: fromDate, toDate: toDate)
        .then((onValue) => ForexMapper.fromApi(onValue));
  }
}
