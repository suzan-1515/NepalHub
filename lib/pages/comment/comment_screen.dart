import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/pages/comment/widgets/comment_input_bar.dart';
import 'package:samachar_hub/pages/comment/widgets/comment_list.dart';
import 'package:samachar_hub/pages/comment/widgets/header.dart';
import 'package:samachar_hub/pages/comment/widgets/like_comment_stats.dart';
import 'package:samachar_hub/stores/comment/comment_store.dart';
import 'package:samachar_hub/stores/stores.dart';
import 'package:samachar_hub/utils/extensions.dart';

class CommentScreen extends StatefulWidget {
  final String postTitle;
  final String postId;

  const CommentScreen(
      {Key key, @required this.postTitle, @required this.postId})
      : super(key: key);
  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  // Reaction disposers
  List<ReactionDisposer> _disposers;

  @override
  void initState() {
    final store = context.read<CommentStore>();
    _setupObserver(store);
    store.setPostId(widget.postId);
    store.setPostTitle(widget.postTitle);
    store.loadInitialData();
    context.read<PostMetaStore>().loadPostMeta();

    super.initState();
  }

  @override
  void dispose() {
    // Dispose reactions
    for (final d in _disposers) {
      d();
    }
    super.dispose();
  }

  _setupObserver(store) {
    _disposers = [
      // Listens for error message
      autorun((_) {
        final String message = store.error;
        if (message != null) context.showMessage(message);
      }),
      // Listens for API error
      autorun((_) {
        final APIException error = store.apiError;
        if (error != null) context.showErrorDialog(error);
      })
    ];
  }

  Widget _buildBody(CommentStore store) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) =>
            [
          SliverToBoxAdapter(
            child: Header(
              context: context,
              store: store,
            ),
          ),
          SliverToBoxAdapter(
            child: LikeAndCommentStats(
              context: context,
              store: store,
            ),
          ),
        ],
        body: CommentList(
          context: context,
          store: store,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: SafeArea(
        child: Container(
          color: Theme.of(context).backgroundColor,
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Consumer<CommentStore>(
            builder: (_, store, child) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: _buildBody(store),
                  ),
                  CommentInputBar(store: store),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
