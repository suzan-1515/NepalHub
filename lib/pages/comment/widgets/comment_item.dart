import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/pages/comment/comment_store.dart';

class CommentItem extends StatefulWidget {
  const CommentItem({
    Key key,
    @required this.context,
    @required this.data,
    @required this.store,
  }) : super(key: key);

  final BuildContext context;
  final CommentModel data;
  final CommentStore store;

  @override
  _CommentItemState createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  final ValueNotifier<bool> _likeNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
  }  

  @override
  void dispose() {
    _likeNotifier.dispose();
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
                IconButton(
                  icon: Icon(
                    value
                        ? FontAwesomeIcons.solidThumbsUp
                        : FontAwesomeIcons.thumbsUp,
                  ),
                  onPressed: () {
                    if (value) {
                      _likeNotifier.value = false;
                      widget.store
                          .unlikeComment(comment: widget.data)
                          .then((value) {
                        _likeNotifier.value = !value;
                      });
                    } else {
                      _likeNotifier.value = true;
                      widget.store
                          .likeComment(comment: widget.data)
                          .then((value) {
                        _likeNotifier.value = value;
                      });
                    }
                  },
                ),
                Text(
                  widget.data.likesCount==0?'':'${widget.data.likesCount}',
                  style: Theme.of(context).textTheme.overline,
                ),
              ],
            );
          },
          valueListenable: _likeNotifier,
        ),
      ),
    );
  }
}
