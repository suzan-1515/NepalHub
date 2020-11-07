import 'package:intl/intl.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/feature_horoscope/domain/entities/horoscope_entity.dart';
import 'package:samachar_hub/feature_horoscope/presentation/models/horoscope_model.dart';

extension HoroscopeX on HoroscopeEntity {
  HoroscopeUIModel get toUIModel => HoroscopeUIModel(this);

  String signByIndex(int index, Language language) =>
      HOROSCOPE_SIGNS[language][index];

  String signIconByIndex(int index) => HOROSCOPE_ICONS[index];

  String horoscopeByIndex(int index, Language language) {
    switch (index) {
      case 0:
        return this.aries;
      case 1:
        return this.taurus;
      case 2:
        return this.gemini;
      case 3:
        return this.cancer;
      case 4:
        return this.leo;
      case 5:
        return this.virgo;
      case 6:
        return this.libra;
      case 7:
        return this.scorpio;
      case 8:
        return this.sagittarius;
      case 9:
        return this.capricorn;
      case 10:
        return this.aquarius;
      case 11:
        return this.pisces;
      default:
        throw Exception('Invalid index');
    }
  }
}

extension HoroscopeListX on List<HoroscopeEntity> {
  List<HoroscopeUIModel> get toUIModels =>
      this.map((e) => e.toUIModel).toList();
}

extension HoroscopeDateTimeX on DateTime {
  String get formattedString =>
      DateFormat('dd MMMM, yyyy').format(this.toLocal());
}
