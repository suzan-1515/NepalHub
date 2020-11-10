import 'dart:async';

import 'package:flutter/material.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_type.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/feed_bloc/feed_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_list_builder_widget.dart';
import 'package:samachar_hub/core/widgets/empty_data_widget.dart';
import 'package:samachar_hub/core/widgets/error_data_widget.dart';
import 'package:samachar_hub/core/widgets/progress_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/extensions/view.dart';

class TrendingNewsList extends StatefulWidget {
  const TrendingNewsList({
    Key key,
  }) : super(key: key);

  @override
  _TrendingNewsListState createState() => _TrendingNewsListState();
}

class _TrendingNewsListState extends State<TrendingNewsList> {
  Completer<void> _refreshCompleter;
  FeedBloc _newsBloc;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
    _newsBloc = context.read<FeedBloc>();
    _newsBloc.add(GetNewsEvent(newsType: NewsType.TRENDING));
  }

  Future<void> _onRefresh() {
    _newsBloc.add(RefreshNewsEvent(newsType: NewsType.TRENDING));
    return _refreshCompleter.future;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeedBloc, FeedState>(
        cubit: _newsBloc,
        listener: (context, state) {
          if (!(state is LoadingState)) {
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
                onRetry: () =>
                    _newsBloc.add(GetNewsEvent(newsType: NewsType.TRENDING)),
              ),
            );
          }
          return Center(child: ProgressView());
        });
  }
}
