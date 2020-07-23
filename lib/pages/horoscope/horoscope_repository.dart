import 'package:samachar_hub/data/mappers/mappers.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/pages/horoscope/horoscope_api_service.dart';
import 'package:samachar_hub/services/analytics_service.dart';
import 'package:samachar_hub/services/preference_service.dart';

class HoroscopeRepository {
  final PreferenceService _preferenceService;
  final HoroscopeApiService _horoscopeApiService;
  final AnalyticsService _analyticsService;

  HoroscopeRepository(this._preferenceService, this._horoscopeApiService,
      this._analyticsService);

  Future<Map<HoroscopeType, HoroscopeModel>> getHoroscope() async {
    Map<HoroscopeType, HoroscopeModel> horoscopes = {};
    var defaultZodiac = _preferenceService.defaultZodiac;
    return _horoscopeApiService
        .fetchHoroscope()
        .then((onValue) => onValue.np?.forEach((f) {
              horoscopes[f.type.parseAsHoroscopeType()] =
                  HoroscopeMapper.fromHoroscopeApi(f, defaultZodiac);
            }))
        .then((onValue) => horoscopes)
        .then((value) {
      _analyticsService.logHoroscopeFetched();
      return value;
    });
  }
}
