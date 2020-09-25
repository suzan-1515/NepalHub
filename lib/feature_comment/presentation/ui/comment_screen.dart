import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/feature_comment/presentation/blocs/comment_bloc.dart';
import 'package:samachar_hub/feature_comment/presentation/ui/widgets/comment_input_bar.dart';
import 'package:samachar_hub/feature_comment/presentation/ui/widgets/comment_list.dart';
import 'package:samachar_hub/feature_comment/presentation/ui/widgets/header.dart';
import 'package:samachar_hub/feature_comment/presentation/ui/widgets/like_comment_stats.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({Key key}) : super(key: key);
  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  CommentBloc _commentBloc;

  @override
  void initState() {
    super.initState();
    _commentBloc = context.bloc<CommentBloc>();
    _commentBloc.add(GetCommentsEvent());
  }

  Widget _buildBody() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) =>
            [
          SliverToBoxAdapter(
            child: Header(
              title: _commentBloc.threadTitle,
            ),
          ),
          SliverToBoxAdapter(
            child: LikeAndCommentStats(
              likeCount: '${_commentBloc.likeCount ?? 0} Likes',
              commentCount: '${_commentBloc.commentCount ?? 0} Comments',
            ),
          ),
        ],
        body: const CommentList(),
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: _buildBody(),
              ),
              const CommentInputBar(),
            ],
          ),
        ),
      ),
    );
  }
}
