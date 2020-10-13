import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/feature_comment/presentation/blocs/like_unlike/like_unlike_bloc.dart';
import 'package:samachar_hub/feature_comment/presentation/models/comment_model.dart';

class CommentListItem extends StatelessWidget {
  const CommentListItem({
    Key key,
    @required this.commentUIModel,
  }) : super(key: key);

  final CommentUIModel commentUIModel;

  @override
  Widget build(BuildContext context) {
    final hasAvatar = (commentUIModel.comment.user.avatar != null &&
        commentUIModel.comment.user.avatar.isNotEmpty);
    return Material(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).backgroundColor,
          backgroundImage: hasAvatar
              ? NetworkImage(commentUIModel.comment.user.avatar)
              : Image.asset('/assets/images/user.png'),
        ),
        title: RichText(
          text: TextSpan(
              text: '${commentUIModel.comment.user.fullname}',
              style: Theme.of(context).textTheme.bodyText1,
              children: <TextSpan>[
                TextSpan(
                    text: '\n${commentUIModel.publishedDateMomentAgo}',
                    style: Theme.of(context).textTheme.caption)
              ]),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            commentUIModel.comment.comment,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
        trailing: BlocBuilder<LikeUnlikeBloc, LikeUnlikeState>(
          builder: (context, state) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    commentUIModel.comment.isLiked
                        ? FontAwesomeIcons.solidThumbsUp
                        : FontAwesomeIcons.thumbsUp,
                  ),
                  onPressed: () {
                    if (commentUIModel.comment.isLiked) {
                      commentUIModel.unlike();
                      context.bloc<LikeUnlikeBloc>().add(UnlikeEvent());
                    } else {
                      commentUIModel.like();
                      context.bloc<LikeUnlikeBloc>().add(LikeEvent());
                    }
                  },
                ),
                Text(
                  '${commentUIModel.formattedLikeCount}',
                  style: Theme.of(context).textTheme.overline,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
