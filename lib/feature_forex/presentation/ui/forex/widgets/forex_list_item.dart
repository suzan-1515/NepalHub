import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_forex/presentation/models/forex_model.dart';
import 'package:scoped_model/scoped_model.dart';

class ForexListItem extends StatelessWidget {
  const ForexListItem({
    Key key,
    @required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    final forex = ScopedModel.of<ForexUIModel>(context, rebuildOnChange: true);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => GetIt.I
            .get<NavigationService>()
            .toForexDetailScreen(context, forex),
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
                  forex.entity.currency.icon,
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
                '${forex.entity.currency.title} (${forex.entity.currency.code})',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: Text(
                forex.entity.unit.toString(),
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: Text(forex.entity.buying.toString(),
                  style: Theme.of(context).textTheme.bodyText2),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: Text(forex.entity.selling.toString(),
                  style: Theme.of(context).textTheme.bodyText2),
            ),
          ],
        ),
      ),
    );
  }
}
