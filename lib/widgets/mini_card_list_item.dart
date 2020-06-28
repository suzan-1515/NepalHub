import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MiniCardListItem extends StatelessWidget {
  const MiniCardListItem({
    Key key,
    @required this.context,
    @required this.name,
    @required this.icon,
    @required this.onTap,
  }) : super(key: key);

  final BuildContext context;
  final String name;
  final String icon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: CachedNetworkImage(
                imageUrl: icon,
                errorWidget: (context, url, error) => Opacity(
                    opacity: 0.7,
                    child: Icon(FontAwesomeIcons.exclamationCircle)),
                progressIndicatorBuilder: (context, url, progress) =>
                    Center(child: CircularProgressIndicator()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name,
                style: Theme.of(context).textTheme.subtitle2.copyWith(
                    color: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .color
                        .withOpacity(.6)),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
