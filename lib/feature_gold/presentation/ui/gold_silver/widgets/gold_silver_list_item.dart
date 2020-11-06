import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_gold/presentation/models/gold_silver_model.dart';
import 'package:samachar_hub/feature_gold/presentation/extensions/gold_silver_extensions.dart';
import 'package:scoped_model/scoped_model.dart';

class GoldSilverListItem extends StatelessWidget {
  const GoldSilverListItem({
    Key key,
    @required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    final goldSilver = ScopedModel.of<GoldSilverUIModel>(context);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => GetIt.I
            .get<NavigationService>()
            .toGoldSilverDetailScreen(context, goldSilver),
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
                  goldSilver.entity.category.icon,
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
                '${goldSilver.entity.category.title}',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 2,
              child: Text(
                goldSilver.entity.unit.label,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 2,
              child: Text(goldSilver.entity.formatttedPrice,
                  style: Theme.of(context).textTheme.bodyText2),
            ),
          ],
        ),
      ),
    );
  }
}
