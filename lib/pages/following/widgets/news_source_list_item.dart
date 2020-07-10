import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FollowedNewsSourceListItem extends StatelessWidget {
  const FollowedNewsSourceListItem({
    Key key,
    @required this.title,
    @required this.icon,
    @required this.followers,
    @required this.isSubscribed,
    @required this.onTap,
    @required this.onFollowTap,
  }) : super(key: key);

  final String title;
  final String icon;
  final int followers;
  final bool isSubscribed;
  final Function onTap;
  final Function onFollowTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        onTap: onTap,
        leading: Container(
          width: 84,
          height: 84,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 1.0,
                ),
              ],
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.all(Radius.circular(6))),
          child: CachedNetworkImage(
            imageUrl: icon,
            errorWidget: (context, url, error) => Opacity(
                opacity: 0.7, child: Icon(FontAwesomeIcons.exclamationCircle)),
            progressIndicatorBuilder: (context, url, progress) =>
                Center(child: CircularProgressIndicator()),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .subtitle1
                .copyWith(fontWeight: FontWeight.w500),
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                '$followers Followers',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              ActionChip(
                backgroundColor: isSubscribed
                    ? Theme.of(context).canvasColor
                    : Theme.of(context).accentColor,
                avatar: Icon(Icons.check),
                label: Text(
                  isSubscribed ? 'UnFollow' : 'Follow',
                  style: Theme.of(context).textTheme.button,
                ),
                onPressed: onFollowTap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
