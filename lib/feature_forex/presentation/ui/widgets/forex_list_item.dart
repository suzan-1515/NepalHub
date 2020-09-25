import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/data/models/models.dart';

class ForexListItem extends StatelessWidget {
  const ForexListItem({
    Key key,
    @required this.context,
    @required this.data,
  }) : super(key: key);

  final BuildContext context;
  final ForexModel data;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => context
            .read<NavigationService>()
            .toForexDetailScreen(context, data),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: SvgPicture.network(
                'https://www.ashesh.com.np/forex/flag/${data.code}.svg',
                placeholderBuilder: (_) {
                  return Container(
                    width: 32,
                    height: 32,
                    color: Theme.of(context).cardColor,
                  );
                },
                width: 32,
                height: 32,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              flex: 3,
              child: Text(
                '${data.currency} (${data.code})',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: Text(
                data.unit.toString(),
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: Text(data.buying.toString(),
                  style: Theme.of(context).textTheme.bodyText2),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: Text(data.selling.toString(),
                  style: Theme.of(context).textTheme.bodyText2),
            ),
          ],
        ),
      ),
    );
  }
}
