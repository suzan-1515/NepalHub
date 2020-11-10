import 'dart:async';

import 'package:flutter/material.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_type.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/bookmarks/bookmark_unbookmark/bookmark_un_bookmark_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/feed_bloc/feed_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/like_unlike/like_unlike_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_source/follow_unfollow/follow_un_follow_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_list_builder_widget.dart';
import 'package:samachar_hub/core/widgets/empty_data_widget.dart';
import 'package:samachar_hub/core/widgets/error_data_widget.dart';
import 'package:samachar_hub/core/widgets/progress_widget.dart';
import 'package:samachar_hub/core/extensions/view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/feature_news/utils/provider.dart';

class LatestNewsList extends StatefulWidget {
  const LatestNewsList({
    Key key,
  }) : super(key: key);

  @override
  _LatestNewsListState createState() => _LatestNewsListState();
}

class _LatestNewsListState extends State<LatestNewsList> {
  Completer<void> _refreshCompleter;
  FeedBloc _feedBloc;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
    _feedBloc = context.read<FeedBloc>();
    _feedBloc.add(GetNewsEvent(newsType: NewsType.LATEST));
  }

  Future<void> _onRefresh() {
    _feedBloc.add(RefreshNewsEvent(newsType: NewsType.LATEST));
    return _refreshCompleter.future;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeedBloc, FeedState>(
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
              hasMore: state.hasMore,
              onLoadMore: () =>
                  _feedBloc.add(LoadMoreNewsEvent(newsType: NewsType.LATEST)),
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
                onRetry: () =>
                    _feedBloc.add(GetNewsEvent(newsType: NewsType.LATEST)),
              ),
            );
          }

          return const Center(child: const ProgressView());
        });
  }
}
