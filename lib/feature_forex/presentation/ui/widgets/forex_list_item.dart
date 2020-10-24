import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_forex/presentation/models/forex_model.dart';

class ForexListItem extends StatelessWidget {
  const ForexListItem({
    Key key,
    @required this.context,
    @required this.data,
  }) : super(key: key);

  final BuildContext context;
  final ForexUIModel data;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => GetIt.I
            .get<NavigationService>()
            .toForexDetailScreen(context, data.forexEntity),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: TransitionToImage(
                width: 24,
                height: 24,
                image: AdvancedNetworkImage(
                  data.forexEntity.currency.icon,
                  useDiskCache: true,
                  cacheRule: CacheRule(maxAge: const Duration(days: 3)),
                ),
                fit: BoxFit.contain,
                loadingWidgetBuilder: (context, progress, imageData) =>
                    Icon(FontAwesomeIcons.image),
                placeholderBuilder: (context, reloadImage) =>
                    Icon(FontAwesomeIcons.image),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              flex: 3,
              child: Text(
                '${data.forexEntity.currency.title} (${data.forexEntity.currency.code})',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: Text(
                data.forexEntity.unit.toString(),
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: Text(data.forexEntity.buying.toString(),
                  style: Theme.of(context).textTheme.bodyText2),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: Text(data.forexEntity.selling.toString(),
                  style: Theme.of(context).textTheme.bodyText2),
            ),
          ],
        ),
      ),
    );
  }
}
