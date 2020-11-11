import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/feature_comment/domain/entities/thread_type.dart';
import 'package:samachar_hub/feature_comment/presentation/ui/widgets/comment_input_bar.dart';
import 'package:samachar_hub/feature_comment/presentation/ui/widgets/comment_list.dart';
import 'package:samachar_hub/feature_comment/presentation/ui/widgets/header.dart';
import 'package:samachar_hub/feature_comment/presentation/ui/widgets/like_comment_stats.dart';
import 'package:samachar_hub/feature_comment/utils/providers.dart';
import 'package:samachar_hub/feature_stats/presentation/blocs/thread_stats_cubit.dart';

class CommentScreen extends StatelessWidget {
  static const String ROUTE_NAME = '/comment';
  const CommentScreen({Key key}) : super(key: key);

  Widget _buildBody(BuildContext context, String title) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) =>
            [
          SliverToBoxAdapter(
            child: Header(
              title: title,
            ),
          ),
          SliverToBoxAdapter(
            child: BlocBuilder<ThreadStatsCubit, ThreadStatsState>(
              builder: (context, state) {
                if (state is ThreadStatsLoadSuccess) {
                  return LikeAndCommentStats(
                    likeCount:
                        state.threadStatsUIModel.threadStatsEntity.likeCount,
                    commentCount:
                        state.threadStatsUIModel.threadStatsEntity.commentCount,
                  );
                }
                return LikeAndCommentStats(
                  likeCount: 0,
                  commentCount: 0,
                );
              },
            ),
          ),
        ],
        body: const CommentList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final CommentScreenArgs args = ModalRoute.of(context).settings.arguments;
    return CommentProvider.commentBlocProvider(
      threadId: args.threadId,
      threadType: args.threadType,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
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
                  child: _buildBody(context, args.threadTitle),
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

class CommentScreenArgs {
  final String threadId;
  final CommentThreadType threadType;
  final String threadTitle;
  final Map<String, dynamic> data;

  CommentScreenArgs(
      {@required this.threadId,
      @required this.threadType,
      @required this.threadTitle,
      this.data});
}
