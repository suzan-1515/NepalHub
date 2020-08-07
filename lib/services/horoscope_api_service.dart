import 'package:samachar_hub/data/api/api_provider.dart' as Api;
import 'package:samachar_hub/data/api/response/horoscope_api_response.dart';

class HoroscopeApiService {
  Future<HoroscopeApiResponse> fetchHoroscope() async {
    return await Api.fetchHoroscope();
  }
}
