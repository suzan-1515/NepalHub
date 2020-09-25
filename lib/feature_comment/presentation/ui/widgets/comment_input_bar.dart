import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_comment/presentation/blocs/comment_post/comment_post_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/stores/stores.dart';

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

  _submitComment(BuildContext context, AuthenticationStore authStore,
      String comment) async {
    if (comment == null || comment.isEmpty) return;
    if (authStore.isLoggedIn && !authStore.user.isAnonymous) {
      return context.bloc<CommentPostBloc>().add(PostCommentEvent(comment));
    }
    context.repository<NavigationService>().loginRedirect(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationStore>(
      builder: (_, AuthenticationStore authStore, __) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            border: Border(
                top: BorderSide(
                    color: Theme.of(context).dividerColor, width: 0.5)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Observer(
            builder: (_) {
              final hasAvatar = authStore.isLoggedIn
                  ? (authStore.user.avatar?.isNotEmpty ?? false)
                  : false;
              return Material(
                color: Colors.transparent,
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Theme.of(context).cardColor,
                      backgroundImage: hasAvatar
                          ? NetworkImage(authStore.user.avatar)
                          : AssetImage('assets/images/user.png'),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        child: Container(
                      child: TextField(
                        onSubmitted: (value) {
                          _submitComment(context, authStore, value.trim());
                          _textEditingController.clear();
                          FocusScope.of(context).unfocus();
                        },
                        controller: _textEditingController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Write a comment'),
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
                        _submitComment(context, authStore,
                            _textEditingController.value.text.trim());
                        _textEditingController.clear();
                        FocusScope.of(context).unfocus();
                      },
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
