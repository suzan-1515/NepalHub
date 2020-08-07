import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/services/services.dart';

class HoroscopeListItem extends StatelessWidget {
  const HoroscopeListItem({
    Key key,
    @required this.data,
    @required this.context,
    @required this.sign,
    @required this.zodiac,
    @required this.signIcon,
  }) : super(key: key);

  final HoroscopeModel data;
  final BuildContext context;
  final String sign;
  final String zodiac;
  final String signIcon;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      child: ListTile(
        onTap: () => context
            .read<NavigationService>()
            .toHoroscopeDetail(context, sign, signIcon, zodiac, data),
        leading: Hero(
          tag: sign,
          child: CircleAvatar(
            backgroundColor: Theme.of(context).canvasColor,
            backgroundImage: CachedNetworkImageProvider(
              signIcon,
              errorListener: () {},
            ),
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
}
