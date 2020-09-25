import 'package:flutter/material.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/follow_unfollow_button.dart';

class NewsFilterHeader extends StatelessWidget {
  const NewsFilterHeader({
    Key key,
    @required this.title,
    @required this.icon,
    @required this.isFollowed,
    @required this.onTap,
  }) : super(key: key);

  final String title;
  final DecorationImage icon;
  final bool isFollowed;
  final VoidCallback onTap;

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
          FollowUnFollowButton(isFollowed: isFollowed, onTap: onTap),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
