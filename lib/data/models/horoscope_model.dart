import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:samachar_hub/utils/horoscope_signs.dart';

class HoroscopeModel extends Equatable {
  final String type;
  final String title;
  final String author;
  final String lang;
  final String aries;
  final String taurus;
  final String gemini;
  final String cancer;
  final String leo;
  final String virgo;
  final String libra;
  final String scorpio;
  final String sagittarius;
  final String capricorn;
  final String aquarius;
  final String pisces;
  final String todate;
  final int defaultSignIndex;

  HoroscopeModel(
      {@required this.type,
      @required this.title,
      @required this.author,
      @required this.lang,
      @required this.aries,
      @required this.taurus,
      @required this.gemini,
      @required this.cancer,
      @required this.leo,
      @required this.virgo,
      @required this.libra,
      @required this.scorpio,
      @required this.sagittarius,
      @required this.capricorn,
      @required this.aquarius,
      @required this.pisces,
      @required this.todate,
      @required this.defaultSignIndex});

  String get defaultHoroscope {
    switch (this.defaultSignIndex) {
      case 0:
        return aries;
      case 1:
        return taurus;
      case 2:
        return gemini;
      case 3:
        return cancer;
      case 4:
        return leo;
      case 5:
        return virgo;
      case 6:
        return libra;
      case 7:
        return scorpio;
      case 8:
        return sagittarius;
      case 8:
        return capricorn;
      case 9:
        return aquarius;
      case 10:
        return pisces;
    }

    return aries;
  }

  String get defaultSign {
    return horoscopeSigns[defaultSignIndex];
  }

  String get formattedDate {
    try {
      return DateFormat('dd MMMM, yyyy').format(DateTime.parse(todate));
    } catch (e) {
      return todate;
    }
  }

  @override
  List<Object> get props => [
        type,
        title,
        author,
        lang,
        aries,
        taurus,
        gemini,
        cancer,
        leo,
        virgo,
        libra,
        scorpio,
        sagittarius,
        capricorn,
        aquarius,
        pisces,
        todate
      ];
}
