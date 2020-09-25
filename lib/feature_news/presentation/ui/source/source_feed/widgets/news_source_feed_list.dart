import 'dart:async';

import 'package:flutter/material.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_source/source_feeds/news_source_feed_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_list_builder_widget.dart';
import 'package:samachar_hub/core/widgets/empty_data_widget.dart';
import 'package:samachar_hub/core/widgets/error_data_widget.dart';
import 'package:samachar_hub/core/widgets/progress_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/extensions/view.dart';

class NewsSourceFeedList extends StatefulWidget {
  const NewsSourceFeedList({
    Key key,
  }) : super(key: key);

  @override
  _NewsSourceFeedListState createState() => _NewsSourceFeedListState();
}

class _NewsSourceFeedListState extends State<NewsSourceFeedList> {
  Completer<void> _refreshCompleter;
  NewsSourceFeedBloc _newsSourceFeedBloc;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
    _newsSourceFeedBloc = context.bloc<NewsSourceFeedBloc>();
  }

  Future<void> _onRefresh() {
    _newsSourceFeedBloc.add(RefreshSourceNewsEvent());
    return _refreshCompleter.future;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsSourceFeedBloc, NewsSourceFeedState>(
        cubit: _newsSourceFeedBloc,
        listener: (context, state) {
          if (!(state is LoadingState)) {
            _refreshCompleter?.complete();
            _refreshCompleter = Completer();
          }
          if (state is ErrorState) {
            context.showMessage(state.message);
          } else if (state is RefreshErrorState) {
            context.showMessage(state.message);
          }
        },
        buildWhen: (previous, current) => (current is InitialState ||
            current is LoadSuccessState ||
            current is EmptyState ||
            current is ErrorState ||
            current is LoadingState),
        builder: (context, state) {
          if (state is LoadSuccessState) {
            return NewsListBuilder(
              data: state.feeds,
              onRefresh: _onRefresh,
              hasMore: state.hasMore,
            );
          } else if (state is EmptyState) {
            return Center(
              child: EmptyDataView(
                text: state.message,
              ),
            );
          } else if (state is ErrorState) {
            return Center(
              child: ErrorDataView(
                onRetry: () => _newsSourceFeedBloc.add(RetrySourceNewsEvent()),
              ),
            );
          }
          return Center(child: ProgressView());
        });
  }
}
