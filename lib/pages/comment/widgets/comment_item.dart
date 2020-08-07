import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/stores/comment/comment_store.dart';

class CommentListItem extends StatefulWidget {
  const CommentListItem({
    Key key,
    @required this.context,
    @required this.data,
    @required this.store,
  }) : super(key: key);

  final BuildContext context;
  final CommentModel data;
  final CommentStore store;

  @override
  _CommentListItemState createState() => _CommentListItemState();
}

class _CommentListItemState extends State<CommentListItem> {
  final ValueNotifier<bool> _likeProgressNotifier = ValueNotifier<bool>(false);
  @override
  void dispose() {
    _likeProgressNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).backgroundColor,
          backgroundImage: NetworkImage(widget.data.user.avatar),
        ),
        title: RichText(
          text: TextSpan(
              text: '${widget.data.user.fullName}',
              style: Theme.of(context).textTheme.bodyText1,
              children: <TextSpan>[
                TextSpan(
                    text: '\n${widget.data.updatedAt}',
                    style: Theme.of(context).textTheme.caption)
              ]),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            widget.data.comment,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
        trailing: ValueListenableBuilder<bool>(
          builder: (_, bool value, __) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ValueListenableBuilder<bool>(
                  valueListenable: _likeProgressNotifier,
                  builder: (context, likeInProfress, child) => AbsorbPointer(
                    absorbing: likeInProfress,
                    child: IconButton(
                      icon: Icon(
                        value
                            ? FontAwesomeIcons.solidThumbsUp
                            : FontAwesomeIcons.thumbsUp,
                      ),
                      onPressed: () {
                        _likeProgressNotifier.value = true;
                        final currentValue = value;
                        widget.data.like = !value;
                        if (currentValue) {
                          widget.store
                              .unlikeComment(comment: widget.data)
                              .catchError(
                                  (onError) => widget.data.like = currentValue)
                              .whenComplete(
                                  () => _likeProgressNotifier.value = false);
                        } else {
                          widget.store
                              .likeComment(comment: widget.data)
                              .catchError(
                                  (onError) => widget.data.like = currentValue)
                              .whenComplete(
                                  () => _likeProgressNotifier.value = false);
                        }
                      },
                    ),
                  ),
                ),
                Text(
                  widget.data.likesCount == 0
                      ? ''
                      : '${widget.data.likesCount}',
                  style: Theme.of(context).textTheme.overline,
                ),
              ],
            );
          },
          valueListenable: widget.data.likeNotifier,
        ),
      ),
    );
  }
}
