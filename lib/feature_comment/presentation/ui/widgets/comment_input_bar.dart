import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samachar_hub/feature_auth/domain/entities/user_entity.dart';
import 'package:samachar_hub/feature_auth/presentation/blocs/auth_bloc.dart';
import 'package:samachar_hub/feature_auth/presentation/ui/login_screen.dart';
import 'package:samachar_hub/feature_comment/domain/entities/thread_type.dart';
import 'package:samachar_hub/feature_comment/presentation/blocs/comment_bloc.dart';
import 'package:samachar_hub/feature_comment/presentation/blocs/comment_post/comment_post_bloc.dart';
import 'package:samachar_hub/core/extensions/view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/feature_stats/presentation/blocs/thread_stats_cubit.dart';

class CommentInputBar extends StatefulWidget {
  const CommentInputBar({
    Key key,
  }) : super(key: key);
  @override
  _CommentInputBarState createState() => _CommentInputBarState();
}

class _CommentInputBarState extends State<CommentInputBar> {
  final TextEditingController _textEditingController = TextEditingController();
  bool isReply = false;
  var focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    isReply =
        (context.read<CommentBloc>().threadType == CommentThreadType.COMMENT);
  }

  @override
  void dispose() {
    _textEditingController?.dispose();
    focusNode?.dispose();
    super.dispose();
  }

  void _submitComment(
      BuildContext context, UserEntity user, String comment) async {
    if (comment == null || comment.isEmpty) return;
    if (comment.length > 500) {
      context.showMessage('Comment too long. Max character limit is 500.');
      return;
    }
    if (user != null && !user.isAnonymous) {
      context.showMessage('Comment posting...');
      focusNode.unfocus();
      context.read<CommentPostBloc>().add(PostCommentEvent(comment));
    } else
      Navigator.pushNamed(context, LoginScreen.ROUTE_NAME);
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthBloc>().currentUser;
    final bool hasAvatar = (user != null &&
        !user.isAnonymous &&
        user.avatar != null &&
        user.avatar.isNotEmpty);
    return MultiBlocListener(
      listeners: [
        BlocListener<CommentPostBloc, CommentPostState>(
          listener: (context, state) {
            if (state is CommentPostSuccessState) {
              _textEditingController.clear();
              context.read<CommentBloc>().add(RefreshCommentsEvent());
              context.read<ThreadStatsCubit>().refreshStats();
              context.showMessage('Comment posted.');
            } else if (state is CommentPostErrorState) {
              context.showMessage(state.message);
            }
          },
        ),
      ],
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          border: Border(
              top: BorderSide(
                  color: Theme.of(context).dividerColor, width: 0.5)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Material(
          color: Colors.transparent,
          child: Row(
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Theme.of(context).cardColor,
                backgroundImage: hasAvatar
                    ? NetworkImage(user.avatar)
                    : AssetImage('assets/images/user.png'),
              ),
              const SizedBox(width: 8),
              Expanded(
                  child: TextField(
                focusNode: focusNode,
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
                minLines: 1,
                maxLines: 4,
                onSubmitted: (value) {
                  _submitComment(context, user, value.trim());
                },
                controller: _textEditingController,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'Write a comment'),
                style: Theme.of(context).textTheme.bodyText2,
              )),
              SizedBox(
                width: 8,
              ),
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.paperPlane,
                  color: Colors.lightBlue,
                ),
                onPressed: () {
                  _submitComment(
                      context, user, _textEditingController.value.text.trim());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
