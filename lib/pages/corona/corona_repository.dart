import 'package:samachar_hub/data/api/api_provider.dart' as Api;
import 'package:samachar_hub/data/mappers/mappers.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/pages/corona/corona_api_service.dart';

class CoronaRepository {
  final CoronaApiService coronaApiService;

  CoronaRepository(this.coronaApiService);

  Future<CoronaWorldwideModel> getWorldwideStat() async {
    return await Api.fetchCoronaWorldwideStat()
        .then((onValue) => CoronaMapper.fromWorldwideApi(onValue));
  }

  Future<CoronaCountrySpecificModel> getByCountry({String country = 'nepal'}) async {
    return await Api.fetchCoronaStatByCountry(country: country)
        .then((onValue) => CoronaMapper.fromCountryApi(onValue));
  }
}
