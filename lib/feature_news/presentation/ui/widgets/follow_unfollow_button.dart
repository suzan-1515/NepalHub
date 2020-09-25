import 'package:flutter/material.dart';

class FollowUnFollowButton extends StatelessWidget {
  const FollowUnFollowButton({
    Key key,
    @required this.isFollowed,
    @required this.onTap,
  })  : assert(isFollowed != null),
        assert(onTap != null),
        super(key: key);

  final bool isFollowed;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      visualDensity: VisualDensity.compact,
      color: isFollowed ? Colors.blue : null,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(6),
            right: Radius.circular(6),
          )),
      onPressed: onTap,
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
    );
  }
}
