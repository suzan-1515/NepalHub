import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/feature_horoscope/domain/entities/horoscope_entity.dart';
import 'package:samachar_hub/feature_horoscope/presentation/models/horoscope_model.dart';
import 'package:samachar_hub/feature_horoscope/presentation/ui/detail/horoscope_detail_screen.dart';
import 'package:samachar_hub/feature_horoscope/presentation/ui/horoscope/widgets/header.dart';
import 'package:samachar_hub/feature_horoscope/presentation/ui/horoscope/widgets/horoscope_list_item.dart';
import 'package:samachar_hub/feature_horoscope/presentation/extensions/horoscope_extensions.dart';
import 'package:samachar_hub/feature_horoscope/presentation/ui/horoscope_detail_screen_arguments.dart';

class HoroscopeListBuilder extends StatelessWidget {
  const HoroscopeListBuilder({
    Key key,
    @required this.horoscopeUIModel,
  })  : assert(horoscopeUIModel != null, 'Horoscope cannot be null'),
        super(key: key);

  final HoroscopeUIModel horoscopeUIModel;

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: const Duration(milliseconds: 300),
      child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          SizedBox(height: 8),
          Header(
            title: horoscopeUIModel.entity.title,
            context: context,
          ),
          SizedBox(height: 8),
          HoroscopeListItem(
            context: context,
            sign: horoscopeUIModel.entity.signByIndex(0, Language.NEPALI),
            zodiac:
                horoscopeUIModel.entity.horoscopeByIndex(0, Language.NEPALI),
            signIcon: HOROSCOPE_ICONS[0],
            onTap: (sign, zodiac, signIcon) => Navigator.pushNamed(
              context,
              HoroscopeDetailScreen.ROUTE_NAME,
              arguments: HoroscopeDetailScreenArgs(horoscopeUIModel, 0),
            ),
          ),
          HoroscopeListItem(
            context: context,
            sign: horoscopeUIModel.entity.signByIndex(1, Language.NEPALI),
            zodiac:
                horoscopeUIModel.entity.horoscopeByIndex(1, Language.NEPALI),
            signIcon: HOROSCOPE_ICONS[1],
            onTap: (sign, zodiac, signIcon) => Navigator.pushNamed(
              context,
              HoroscopeDetailScreen.ROUTE_NAME,
              arguments: HoroscopeDetailScreenArgs(horoscopeUIModel, 1),
            ),
          ),
          HoroscopeListItem(
            context: context,
            sign: horoscopeUIModel.entity.signByIndex(2, Language.NEPALI),
            zodiac:
                horoscopeUIModel.entity.horoscopeByIndex(2, Language.NEPALI),
            signIcon: HOROSCOPE_ICONS[2],
            onTap: (sign, zodiac, signIcon) => Navigator.pushNamed(
              context,
              HoroscopeDetailScreen.ROUTE_NAME,
              arguments: HoroscopeDetailScreenArgs(horoscopeUIModel, 2),
            ),
          ),
          HoroscopeListItem(
            context: context,
            sign: horoscopeUIModel.entity.signByIndex(3, Language.NEPALI),
            zodiac:
                horoscopeUIModel.entity.horoscopeByIndex(3, Language.NEPALI),
            signIcon: HOROSCOPE_ICONS[3],
            onTap: (sign, zodiac, signIcon) => Navigator.pushNamed(
              context,
              HoroscopeDetailScreen.ROUTE_NAME,
              arguments: HoroscopeDetailScreenArgs(horoscopeUIModel, 3),
            ),
          ),
          HoroscopeListItem(
            context: context,
            sign: horoscopeUIModel.entity.signByIndex(4, Language.NEPALI),
            zodiac:
                horoscopeUIModel.entity.horoscopeByIndex(4, Language.NEPALI),
            signIcon: HOROSCOPE_ICONS[4],
            onTap: (sign, zodiac, signIcon) => Navigator.pushNamed(
              context,
              HoroscopeDetailScreen.ROUTE_NAME,
              arguments: HoroscopeDetailScreenArgs(horoscopeUIModel, 4),
            ),
          ),
          HoroscopeListItem(
            context: context,
            sign: horoscopeUIModel.entity.signByIndex(5, Language.NEPALI),
            zodiac:
                horoscopeUIModel.entity.horoscopeByIndex(5, Language.NEPALI),
            signIcon: HOROSCOPE_ICONS[5],
            onTap: (sign, zodiac, signIcon) => Navigator.pushNamed(
              context,
              HoroscopeDetailScreen.ROUTE_NAME,
              arguments: HoroscopeDetailScreenArgs(horoscopeUIModel, 5),
            ),
          ),
          HoroscopeListItem(
            context: context,
            sign: horoscopeUIModel.entity.signByIndex(6, Language.NEPALI),
            zodiac:
                horoscopeUIModel.entity.horoscopeByIndex(6, Language.NEPALI),
            signIcon: HOROSCOPE_ICONS[6],
            onTap: (sign, zodiac, signIcon) => Navigator.pushNamed(
              context,
              HoroscopeDetailScreen.ROUTE_NAME,
              arguments: HoroscopeDetailScreenArgs(horoscopeUIModel, 6),
            ),
          ),
          HoroscopeListItem(
            context: context,
            sign: horoscopeUIModel.entity.signByIndex(7, Language.NEPALI),
            zodiac:
                horoscopeUIModel.entity.horoscopeByIndex(7, Language.NEPALI),
            signIcon: HOROSCOPE_ICONS[7],
            onTap: (sign, zodiac, signIcon) => Navigator.pushNamed(
              context,
              HoroscopeDetailScreen.ROUTE_NAME,
              arguments: HoroscopeDetailScreenArgs(horoscopeUIModel, 7),
            ),
          ),
          HoroscopeListItem(
            context: context,
            sign: horoscopeUIModel.entity.signByIndex(8, Language.NEPALI),
            zodiac:
                horoscopeUIModel.entity.horoscopeByIndex(8, Language.NEPALI),
            signIcon: HOROSCOPE_ICONS[8],
            onTap: (sign, zodiac, signIcon) => Navigator.pushNamed(
              context,
              HoroscopeDetailScreen.ROUTE_NAME,
              arguments: HoroscopeDetailScreenArgs(horoscopeUIModel, 8),
            ),
          ),
          HoroscopeListItem(
            context: context,
            sign: horoscopeUIModel.entity.signByIndex(9, Language.NEPALI),
            zodiac:
                horoscopeUIModel.entity.horoscopeByIndex(9, Language.NEPALI),
            signIcon: HOROSCOPE_ICONS[9],
            onTap: (sign, zodiac, signIcon) => Navigator.pushNamed(
              context,
              HoroscopeDetailScreen.ROUTE_NAME,
              arguments: HoroscopeDetailScreenArgs(horoscopeUIModel, 9),
            ),
          ),
          HoroscopeListItem(
            context: context,
            sign: horoscopeUIModel.entity.signByIndex(10, Language.NEPALI),
            zodiac:
                horoscopeUIModel.entity.horoscopeByIndex(10, Language.NEPALI),
            signIcon: HOROSCOPE_ICONS[10],
            onTap: (sign, zodiac, signIcon) => Navigator.pushNamed(
              context,
              HoroscopeDetailScreen.ROUTE_NAME,
              arguments: HoroscopeDetailScreenArgs(horoscopeUIModel, 10),
            ),
          ),
          HoroscopeListItem(
            context: context,
            sign: horoscopeUIModel.entity.signByIndex(11, Language.NEPALI),
            zodiac:
                horoscopeUIModel.entity.horoscopeByIndex(11, Language.NEPALI),
            signIcon: HOROSCOPE_ICONS[11],
            onTap: (sign, zodiac, signIcon) => Navigator.pushNamed(
              context,
              HoroscopeDetailScreen.ROUTE_NAME,
              arguments: HoroscopeDetailScreenArgs(horoscopeUIModel, 11),
            ),
          ),
        ],
      ),
    );
  }
}
