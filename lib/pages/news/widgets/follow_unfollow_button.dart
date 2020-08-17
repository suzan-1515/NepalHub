import 'package:flutter/material.dart';

class FollowUnFollowButton extends StatelessWidget {
  const FollowUnFollowButton({
    Key key,
    @required this.isFollowed,
    @required this.onTap,
    @required this.followerCount,
  })  : assert(isFollowed != null),
        assert(onTap != null),
        super(key: key);

  final bool isFollowed;
  final String followerCount;
  final Function(bool) onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          '$followerCount followers',
          style: Theme.of(context).textTheme.caption,
        ),
        SizedBox(height: 4),
        FlatButton(
          visualDensity: VisualDensity.compact,
          color: isFollowed ? Colors.blue : null,
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.blue),
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(6),
                right: Radius.circular(6),
              )),
          onPressed: () => onTap(isFollowed),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isFollowed ? Icons.star : Icons.star_border,
                color: isFollowed ? Colors.white : Colors.blue,
                size: 14,
              ),
              SizedBox(width: 4),
              Text(
                isFollowed ? 'Following' : 'Follow',
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(color: isFollowed ? Colors.white : Colors.blue),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
