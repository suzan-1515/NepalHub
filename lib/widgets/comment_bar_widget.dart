import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samachar_hub/widgets/icon_badge_widget.dart';

class CommentBar extends StatelessWidget {
  final String userProfileImageUrl;

  final Function(bool) onLikeTap;
  final VoidCallback onCommentTap;
  final VoidCallback onShareTap;
  final ValueNotifier<bool> likeNotifier;
  final ValueNotifier<int> likeCountNotifier;
  final ValueNotifier<int> commentCountNotifier;

  CommentBar({
    Key key,
    this.userProfileImageUrl,
    @required this.likeNotifier,
    @required this.onLikeTap,
    @required this.onCommentTap,
    @required this.onShareTap,
    @required this.commentCountNotifier,
    @required this.likeCountNotifier,
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
              onTap: () => onCommentTap(),
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
                      backgroundImage: (userProfileImageUrl == null ||
                              userProfileImageUrl.isEmpty)
                          ? AssetImage('assets/images/user.png')
                          : CachedNetworkImageProvider(userProfileImageUrl,
                              errorListener: () {}),
                      backgroundColor:
                          Theme.of(context).primaryColor.withOpacity(0.3),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    ValueListenableBuilder<int>(
                      valueListenable: commentCountNotifier,
                      builder: (context, value, child) => Text(
                        '$value Comments',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ValueListenableBuilder<int>(
            valueListenable: commentCountNotifier,
            builder: (context, value, child) => IconBadge(
                iconData: FontAwesomeIcons.comment,
                badgeText: value?.toString() ?? '0',
                onTap: () => onCommentTap()),
          ),
          ValueListenableBuilder<bool>(
            valueListenable: likeNotifier,
            builder: (context, value, child) => IconBadge(
              iconData: value
                  ? FontAwesomeIcons.solidThumbsUp
                  : FontAwesomeIcons.thumbsUp,
              badgeText: likeCountNotifier.value?.toString() ?? '0',
              onTap: () => onLikeTap(value),
            ),
          ),
          IconButton(
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
