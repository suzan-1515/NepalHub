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
  final Function(bool) onTap;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      visualDensity: VisualDensity.compact,
      textColor: Colors.white,
      color: isFollowed ? Colors.grey : Colors.blue,
      child: Text(isFollowed ? 'Followed' : 'Follow'),
      onPressed: () => onTap(isFollowed),
    );
  }
}
