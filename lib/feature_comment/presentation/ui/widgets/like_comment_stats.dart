import 'package:flutter/material.dart';

class LikeAndCommentStats extends StatelessWidget {
  const LikeAndCommentStats({
    Key key,
    @required this.likeCount,
    @required this.commentCount,
  }) : super(key: key);

  final int likeCount;
  final int commentCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            '$commentCount Comments',
            style: Theme.of(context).textTheme.bodyText2,
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            '$likeCount Likes',
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}
