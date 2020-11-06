import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';

class CommentBarPlaceholder extends StatelessWidget {
  const CommentBarPlaceholder({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).highlightColor,
      highlightColor: Theme.of(context).backgroundColor,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
                  color: Theme.of(context).dividerColor, width: 0.5)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
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
                      backgroundColor:
                          Theme.of(context).primaryColor.withOpacity(0.3),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      '',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 48,
              height: 48,
            ),
            SizedBox(
              width: 48,
              height: 48,
            ),
            SizedBox(
              width: 48,
              height: 48,
            ),
          ],
        ),
      ),
    );
  }
}
