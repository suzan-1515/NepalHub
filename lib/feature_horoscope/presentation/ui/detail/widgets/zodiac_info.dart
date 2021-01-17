import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/feature_horoscope/domain/entities/horoscope_entity.dart';
import 'package:samachar_hub/feature_horoscope/presentation/extensions/horoscope_extensions.dart';
import 'package:samachar_hub/feature_horoscope/presentation/models/horoscope_model.dart';
import 'package:scoped_model/scoped_model.dart';

class ZodiacInfo extends StatelessWidget {
  const ZodiacInfo({Key key, @required this.signIndex}) : super(key: key);

  final int signIndex;

  @override
  Widget build(BuildContext context) {
    final horoscopeUIModel =
        ScopedModel.of<HoroscopeUIModel>(context, rebuildOnChange: true);
    return SingleChildScrollView(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Hero(
            tag: HOROSCOPE_SIGNS[Language.NEPALI][signIndex],
            child: CircleAvatar(
              backgroundColor: Theme.of(context).canvasColor,
              backgroundImage:
                  CachedNetworkImageProvider(HOROSCOPE_ICONS[signIndex]),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                  text: HOROSCOPE_SIGNS[Language.NEPALI][signIndex],
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(fontWeight: FontWeight.w700),
                  children: [
                    TextSpan(
                        text:
                            '\n${horoscopeUIModel.entity.publishedAt.formattedString}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(fontStyle: FontStyle.italic)),
                    TextSpan(
                        text:
                            '\n\n${horoscopeUIModel.entity.horoscopeByIndex(signIndex, Language.NEPALI)}',
                        style: Theme.of(context).textTheme.subtitle1),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
