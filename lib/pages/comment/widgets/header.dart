import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:samachar_hub/stores/comment/comment_store.dart';

class Header extends StatelessWidget {
  const Header({
    Key key,
    @required this.context,
    @required this.store,
  }) : super(key: key);

  final BuildContext context;
  final CommentStore store;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: Observer(
        builder: (_) {
          return Text(
            store.postTitle,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyText1,
          );
        },
      ),
    );
  }
}
