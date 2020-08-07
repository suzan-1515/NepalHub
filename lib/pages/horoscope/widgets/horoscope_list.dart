import 'package:flutter/material.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/pages/horoscope/widgets/header.dart';
import 'package:samachar_hub/pages/horoscope/widgets/horoscope_list_item.dart';

class HoroscopeList extends StatelessWidget {
  const HoroscopeList({
    Key key,
    @required this.data,
  }) : super(key: key);

  final HoroscopeModel data;

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: <Widget>[
        SizedBox(height: 8),
        Header(title: data.title, context: context),
        SizedBox(height: 8),
        HoroscopeListItem(
            data: data,
            context: context,
            sign: 'मेष Aries',
            zodiac: data.aries,
            signIcon: 'https://www.ashesh.com.np/rashifal/images/1@2x.png'),
        HoroscopeListItem(
            data: data,
            context: context,
            sign: 'वृष Taurus',
            zodiac: data.taurus,
            signIcon: 'https://www.ashesh.com.np/rashifal/images/2@2x.png'),
        HoroscopeListItem(
            data: data,
            context: context,
            sign: 'मिथुन Gemini',
            zodiac: data.gemini,
            signIcon: 'https://www.ashesh.com.np/rashifal/images/3@2x.png'),
        HoroscopeListItem(
            data: data,
            context: context,
            sign: 'कर्कट Cancer',
            zodiac: data.cancer,
            signIcon: 'https://www.ashesh.com.np/rashifal/images/4@2x.png'),
        HoroscopeListItem(
            data: data,
            context: context,
            sign: 'सिंह Leo',
            zodiac: data.leo,
            signIcon: 'https://www.ashesh.com.np/rashifal/images/5@2x.png'),
        HoroscopeListItem(
            data: data,
            context: context,
            sign: 'कन्या Virgo',
            zodiac: data.virgo,
            signIcon: 'https://www.ashesh.com.np/rashifal/images/6@2x.png'),
        HoroscopeListItem(
            data: data,
            context: context,
            sign: 'तुला Libra',
            zodiac: data.libra,
            signIcon: 'https://www.ashesh.com.np/rashifal/images/7@2x.png'),
        HoroscopeListItem(
            data: data,
            context: context,
            sign: 'वृश्चिक Scorpio',
            zodiac: data.scorpio,
            signIcon: 'https://www.ashesh.com.np/rashifal/images/8@2x.png'),
        HoroscopeListItem(
            data: data,
            context: context,
            sign: 'धनु Sagittarius',
            zodiac: data.sagittarius,
            signIcon: 'https://www.ashesh.com.np/rashifal/images/9@2x.png'),
        HoroscopeListItem(
            data: data,
            context: context,
            sign: 'मकर Capricorn',
            zodiac: data.capricorn,
            signIcon: 'https://www.ashesh.com.np/rashifal/images/10@2x.png'),
        HoroscopeListItem(
            data: data,
            context: context,
            sign: 'कुम्भ Aquarius',
            zodiac: data.aquarius,
            signIcon: 'https://www.ashesh.com.np/rashifal/images/11@2x.png'),
        HoroscopeListItem(
            data: data,
            context: context,
            sign: 'मीन Pisces',
            zodiac: data.pisces,
            signIcon: 'https://www.ashesh.com.np/rashifal/images/12@2x.png'),
      ],
    );
  }
}
