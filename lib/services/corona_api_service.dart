import 'package:samachar_hub/data/api/api_provider.dart' as Api;
import 'package:samachar_hub/data/api/response/corona_api_response.dart';

class CoronaApiService {
  Future<CoronaWorldwideApiResponse> fetchWorldwideStat() async {
    return await Api.fetchCoronaWorldwideStat();
  }

  Future<CoronaCountrySpecificApiResponse> fetchByCountry(
      {String country = 'nepal'}) async {
    return await Api.fetchCoronaStatByCountry(country: country);
  }
}
