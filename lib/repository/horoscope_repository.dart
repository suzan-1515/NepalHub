import 'package:samachar_hub/common/service/horoscope_api_service.dart';
import 'package:samachar_hub/data/api/api_provider.dart' as Api;
import 'package:samachar_hub/data/dto/dto.dart';
import 'package:samachar_hub/data/mapper/horoscope_mapper.dart';

class HoroscopeRepository {
  final HoroscopeApiService horoscopeApiService;

  HoroscopeRepository(this.horoscopeApiService);

  Future<Map<HoroscopeType, Horoscope>> getHoroscope() async {
    Map<HoroscopeType, Horoscope> horoscopes = {};
    return await Api.fetchHoroscope()
        .then((onValue) => onValue.np?.forEach((f) {
              horoscopes[f.type.parseAsHoroscopeType()] =
                  HoroscopeMapper.fromHoroscopeApi(f);
            }))
        .then((onValue) => horoscopes);
  }
}
