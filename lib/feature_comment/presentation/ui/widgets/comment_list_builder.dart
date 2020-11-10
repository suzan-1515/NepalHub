import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/widgets/progress_widget.dart';
import 'package:samachar_hub/feature_comment/presentation/blocs/comment_bloc.dart';
import 'package:samachar_hub/feature_comment/presentation/blocs/delete/delete_cubit.dart';
import 'package:samachar_hub/feature_comment/presentation/blocs/like_unlike/like_unlike_bloc.dart';
import 'package:samachar_hub/feature_comment/presentation/models/comment_model.dart';
import 'package:samachar_hub/feature_comment/presentation/ui/widgets/comment_item.dart';
import 'package:samachar_hub/feature_comment/utils/providers.dart';
import 'package:samachar_hub/core/extensions/view.dart';
import 'package:scoped_model/scoped_model.dart';

class CommentListBuilder extends StatelessWidget {
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

  bool _shouldShowLoadMore(index) => hasMore && (index == data.length);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        itemCount: hasMore ? data.length + 1 : data.length,
        itemBuilder: (_, int index) {
          if (_shouldShowLoadMore(index))
            return Center(
              child: ProgressView(),
            );

          var comment = data[index];
          return CommentProvider.commentItemBlocProvider(
            child: ScopedModel<CommentUIModel>(
              model: comment,
              child: MultiBlocListener(listeners: [
                BlocListener<CommentLikeUnlikeBloc, CommentLikeUnlikeState>(
                  listener: (context, state) {
                    if (state is CommentLikeSuccessState) {
                      ScopedModel.of<CommentUIModel>(context).entity =
                          state.comment;
                    } else if (state is CommentUnlikeSuccessState) {
                      ScopedModel.of<CommentUIModel>(context).entity =
                          state.comment;
                    }
                  },
                ),
                BlocListener<CommentDeleteCubit, CommentDeleteState>(
                  listener: (context, state) {
                    if (state is CommentDeleteSuccessState) {
                      context.showMessage('Comment deleted.');
                      context.read<CommentBloc>().add(RefreshCommentsEvent());
                    } else if (state is CommentDeleteErrorState) {
                      context.showMessage(state.message);
                    }
                  },
                ),
              ], child: CommentListItem()),
            ),
          );
        },
      ),
    );
  }
}
