import 'package:flutter/widgets.dart';
import 'package:samachar_hub/data/api/api_provider.dart' as Api;
import 'package:samachar_hub/data/mappers/mappers.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/services/services.dart';

class ForexRepository {
  final ForexApiService forexApiService;

  ForexRepository(this.forexApiService);

  Future<ForexModel> getToday() async {
    return await Api.fetchTodayForex()
        .then((onValue) => ForexMapper.fromApi(onValue));
  }

  Future<ForexModel> getByCountry(
      {@required String currencyCode,
      @required String fromDate,
      @required String toDate}) async {
    return await Api.fetchForexByCountry(
            currencyCode: currencyCode, fromDate: fromDate, toDate: toDate)
        .then((onValue) => ForexMapper.fromApi(onValue));
  }
}
