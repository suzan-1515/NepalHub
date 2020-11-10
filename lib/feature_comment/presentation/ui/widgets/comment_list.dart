import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/extensions/view.dart';
import 'package:samachar_hub/core/widgets/empty_data_widget.dart';
import 'package:samachar_hub/core/widgets/error_data_widget.dart';
import 'package:samachar_hub/core/widgets/progress_widget.dart';
import 'package:samachar_hub/feature_comment/presentation/blocs/comment_bloc.dart';
import 'package:samachar_hub/feature_comment/presentation/ui/widgets/comment_list_builder.dart';

class CommentList extends StatefulWidget {
  const CommentList({
    Key key,
  }) : super(key: key);

  @override
  _CommentListState createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  Completer<void> _refreshCompleter;
  CommentBloc _commentBloc;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
    _commentBloc = context.read<CommentBloc>();
  }

  Future<void> _onRefresh() {
    _commentBloc.add(RefreshCommentsEvent());
    return _refreshCompleter.future;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommentBloc, CommentState>(
        cubit: _commentBloc,
        listenWhen: (previous, current) =>
            !(current is CommentLoading) &&
            !(current is CommentError) &&
            !(current is CommentRefreshing),
        listener: (context, state) {
          _refreshCompleter?.complete();
          _refreshCompleter = Completer();
          if (state is CommentError) {
            context.showMessage(state.message);
          } else if (state is CommentLoadError) {
            context.showMessage(state.message);
          }
        },
        buildWhen: (previous, current) =>
            !(current is CommentError) &&
            !(current is CommentMoreLoading) &&
            !(current is CommentRefreshing),
        builder: (context, state) {
          if (state is CommentLoadSuccess) {
            return CommentListBuilder(
              data: state.comments,
              onRefresh: _onRefresh,
            );
          } else if (state is CommentLoadEmpty) {
            return Center(
              child: EmptyDataView(
                text: state.message,
              ),
            );
          } else if (state is CommentLoadError) {
            return Center(
              child: ErrorDataView(
                onRetry: () => _commentBloc.add(GetCommentsEvent()),
              ),
            );
          }
          return Center(child: ProgressView());
        });
  }
}
