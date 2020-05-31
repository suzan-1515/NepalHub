import 'package:samachar_hub/data/api/api_provider.dart' as Api;
import 'package:samachar_hub/data/mappers/mappers.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/pages/horoscope/horoscope_api_service.dart';

class HoroscopeRepository {
  final HoroscopeApiService horoscopeApiService;

  HoroscopeRepository(this.horoscopeApiService);

  Future<Map<HoroscopeType, HoroscopeModel>> getHoroscope() async {
    Map<HoroscopeType, HoroscopeModel> horoscopes = {};
    return await Api.fetchHoroscope()
        .then((onValue) => onValue.np?.forEach((f) {
              horoscopes[f.type.parseAsHoroscopeType()] =
                  HoroscopeMapper.fromHoroscopeApi(f);
            }))
        .then((onValue) => horoscopes);
  }
}
