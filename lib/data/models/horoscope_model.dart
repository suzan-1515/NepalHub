import 'package:flutter/widgets.dart';

class HoroscopeModel {
  String type;
  String title;
  String author;
  String lang;
  String aries;
  String taurus;
  String gemini;
  String cancer;
  String leo;
  String virgo;
  String libra;
  String scorpio;
  String sagittarius;
  String capricorn;
  String aquarius;
  String pisces;
  String todate;

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
      @required this.todate});
}
