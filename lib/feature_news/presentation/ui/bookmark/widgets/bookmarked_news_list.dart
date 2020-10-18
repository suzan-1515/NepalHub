import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/bookmarks/bookmark_news_bloc.dart';
import 'package:samachar_hub/core/widgets/empty_data_widget.dart';
import 'package:samachar_hub/core/widgets/error_data_widget.dart';
import 'package:samachar_hub/core/widgets/progress_widget.dart';
import 'package:samachar_hub/core/extensions/view.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_list_builder_widget.dart';

class BookmarkedNewsList extends StatefulWidget {
  const BookmarkedNewsList({
    Key key,
  }) : super(key: key);

  @override
  _BookmarkedNewsListState createState() => _BookmarkedNewsListState();
}

class _BookmarkedNewsListState extends State<BookmarkedNewsList> {
  BookmarkNewsBloc _bookmarkNewsBloc;
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
    _bookmarkNewsBloc = context.bloc<BookmarkNewsBloc>();
  }

  Future<void> _onRefresh() {
    _bookmarkNewsBloc.add(RefreshBookmarkedNewsEvent());
    return _refreshCompleter.future;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookmarkNewsBloc, BookmarkNewsState>(
        cubit: _bookmarkNewsBloc,
        listener: (context, state) {
          if (state is InitialState) {
            _bookmarkNewsBloc.add(GetBookmarkedNews());
          } else if (!(state is LoadingState)) {
            _refreshCompleter?.complete();
            _refreshCompleter = Completer();
          }
          if (state is ErrorState) {
            context.showMessage(state.message);
          } else if (state is LoadErrorState) {
            context.showMessage(state.message);
          }
        },
        buildWhen: (previous, current) =>
            !(current is ErrorState) && !(current is LoadingMoreState),
        builder: (context, state) {
          if (state is LoadSuccessState) {
            return NewsListBuilder(
              data: state.feeds,
              onRefresh: _onRefresh,
            );
          } else if (state is EmptyState) {
            return Center(
              child: EmptyDataView(
                text: state.message,
              ),
            );
          } else if (state is LoadErrorState) {
            return Center(
              child: ErrorDataView(
                onRetry: () => _bookmarkNewsBloc.add(GetBookmarkedNews()),
              ),
            );
          }
          return Center(child: ProgressView());
        });
  }
}
