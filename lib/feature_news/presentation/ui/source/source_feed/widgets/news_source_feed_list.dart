import 'dart:async';

import 'package:flutter/material.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/bookmarks/bookmark_unbookmark/bookmark_un_bookmark_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/like_unlike/like_unlike_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_source/follow_unfollow/follow_un_follow_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_source/source_feeds/news_source_feed_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_list_builder_widget.dart';
import 'package:samachar_hub/core/widgets/empty_data_widget.dart';
import 'package:samachar_hub/core/widgets/error_data_widget.dart';
import 'package:samachar_hub/core/widgets/progress_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/extensions/view.dart';
import 'package:samachar_hub/feature_news/utils/provider.dart';

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
        listenWhen: (previous, current) =>
            !(current is NewsSourceFeedLoadingState) &&
            !(current is NewsSourceFeedMoreLoadingState),
        listener: (context, state) {
          _refreshCompleter?.complete();
          _refreshCompleter = Completer();
          if (state is NewsSourceFeedErrorState) {
            context.showMessage(state.message);
          }
        },
        buildWhen: (previous, current) =>
            !(current is NewsSourceFeedErrorState) &&
            !(current is NewsSourceFeedMoreLoadingState),
        builder: (context, state) {
          if (state is NewsSourceFeedLoadSuccessState) {
            return NewsProvider.feedItemBlocProvider(
              child: MultiBlocListener(
                listeners: [
                  BlocListener<LikeUnlikeBloc, LikeUnlikeState>(
                    listener: (context, state) {
                      if (state is NewsLikeSuccessState) {
                        _newsSourceFeedBloc.add(FeedChangeEvent(
                            data: state.feed, eventType: 'feed'));
                      } else if (state is NewsUnLikeSuccessState) {
                        _newsSourceFeedBloc.add(FeedChangeEvent(
                            data: state.feed, eventType: 'feed'));
                      }
                    },
                  ),
                  BlocListener<BookmarkUnBookmarkBloc, BookmarkUnBookmarkState>(
                    listener: (context, state) {
                      if (state is BookmarkSuccess) {
                        _newsSourceFeedBloc.add(FeedChangeEvent(
                            data: state.feed, eventType: 'feed'));
                      } else if (state is UnbookmarkSuccess) {
                        _newsSourceFeedBloc.add(FeedChangeEvent(
                            data: state.feed, eventType: 'feed'));
                      }
                    },
                  ),
                  BlocListener<SourceFollowUnFollowBloc,
                      SourceFollowUnFollowState>(
                    listener: (context, state) {
                      if (state is SourceFollowSuccessState) {
                        _newsSourceFeedBloc.add(FeedChangeEvent(
                            data: state.source, eventType: 'source'));
                      } else if (state is SourceUnFollowSuccessState) {
                        _newsSourceFeedBloc.add(FeedChangeEvent(
                            data: state.source, eventType: 'source'));
                      }
                    },
                  ),
                ],
                child: NewsListBuilder(
                  data: state.feeds,
                  onRefresh: _onRefresh,
                  hasMore: state.hasMore,
                  onLoadMore: () =>
                      _newsSourceFeedBloc.add(GetMoreSourceNewsEvent()),
                ),
              ),
            );
          } else if (state is NewsSourceFeedEmptyState) {
            return Center(
              child: EmptyDataView(
                text: state.message,
              ),
            );
          } else if (state is NewsSourceFeedErrorState) {
            return Center(
              child: ErrorDataView(
                onRetry: () => _newsSourceFeedBloc.add(GetSourceNewsEvent()),
              ),
            );
          }
          return Center(child: ProgressView());
        });
  }
}
