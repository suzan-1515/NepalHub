import 'dart:async';

import 'package:flutter/material.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_category/category_feeds/news_category_feed_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_list_builder_widget.dart';
import 'package:samachar_hub/core/widgets/empty_data_widget.dart';
import 'package:samachar_hub/core/widgets/error_data_widget.dart';
import 'package:samachar_hub/core/widgets/progress_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/extensions/view.dart';

class NewsCategoryFeedList extends StatefulWidget {
  const NewsCategoryFeedList({
    Key key,
  }) : super(key: key);

  @override
  _NewsCategoryFeedListState createState() => _NewsCategoryFeedListState();
}

class _NewsCategoryFeedListState extends State<NewsCategoryFeedList> {
  Completer<void> _refreshCompleter;
  NewsCategoryFeedBloc _newsCategoryFeedBloc;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
    _newsCategoryFeedBloc = context.bloc<NewsCategoryFeedBloc>();
  }

  Future<void> _onRefresh() {
    _newsCategoryFeedBloc.add(RefreshCategoryNewsEvent());
    return _refreshCompleter.future;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCategoryFeedBloc, NewsCategoryFeedState>(
        cubit: _newsCategoryFeedBloc,
        listenWhen: (previous, current) =>
            !(current is NewsCategoryFeedLoadingState) &&
            !(current is NewsCategoryFeedMoreLoadingState),
        listener: (context, state) {
          _refreshCompleter?.complete();
          _refreshCompleter = Completer();
          if (state is NewsCategoryFeedErrorState) {
            context.showMessage(state.message);
          }
        },
        buildWhen: (previous, current) =>
            !(current is NewsCategoryFeedErrorState) &&
            !(current is NewsCategoryFeedMoreLoadingState),
        builder: (context, state) {
          if (state is NewsCategoryFeedLoadSuccessState) {
            return NewsListBuilder(
              data: state.feeds,
              onRefresh: _onRefresh,
              hasMore: state.hasMore,
              onLoadMore: () =>
                  _newsCategoryFeedBloc.add(GetMoreCategoryNewsEvent()),
            );
          } else if (state is NewsCategoryFeedEmptyState) {
            return Center(
              child: EmptyDataView(
                text: state.message,
              ),
            );
          } else if (state is NewsCategoryFeedLoadErrorState) {
            return Center(
              child: ErrorDataView(
                onRetry: () =>
                    _newsCategoryFeedBloc.add(GetCategoryNewsEvent()),
              ),
            );
          }
          return Center(child: ProgressView());
        });
  }
}
