import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/core/widgets/progress_widget.dart';
import 'package:samachar_hub/feature_comment/domain/usecases/delete_comment_use_case.dart';
import 'package:samachar_hub/feature_comment/domain/usecases/like_comment_use_case.dart';
import 'package:samachar_hub/feature_comment/domain/usecases/unlike_comment_use_case.dart';
import 'package:samachar_hub/feature_comment/presentation/blocs/delete/delete_cubit.dart';
import 'package:samachar_hub/feature_comment/presentation/blocs/like_unlike/like_unlike_bloc.dart';
import 'package:samachar_hub/feature_comment/presentation/models/comment_model.dart';
import 'package:samachar_hub/feature_comment/presentation/ui/widgets/comment_item.dart';

class CommentListBuilder extends StatefulWidget {
  const CommentListBuilder({
    Key key,
    @required this.onRefresh,
    @required this.data,
    this.hasMore = false,
    this.onLoadMore,
  })  : assert(onRefresh != null, 'Refresh callback function cannot be null'),
        assert(data != null, 'Comment list cannot be null'),
        super(key: key);

  final Future<void> Function() onRefresh;
  final Function() onLoadMore;
  final List<CommentUIModel> data;
  final bool hasMore;

  @override
  _CommentListBuilderState createState() => _CommentListBuilderState();
}

class _CommentListBuilderState extends State<CommentListBuilder> {
  UseCase _likeCommentUseCase;
  UseCase _unlikeCommentUseCase;
  UseCase _deleteCommentUseCase;

  bool _shouldShowLoadMore(index) =>
      widget.hasMore && (index == widget.data.length);

  @override
  void initState() {
    super.initState();
    _likeCommentUseCase = context.repository<LikeCommentUseCase>();
    _unlikeCommentUseCase = context.repository<UnlikeCommentUseCase>();
    _deleteCommentUseCase = context.repository<DeleteCommentUseCase>();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: widget.onRefresh,
      child: ListView.builder(
        itemCount: widget.hasMore ? widget.data.length + 1 : widget.data,
        itemBuilder: (_, int index) {
          if (_shouldShowLoadMore(index))
            return Center(
              child: ProgressView(),
            );

          var comment = widget.data[index];
          return MultiBlocProvider(
            providers: [
              BlocProvider<LikeUnlikeBloc>(
                create: (context) => LikeUnlikeBloc(
                    likeCommentUseCase: _likeCommentUseCase,
                    unlikeCommentUseCase: _unlikeCommentUseCase,
                    commentUIModel: comment),
              ),
              BlocProvider<CommentDeleteCubit>(
                create: (context) => CommentDeleteCubit(
                    deleteCommentUseCase: _deleteCommentUseCase,
                    commentUIModel: comment),
              ),
            ],
            child: CommentListItem(
              commentUIModel: comment,
            ),
          );
        },
      ),
    );
  }
}
