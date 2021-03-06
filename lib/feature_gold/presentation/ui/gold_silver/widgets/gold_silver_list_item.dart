import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samachar_hub/core/extensions/number_extensions.dart';
import 'package:samachar_hub/feature_gold/presentation/extensions/gold_silver_extensions.dart';
import 'package:samachar_hub/feature_gold/presentation/models/gold_silver_model.dart';
import 'package:samachar_hub/feature_gold/presentation/ui/details/gold_silver_detail_screen.dart';
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
        onTap: () => Navigator.pushNamed(
            context, GoldSilverDetailScreen.ROUTE_NAME,
            arguments: goldSilver),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: CachedNetworkImage(
                width: 24,
                height: 24,
                imageUrl: goldSilver.entity.category.icon,
                fit: BoxFit.contain,
                progressIndicatorBuilder: (context, progress, imageData) =>
                    Icon(FontAwesomeIcons.image),
                placeholder: (context, reloadImage) =>
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
              child: Text(goldSilver.entity.price.formattedString,
                  style: Theme.of(context).textTheme.bodyText2),
            ),
          ],
        ),
      ),
    );
  }
}
