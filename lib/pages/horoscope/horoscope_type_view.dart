import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/models/horoscope_model.dart';
import 'package:samachar_hub/services/navigation_service.dart';

class HoroscopeTypeView extends StatelessWidget {
  final HoroscopeModel data;

  const HoroscopeTypeView({Key key, @required this.data}) : super(key: key);

  Widget _buildZodiacCard(
      BuildContext context, String sign, String zodiac, String signIcon) {
    return Card(
      color: Theme.of(context).cardColor,
      child: ListTile(
        onTap: () {
          context
              .read<NavigationService>()
              .toHoroscopeDetail(context, sign, signIcon, zodiac, data);
        },
        leading: Hero(
          tag: sign,
          child: CircleAvatar(
            backgroundColor: Theme.of(context).canvasColor,
            backgroundImage: NetworkImage(signIcon),
          ),
        ),
        title: Text(
          sign,
          style: Theme.of(context)
              .textTheme
              .subtitle1
              .copyWith(fontWeight: FontWeight.w700),
        ),
        subtitle: Text(
          zodiac,
          style: Theme.of(context).textTheme.bodyText1,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _buildTitleHeader(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Text(
        data.title,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: <Widget>[
        SizedBox(height: 8),
        _buildTitleHeader(context),
        SizedBox(height: 8),
        _buildZodiacCard(context, 'मेष Aries', data.aries,
            'https://www.ashesh.com.np/rashifal/images/1@2x.png'),
        _buildZodiacCard(context, 'वृष Taurus', data.taurus,
            'https://www.ashesh.com.np/rashifal/images/2@2x.png'),
        _buildZodiacCard(context, 'मिथुन Gemini', data.gemini,
            'https://www.ashesh.com.np/rashifal/images/3@2x.png'),
        _buildZodiacCard(context, 'कर्कट Cancer', data.cancer,
            'https://www.ashesh.com.np/rashifal/images/4@2x.png'),
        _buildZodiacCard(context, 'सिंह Leo', data.leo,
            'https://www.ashesh.com.np/rashifal/images/5@2x.png'),
        _buildZodiacCard(context, 'कन्या Virgo', data.virgo,
            'https://www.ashesh.com.np/rashifal/images/6@2x.png'),
        _buildZodiacCard(context, 'तुला Libra', data.libra,
            'https://www.ashesh.com.np/rashifal/images/7@2x.png'),
        _buildZodiacCard(context, 'वृश्चिक Scorpio', data.scorpio,
            'https://www.ashesh.com.np/rashifal/images/8@2x.png'),
        _buildZodiacCard(context, 'धनु Sagittarius', data.sagittarius,
            'https://www.ashesh.com.np/rashifal/images/9@2x.png'),
        _buildZodiacCard(context, 'मकर Capricorn', data.capricorn,
            'https://www.ashesh.com.np/rashifal/images/10@2x.png'),
        _buildZodiacCard(context, 'कुम्भ Aquarius', data.aquarius,
            'https://www.ashesh.com.np/rashifal/images/11@2x.png'),
        _buildZodiacCard(context, 'मीन Pisces', data.pisces,
            'https://www.ashesh.com.np/rashifal/images/12@2x.png'),
      ],
    );
  }
}
