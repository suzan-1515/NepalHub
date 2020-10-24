import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/feature_comment/domain/entities/thread_type.dart';
import 'package:samachar_hub/feature_comment/presentation/blocs/comment_bloc.dart';
import 'package:samachar_hub/feature_comment/presentation/ui/widgets/comment_input_bar.dart';
import 'package:samachar_hub/feature_comment/presentation/ui/widgets/comment_list.dart';
import 'package:samachar_hub/feature_comment/presentation/ui/widgets/header.dart';
import 'package:samachar_hub/feature_comment/presentation/ui/widgets/like_comment_stats.dart';
import 'package:samachar_hub/feature_comment/utils/providers.dart';

class CommentScreen extends StatelessWidget {
  final String threadId;
  final CommentThreadType threadType;
  final String threadTitle;
  const CommentScreen(
      {Key key,
      @required this.threadId,
      @required this.threadType,
      @required this.threadTitle})
      : super(key: key);

  Widget _buildBody(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) =>
            [
          SliverToBoxAdapter(
            child: Header(
              title: threadTitle,
            ),
          ),
          SliverToBoxAdapter(
            child: LikeAndCommentStats(
              likeCount: 0,
              commentCount: 0,
            ),
          ),
        ],
        body: const CommentList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommentProvider.commentBlocProvider(
      threadId: threadId,
      threadType: threadType,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text('Comments'),
        ),
        body: SafeArea(
          child: Container(
            color: Theme.of(context).backgroundColor,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: _buildBody(context),
                ),
                const CommentInputBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
