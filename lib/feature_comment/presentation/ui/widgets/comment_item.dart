import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:samachar_hub/core/services/navigation_service.dart';
import 'package:samachar_hub/feature_auth/presentation/blocs/auth_bloc.dart';
import 'package:samachar_hub/feature_comment/domain/entities/thread_type.dart';
import 'package:samachar_hub/feature_comment/presentation/blocs/comment_bloc.dart';
import 'package:samachar_hub/feature_comment/presentation/blocs/delete/delete_cubit.dart';
import 'package:samachar_hub/feature_comment/presentation/blocs/like_unlike/like_unlike_bloc.dart';
import 'package:samachar_hub/feature_comment/presentation/models/comment_model.dart';
import 'package:samachar_hub/core/extensions/date_time.dart';
import 'package:samachar_hub/core/extensions/number_extensions.dart';
import 'package:samachar_hub/core/extensions/view.dart';
import 'package:samachar_hub/feature_comment/presentation/ui/widgets/comment_delete_comfirmation_dialog.dart';
import 'package:samachar_hub/feature_report/domain/entities/report_thread_type.dart';
import 'package:samachar_hub/feature_report/presentation/ui/report.dart';
import 'package:scoped_model/scoped_model.dart';

class CommentListItem extends StatelessWidget {
  const CommentListItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final comment =
        ScopedModel.of<CommentUIModel>(context, rebuildOnChange: true);
    final user = context.watch<AuthBloc>().currentUser;
    final hasAvatar = (comment.entity.user.avatar != null &&
        comment.entity.user.avatar.isNotEmpty);
    final isReply =
        (context.watch<CommentBloc>().threadType == CommentThreadType.COMMENT);
    return Material(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).backgroundColor,
          backgroundImage: hasAvatar
              ? NetworkImage(comment.entity.user.avatar)
              : Image.asset('/assets/images/user.png'),
        ),
        title: RichText(
          text: TextSpan(
              text: '${comment.entity.user.fullname}',
              style: Theme.of(context).textTheme.bodyText1,
              children: <TextSpan>[
                TextSpan(
                    text: '\n${comment.entity.updatedAt.momentAgo}',
                    style: Theme.of(context).textTheme.caption)
              ]),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CommentView(comment: comment.entity.comment),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    child: Icon(
                      comment.entity.isLiked
                          ? Icons.thumb_up
                          : LineAwesomeIcons.thumbs_up,
                      size: 16,
                      color: Theme.of(context).iconTheme.color.withOpacity(0.4),
                    ),
                    onTap: () {
                      if (comment.entity.isLiked) {
                        comment.unlike();
                        context
                            .read<CommentLikeUnlikeBloc>()
                            .add(CommentUnlikeEvent(comment: comment.entity));
                      } else {
                        comment.like();
                        context
                            .read<CommentLikeUnlikeBloc>()
                            .add(CommentLikeEvent(comment: comment.entity));
                      }
                    },
                  ),
                  SizedBox(width: 4),
                  if (comment.entity.likeCount != 0)
                    Text(
                      '${comment.entity.likeCount.compactFormat}',
                      style: Theme.of(context).textTheme.overline,
                    ),
                  if (!isReply) SizedBox(width: 16),
                  if (!isReply)
                    InkWell(
                      child: Text(
                        comment.entity.commentCount == 0
                            ? 'Reply'
                            : 'Replies (${comment.entity.commentCount.compactFormat})',
                        style: Theme.of(context).textTheme.caption,
                      ),
                      onTap: () {
                        GetIt.I.get<NavigationService>().toCommentsScreen(
                            context: context,
                            threadTitle: 'Reply: ${comment.entity.comment}',
                            threadType: CommentThreadType.COMMENT,
                            threadId: comment.entity.id);
                      },
                    ),
                ],
              ),
            ],
          ),
        ),
        trailing: PopupMenuButton<String>(
          itemBuilder: (context) {
            final textStyle = Theme.of(context).textTheme.bodyText2;
            return <PopupMenuEntry<String>>[
              if (comment.entity.user.id == user.id)
                PopupMenuItem<String>(
                  value: 'edit',
                  child: Text(
                    'Edit',
                    style: textStyle,
                  ),
                ),
              if (comment.entity.user.id == user.id)
                PopupMenuItem<String>(
                  value: 'delete',
                  child: Text(
                    'Delete',
                    style: textStyle,
                  ),
                ),
              PopupMenuItem<String>(
                value: 'report',
                child: Text(
                  'Report',
                  style: textStyle,
                ),
              ),
            ];
          },
          child: Icon(
            Icons.more_vert,
            size: 18,
          ),
          onSelected: (value) {
            switch (value) {
              case 'edit':
                context.showMessage('Comment edit selected.');
                break;
              case 'delete':
                context.dialog(
                  child: CommentDeleteConfirmationDialog(
                    onYesTap: () => context
                        .read<CommentDeleteCubit>()
                        .delete(comment.entity),
                    onNoTap: () {},
                  ),
                );
                break;
              case 'report':
                context.showBottomSheet(
                    child: Report(
                  threadId: comment.entity.id,
                  threadType: ReportThreadType.COMMENT,
                ));
                break;
            }
          },
        ),
      ),
    );
  }
}

class CommentView extends StatefulWidget {
  const CommentView({
    Key key,
    @required this.comment,
  }) : super(key: key);

  final String comment;

  @override
  _CommentViewState createState() => _CommentViewState();
}

class _CommentViewState extends State<CommentView> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: GestureDetector(
        onTap: () {
          setState(() {
            isExpanded = !isExpanded;
          });
        },
        child: Text(
          widget.comment,
          style: Theme.of(context).textTheme.bodyText2,
          overflow: TextOverflow.ellipsis,
          maxLines: isExpanded ? null : 4,
        ),
      ),
    );
  }
}
