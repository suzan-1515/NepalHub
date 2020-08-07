import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/stores/comment/comment_store.dart';
import 'package:samachar_hub/stores/stores.dart';

class LikeAndCommentStats extends StatelessWidget {
  const LikeAndCommentStats({
    Key key,
    @required this.context,
    @required this.store,
  }) : super(key: key);

  final BuildContext context;
  final CommentStore store;

  @override
  Widget build(BuildContext context) {
    return Consumer<PostMetaStore>(
      builder: (_, metaStore, child) => Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Observer(
              builder: (_) {
                return Text(
                  '${metaStore.postMeta?.commentCount ?? 0} Comments',
                  style: Theme.of(context).textTheme.bodyText2,
                );
              },
            ),
            SizedBox(
              width: 8,
            ),
            Observer(
              builder: (_) {
                return Text(
                  '${metaStore.postMeta?.likeCount ?? 0} Likes',
                  style: Theme.of(context).textTheme.bodyText2,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
