import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samachar_hub/core/widgets/icon_badge_widget.dart';

class CommentBar extends StatelessWidget {
  final VoidCallback onLikeTap;
  final VoidCallback onShareTap;
  final VoidCallback onCommentTap;
  final String commentCount;
  final bool isLiked;
  final String likeCount;
  final String shareCount;
  final String userAvatar;

  CommentBar({
    Key key,
    @required this.onLikeTap,
    @required this.onCommentTap,
    @required this.onShareTap,
    @required this.commentCount,
    @required this.likeCount,
    @required this.shareCount,
    @required this.userAvatar,
    @required this.isLiked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
            top: BorderSide(color: Theme.of(context).dividerColor, width: 0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: onCommentTap,
              child: Container(
                height: 34,
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 12,
                      backgroundImage:
                          (userAvatar == null || userAvatar.isEmpty)
                              ? AssetImage('assets/images/user.png')
                              : AdvancedNetworkImage(userAvatar),
                      backgroundColor:
                          Theme.of(context).primaryColor.withOpacity(0.3),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      '$commentCount Comments',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ),
            ),
          ),
          IconBadge(
            iconData: FontAwesomeIcons.comment,
            badgeText: commentCount,
            onTap: onCommentTap,
          ),
          IconBadge(
            iconData: isLiked
                ? FontAwesomeIcons.solidThumbsUp
                : FontAwesomeIcons.thumbsUp,
            badgeText: likeCount,
            onTap: onLikeTap,
          ),
          (shareCount != null)
              ? IconBadge(
                  iconData: FontAwesomeIcons.shareAlt,
                  badgeText: shareCount,
                  onTap: onShareTap,
                )
              : IconButton(
                  icon: Icon(
                    FontAwesomeIcons.shareAlt,
                    size: 16,
                  ),
                  onPressed: onShareTap,
                ),
        ],
      ),
    );
  }
}
