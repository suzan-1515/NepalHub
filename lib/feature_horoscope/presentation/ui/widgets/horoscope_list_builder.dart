import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_horoscope/presentation/models/horoscope_model.dart';
import 'package:samachar_hub/feature_horoscope/presentation/ui/widgets/header.dart';
import 'package:samachar_hub/feature_horoscope/presentation/ui/widgets/horoscope_list_item.dart';
import 'package:samachar_hub/feature_horoscope/presentation/extensions/horoscope_extensions.dart';

class HoroscopeListBuilder extends StatelessWidget {
  const HoroscopeListBuilder({
    Key key,
    @required this.horoscopeUIModel,
    @required this.defaultSignIndex,
  })  : assert(horoscopeUIModel != null, 'Horoscope cannot be null'),
        assert(
            defaultSignIndex != null, 'Default horoscope sign cannot be null'),
        super(key: key);

  final HoroscopeUIModel horoscopeUIModel;
  final int defaultSignIndex;

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: const Duration(milliseconds: 300),
      child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          SizedBox(height: 8),
          Header(
            title: horoscopeUIModel.horoscopeEntity.title,
            context: context,
          ),
          SizedBox(height: 8),
          HoroscopeListItem(
            context: context,
            sign: horoscopeUIModel.horoscopeEntity
                .signByIndex(0, Language.NEPALI),
            zodiac: horoscopeUIModel.horoscopeEntity
                .horoscopeByIndex(0, Language.NEPALI),
            signIcon: 'https://www.ashesh.com.np/rashifal/images/1@2x.png',
            onTap: (sign, zodiac, signIcon) => context
                .repository<NavigationService>()
                .toHoroscopeDetail(context, sign, signIcon, zodiac,
                    horoscopeUIModel.horoscopeEntity),
          ),
          HoroscopeListItem(
            context: context,
            sign: horoscopeUIModel.horoscopeEntity
                .signByIndex(1, Language.NEPALI),
            zodiac: horoscopeUIModel.horoscopeEntity
                .horoscopeByIndex(1, Language.NEPALI),
            signIcon: 'https://www.ashesh.com.np/rashifal/images/2@2x.png',
            onTap: (sign, zodiac, signIcon) => context
                .repository<NavigationService>()
                .toHoroscopeDetail(context, sign, signIcon, zodiac,
                    horoscopeUIModel.horoscopeEntity),
          ),
          HoroscopeListItem(
            context: context,
            sign: horoscopeUIModel.horoscopeEntity
                .signByIndex(2, Language.NEPALI),
            zodiac: horoscopeUIModel.horoscopeEntity
                .horoscopeByIndex(2, Language.NEPALI),
            signIcon: 'https://www.ashesh.com.np/rashifal/images/3@2x.png',
            onTap: (sign, zodiac, signIcon) => context
                .repository<NavigationService>()
                .toHoroscopeDetail(context, sign, signIcon, zodiac,
                    horoscopeUIModel.horoscopeEntity),
          ),
          HoroscopeListItem(
            context: context,
            sign: horoscopeUIModel.horoscopeEntity
                .signByIndex(3, Language.NEPALI),
            zodiac: horoscopeUIModel.horoscopeEntity
                .horoscopeByIndex(3, Language.NEPALI),
            signIcon: 'https://www.ashesh.com.np/rashifal/images/4@2x.png',
            onTap: (sign, zodiac, signIcon) => context
                .repository<NavigationService>()
                .toHoroscopeDetail(context, sign, signIcon, zodiac,
                    horoscopeUIModel.horoscopeEntity),
          ),
          HoroscopeListItem(
            context: context,
            sign: horoscopeUIModel.horoscopeEntity
                .signByIndex(4, Language.NEPALI),
            zodiac: horoscopeUIModel.horoscopeEntity
                .horoscopeByIndex(4, Language.NEPALI),
            signIcon: 'https://www.ashesh.com.np/rashifal/images/5@2x.png',
            onTap: (sign, zodiac, signIcon) => context
                .repository<NavigationService>()
                .toHoroscopeDetail(context, sign, signIcon, zodiac,
                    horoscopeUIModel.horoscopeEntity),
          ),
          HoroscopeListItem(
            context: context,
            sign: horoscopeUIModel.horoscopeEntity
                .signByIndex(5, Language.NEPALI),
            zodiac: horoscopeUIModel.horoscopeEntity
                .horoscopeByIndex(5, Language.NEPALI),
            signIcon: 'https://www.ashesh.com.np/rashifal/images/6@2x.png',
            onTap: (sign, zodiac, signIcon) => context
                .repository<NavigationService>()
                .toHoroscopeDetail(context, sign, signIcon, zodiac,
                    horoscopeUIModel.horoscopeEntity),
          ),
          HoroscopeListItem(
            context: context,
            sign: horoscopeUIModel.horoscopeEntity
                .signByIndex(6, Language.NEPALI),
            zodiac: horoscopeUIModel.horoscopeEntity
                .horoscopeByIndex(6, Language.NEPALI),
            signIcon: 'https://www.ashesh.com.np/rashifal/images/7@2x.png',
            onTap: (sign, zodiac, signIcon) => context
                .repository<NavigationService>()
                .toHoroscopeDetail(context, sign, signIcon, zodiac,
                    horoscopeUIModel.horoscopeEntity),
          ),
          HoroscopeListItem(
            context: context,
            sign: horoscopeUIModel.horoscopeEntity
                .signByIndex(7, Language.NEPALI),
            zodiac: horoscopeUIModel.horoscopeEntity
                .horoscopeByIndex(7, Language.NEPALI),
            signIcon: 'https://www.ashesh.com.np/rashifal/images/8@2x.png',
            onTap: (sign, zodiac, signIcon) => context
                .repository<NavigationService>()
                .toHoroscopeDetail(context, sign, signIcon, zodiac,
                    horoscopeUIModel.horoscopeEntity),
          ),
          HoroscopeListItem(
            context: context,
            sign: horoscopeUIModel.horoscopeEntity
                .signByIndex(8, Language.NEPALI),
            zodiac: horoscopeUIModel.horoscopeEntity
                .horoscopeByIndex(8, Language.NEPALI),
            signIcon: 'https://www.ashesh.com.np/rashifal/images/9@2x.png',
            onTap: (sign, zodiac, signIcon) => context
                .repository<NavigationService>()
                .toHoroscopeDetail(context, sign, signIcon, zodiac,
                    horoscopeUIModel.horoscopeEntity),
          ),
          HoroscopeListItem(
            context: context,
            sign: horoscopeUIModel.horoscopeEntity
                .signByIndex(9, Language.NEPALI),
            zodiac: horoscopeUIModel.horoscopeEntity
                .horoscopeByIndex(9, Language.NEPALI),
            signIcon: 'https://www.ashesh.com.np/rashifal/images/10@2x.png',
            onTap: (sign, zodiac, signIcon) => context
                .repository<NavigationService>()
                .toHoroscopeDetail(context, sign, signIcon, zodiac,
                    horoscopeUIModel.horoscopeEntity),
          ),
          HoroscopeListItem(
            context: context,
            sign: horoscopeUIModel.horoscopeEntity
                .signByIndex(10, Language.NEPALI),
            zodiac: horoscopeUIModel.horoscopeEntity
                .horoscopeByIndex(10, Language.NEPALI),
            signIcon: 'https://www.ashesh.com.np/rashifal/images/11@2x.png',
            onTap: (sign, zodiac, signIcon) => context
                .repository<NavigationService>()
                .toHoroscopeDetail(context, sign, signIcon, zodiac,
                    horoscopeUIModel.horoscopeEntity),
          ),
          HoroscopeListItem(
            context: context,
            sign: horoscopeUIModel.horoscopeEntity
                .signByIndex(11, Language.NEPALI),
            zodiac: horoscopeUIModel.horoscopeEntity
                .horoscopeByIndex(11, Language.NEPALI),
            signIcon: 'https://www.ashesh.com.np/rashifal/images/12@2x.png',
            onTap: (sign, zodiac, signIcon) => context
                .repository<NavigationService>()
                .toHoroscopeDetail(context, sign, signIcon, zodiac,
                    horoscopeUIModel.horoscopeEntity),
          ),
        ],
      ),
    );
  }
}
