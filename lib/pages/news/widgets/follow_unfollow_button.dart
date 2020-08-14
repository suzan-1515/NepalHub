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
  final int followerCount;
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
          style: Theme.of(context).textTheme.bodyText2,
        ),
        SizedBox(height: 4),
        isFollowed
            ? RaisedButton(
                visualDensity: VisualDensity.compact,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.check,
                      color: Theme.of(context).iconTheme.color.withOpacity(0.7),
                    ),
                    const SizedBox(width: 8.0),
                    Text('Following'),
                  ],
                ),
                textColor: Colors.white,
                color: Colors.grey,
                onPressed: () => onTap(isFollowed),
              )
            : RaisedButton(
                visualDensity: VisualDensity.compact,
                textColor: Colors.white,
                color: Colors.blue,
                child: Text('Follow'),
                onPressed: () => onTap(isFollowed),
              ),
      ],
    );
  }
}
