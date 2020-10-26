import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_auth/domain/entities/user_entity.dart';
import 'package:samachar_hub/feature_auth/presentation/blocs/auth_bloc.dart';
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

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  _submitComment(BuildContext context, UserEntity user, String comment) async {
    if (comment == null || comment.isEmpty) return;
    if (user != null && !user.isAnonymous) {
      return context.bloc<CommentPostBloc>().add(PostCommentEvent(comment));
    }
    GetIt.I.get<NavigationService>().loginRedirect(context);
  }

  @override
  Widget build(BuildContext context) {
    final user = context.bloc<AuthBloc>().currentUser;
    final bool hasAvatar = (user != null &&
        !user.isAnonymous &&
        user.avatar != null &&
        user.avatar.isNotEmpty);
    return BlocListener<CommentPostBloc, CommentPostState>(
      listener: (context, state) {
        if (state is CommentPostSuccessState) {
          context.bloc<CommentBloc>().add(RefreshCommentsEvent());
          context.bloc<ThreadStatsCubit>().refreshStats();
          context.showMessage('Comment posted.');
          GetIt.I.get<EventBus>().fire(
              CommentPostSuccessState(commentUIModel: state.commentUIModel));
        } else if (state is CommentPostErrorState) {
          context.showMessage(state.message);
        }
      },
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
              SizedBox(
                width: 8,
              ),
              Expanded(
                  child: Container(
                child: TextField(
                  onSubmitted: (value) {
                    _submitComment(context, user, value.trim());
                    _textEditingController.clear();
                    FocusScope.of(context).unfocus();
                  },
                  controller: _textEditingController,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'Write a comment'),
                  style: Theme.of(context).textTheme.bodyText2,
                ),
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
                  _textEditingController.clear();
                  FocusScope.of(context).unfocus();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
