import 'package:flutter/material.dart';

class NewsFilterHeader extends StatelessWidget {
  const NewsFilterHeader({
    Key key,
    @required this.title,
    @required this.icon,
    @required this.followUnFollowButton,
  }) : super(key: key);

  final String title;
  final DecorationImage icon;
  final Widget followUnFollowButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Theme.of(context).cardColor,
                image: icon,
                border: Border.all(color: Theme.of(context).dividerColor)),
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .subtitle1
                .copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8),
          followUnFollowButton,
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
