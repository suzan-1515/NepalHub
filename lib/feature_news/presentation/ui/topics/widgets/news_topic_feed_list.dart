import 'dart:async';

import 'package:flutter/material.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_topic/topic_feeds/news_topic_feed_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_list_builder_widget.dart';
import 'package:samachar_hub/core/widgets/empty_data_widget.dart';
import 'package:samachar_hub/core/widgets/error_data_widget.dart';
import 'package:samachar_hub/core/widgets/progress_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/extensions/view.dart';

class NewsTopicFeedList extends StatefulWidget {
  const NewsTopicFeedList({
    Key key,
  }) : super(key: key);

  @override
  _NewsTopicFeedListState createState() => _NewsTopicFeedListState();
}

class _NewsTopicFeedListState extends State<NewsTopicFeedList> {
  Completer<void> _refreshCompleter;
  NewsTopicFeedBloc _newsTopicFeedBloc;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
    _newsTopicFeedBloc = context.bloc<NewsTopicFeedBloc>();
  }

  Future<void> _onRefresh() {
    _newsTopicFeedBloc.add(RefreshTopicNewsEvent());
    return _refreshCompleter.future;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsTopicFeedBloc, NewsTopicFeedState>(
        cubit: _newsTopicFeedBloc,
        listenWhen: (previous, current) =>
            !(current is NewsTopicFeedLoadingState) &&
            !(current is NewsTopicFeedMoreLoadingState),
        listener: (context, state) {
          _refreshCompleter?.complete();
          _refreshCompleter = Completer();

          if (state is NewsTopicFeedErrorState) {
            context.showMessage(state.message);
          }
        },
        buildWhen: (previous, current) =>
            !(current is NewsTopicFeedErrorState) &&
            !(current is NewsTopicFeedMoreLoadingState),
        builder: (context, state) {
          if (state is NewsTopicFeedLoadSuccessState) {
            return NewsListBuilder(
              data: state.feeds,
              onRefresh: _onRefresh,
              hasMore: state.hasMore,
              onLoadMore: () => _newsTopicFeedBloc.add(GetMoreTopicNewsEvent()),
            );
          } else if (state is NewsTopicFeedEmptyState) {
            return Center(
              child: EmptyDataView(
                text: state.message,
              ),
            );
          } else if (state is NewsTopicFeedErrorState) {
            return Center(
              child: ErrorDataView(
                onRetry: () => _newsTopicFeedBloc.add(GetTopicNewsEvent()),
              ),
            );
          }
          return Center(child: ProgressView());
        });
  }
}
