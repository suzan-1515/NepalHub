import 'package:samachar_hub/data/api/api_provider.dart' as Api;
import 'package:samachar_hub/common/service/corona_api_service.dart';
import 'package:samachar_hub/data/dto/dto.dart';
import 'package:samachar_hub/data/mapper/corona_mapper.dart';

class CoronaRepository {
  final CoronaApiService coronaApiService;

  CoronaRepository(this.coronaApiService);

  Future<CoronaWorldwide> getWorldwideStat() async {
    return await Api.fetchCoronaWorldwideStat()
        .then((onValue) => CoronaMapper.fromWorldwideApi(onValue));
  }

  Future<CoronaCountrySpecific> getByCountry({String country = 'nepal'}) async {
    return await Api.fetchCoronaStatByCountry(country: country)
        .then((onValue) => CoronaMapper.fromCountryApi(onValue));
  }
}
