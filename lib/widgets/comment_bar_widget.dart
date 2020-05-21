import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samachar_hub/widgets/icon_badge_widget.dart';

class CommentBar extends StatefulWidget {
  final String userProfileImageUrl;

  final ValueNotifier<bool> likeNotifier;
  final Function(bool) onLikeTap;
  final VoidCallback onCommentTap;
  final VoidCallback onShareTap;
  final String commentBadgeText;
  final String likeBagdeText;
  const CommentBar({
    Key key,
    this.userProfileImageUrl,
    @required this.likeNotifier,
    @required this.onLikeTap,
    @required this.onCommentTap,
    @required this.onShareTap,
    @required this.commentBadgeText,
    @required this.likeBagdeText,
  }) : super(key: key);

  @override
  _CommentBarState createState() => _CommentBarState();
}

class _CommentBarState extends State<CommentBar> {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
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
                  backgroundImage: CachedNetworkImageProvider(
                      widget.userProfileImageUrl ?? '',
                      errorListener: () {}),
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(0.3),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  'Comment',
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ),
        ),
        IconBadge(
            context: context,
            iconData: FontAwesomeIcons.comment,
            badgeText: widget.commentBadgeText,
            onTap: widget.onCommentTap),
        ValueListenableBuilder<bool>(
            valueListenable: widget.likeNotifier,
            builder: (BuildContext context, bool value, Widget child) {
              return IconBadge(
                  context: context,
                  iconData: value
                      ? FontAwesomeIcons.solidThumbsUp
                      : FontAwesomeIcons.thumbsUp,
                  badgeText: widget.likeBagdeText,
                  onTap: () => widget.onLikeTap(value));
            }),
        IconButton(
          icon: Icon(
            FontAwesomeIcons.shareAlt,
            size: 16,
          ),
          onPressed: widget.onShareTap,
        ),
      ],
    );
  }
}
