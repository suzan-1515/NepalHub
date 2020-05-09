import 'package:samachar_hub/data/api/response/horoscope_api_response.dart';
import 'package:samachar_hub/data/dto/dto.dart';

class HoroscopeMapper {
  static Horoscope fromHoroscopeApi(Np response) {
    return Horoscope(
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
        todate: response.todate);
  }
}
