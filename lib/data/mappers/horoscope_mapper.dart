import 'package:samachar_hub/data/api/response/horoscope_api_response.dart';
import 'package:samachar_hub/data/models/models.dart';

class HoroscopeMapper {
  static HoroscopeModel fromHoroscopeApi(Np response) {
    return HoroscopeModel(
        type: response.type,
        title: response.title,
        author: response.author,
        lang: response.lang,
        aries: response.aries,
        taurus: response.taurus,
        gemini: response.gemini,
        cancer: response.cancer,
        leo: response.leo,
        virgo: response.virgo,
        libra: response.libra,
        scorpio: response.scorpio,
        sagittarius: response.sagittarius,
        capricorn: response.capricorn,
        aquarius: response.aquarius,
        pisces: response.pisces,
        todate: response.formattedDate);
  }
}
