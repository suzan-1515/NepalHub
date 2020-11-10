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
    _bookmarkNewsBloc = context.read<BookmarkNewsBloc>();
  }

  Future<void> _onRefresh() {
    _bookmarkNewsBloc.add(RefreshBookmarkedNewsEvent());
    return _refreshCompleter.future;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookmarkNewsBloc, BookmarkNewsState>(
        cubit: _bookmarkNewsBloc,
        listenWhen: (previous, current) =>
            !(current is BookmarkNewsLoadingState) &&
            !(current is BookmarkNewsLoadingMoreState),
        listener: (context, state) {
          _refreshCompleter?.complete();
          _refreshCompleter = Completer();
          if (state is BookmarkNewsErrorState) {
            context.showMessage(state.message);
          } else if (state is BookmarkNewsLoadErrorState) {
            context.showMessage(state.message);
          }
        },
        buildWhen: (previous, current) =>
            !(current is BookmarkNewsErrorState) &&
            !(current is BookmarkNewsLoadingMoreState),
        builder: (context, state) {
          if (state is BookmarkNewsLoadSuccessState) {
            return NewsListBuilder(
              data: state.feeds,
              onRefresh: _onRefresh,
              hasMore: state.hasMore,
              onLoadMore: () =>
                  _bookmarkNewsBloc.add(LoadMoreBookmarkedNewsEvent()),
            );
          } else if (state is BookmarkNewsEmptyState) {
            return Center(
              child: EmptyDataView(
                text: state.message,
              ),
            );
          } else if (state is BookmarkNewsLoadErrorState) {
            return Center(
              child: ErrorDataView(
                onRetry: () => _bookmarkNewsBloc.add(GetBookmarkedNews()),
              ),
            );
          }
          return const Center(child: const ProgressView());
        });
  }
}
