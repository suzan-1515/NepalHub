import 'package:flutter/material.dart';
import 'package:samachar_hub/core/widgets/progress_widget.dart';
import 'package:samachar_hub/feature_comment/presentation/models/comment_model.dart';
import 'package:samachar_hub/feature_comment/presentation/ui/widgets/comment_item.dart';
import 'package:samachar_hub/feature_comment/utils/providers.dart';

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
            commentUIModel: comment,
            child: CommentListItem(
              commentUIModel: comment,
            ),
          );
        },
      ),
    );
  }
}
