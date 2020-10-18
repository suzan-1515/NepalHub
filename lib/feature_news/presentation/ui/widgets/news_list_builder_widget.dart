import 'package:flutter/material.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/core/view/content_view_style.dart';
import 'package:samachar_hub/feature_news/domain/usecases/bookmark_news_use_case.dart';
import 'package:samachar_hub/feature_news/domain/usecases/dislike_news_use_case.dart';
import 'package:samachar_hub/feature_news/domain/usecases/follow_news_source_use_case.dart';
import 'package:samachar_hub/feature_news/domain/usecases/like_news_use_case.dart';
import 'package:samachar_hub/feature_news/domain/usecases/share_news_use_case.dart';
import 'package:samachar_hub/feature_news/domain/usecases/unbookmark_news_use_case.dart';
import 'package:samachar_hub/feature_news/domain/usecases/undislike_news_use_case.dart';
import 'package:samachar_hub/feature_news/domain/usecases/unfollow_news_source_use_case.dart';
import 'package:samachar_hub/feature_news/domain/usecases/unlike_news_use_case.dart';
import 'package:samachar_hub/feature_news/domain/usecases/view_news_use_case.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/bookmarks/bookmark_unbookmark/bookmark_un_bookmark_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/dislike/dislike_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/like_unlike/like_unlike_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_source/follow_unfollow/follow_un_follow_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/share/share_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/view/view_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_feed.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_compact_view.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_list_view.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_thumbnail_view.dart';
import 'package:samachar_hub/core/widgets/progress_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsListBuilder extends StatefulWidget {
  const NewsListBuilder({
    Key key,
    @required this.onRefresh,
    @required this.data,
    this.hasMore = false,
    this.contentViewStyle = ContentViewStyle.LIST_VIEW,
    this.onLoadMore,
  })  : assert(onRefresh != null, 'Refresh callback function cannot be null'),
        assert(data != null, 'News feeds cannot be null'),
        super(key: key);

  final Future<void> Function() onRefresh;
  final Function() onLoadMore;
  final List<NewsFeedUIModel> data;
  final bool hasMore;
  final ContentViewStyle contentViewStyle;

  @override
  _NewsListBuilderState createState() => _NewsListBuilderState();
}

class _NewsListBuilderState extends State<NewsListBuilder> {
  UseCase _likeNewsUseCase;
  UseCase _unlikeNewsUseCase;
  UseCase _dislikeNewsUseCase;
  UseCase _undislikeNewsUseCase;
  UseCase _followNewsSourceUseCase;
  UseCase _unfollowNewsSourceUseCase;
  UseCase _bookmarkNewsUseCase;
  UseCase _unbookmarkNewsUseCase;
  UseCase _shareNewsUseCase;
  UseCase _viewNewsUseCase;

  @override
  void initState() {
    super.initState();
    _likeNewsUseCase = context.repository<LikeNewsUseCase>();
    _likeNewsUseCase = context.repository<UnlikeNewsUseCase>();
    _dislikeNewsUseCase = context.repository<DislikeNewsUseCase>();
    _undislikeNewsUseCase = context.repository<UndislikeNewsUseCase>();
    _followNewsSourceUseCase = context.repository<FollowNewsSourceUseCase>();
    _unfollowNewsSourceUseCase =
        context.repository<UnFollowNewsSourceUseCase>();
    _bookmarkNewsUseCase = context.repository<BookmarkNewsUseCase>();
    _unbookmarkNewsUseCase = context.repository<UnBookmarkNewsUseCase>();
    _shareNewsUseCase = context.repository<ShareNewsUseCase>();
    _viewNewsUseCase = context.repository<ViewNewsUseCase>();
  }

  bool _shouldShowLoadMore(index) =>
      widget.hasMore && (index == widget.data.length);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: widget.onRefresh,
      child: ListView.builder(
        itemCount: widget.hasMore ? widget.data.length + 1 : widget.data,
        itemBuilder: (_, int index) {
          if (_shouldShowLoadMore(index))
            return Center(
              child: ProgressView(),
            );

          var feed = widget.data[index];
          var view;
          switch (widget.contentViewStyle) {
            case ContentViewStyle.LIST_VIEW:
              view = NewsListView(
                feedUIModel: feed,
              );
              break;
            case ContentViewStyle.THUMBNAIL_VIEW:
              view = NewsThumbnailView(
                feedUIModel: feed,
              );
              break;
            case ContentViewStyle.COMPACT_VIEW:
              view = NewsCompactView(
                feedUIModel: feed,
              );
              break;
          }
          return MultiBlocProvider(
            providers: [
              BlocProvider<LikeUnlikeBloc>(
                create: (context) => LikeUnlikeBloc(
                  newsFeedUIModel: feed,
                  likeNewsFeedUseCase: _likeNewsUseCase,
                  unLikeNewsFeedUseCase: _unlikeNewsUseCase,
                ),
              ),
              BlocProvider<DislikeBloc>(
                create: (context) => DislikeBloc(
                  newsFeedUIModel: feed,
                  dislikeNewsFeedUseCase: _dislikeNewsUseCase,
                  undislikeNewsFeedUseCase: _undislikeNewsUseCase,
                ),
              ),
              BlocProvider<FollowUnFollowBloc>(
                create: (context) => FollowUnFollowBloc(
                  followNewsSourceUseCase: _followNewsSourceUseCase,
                  unFollowNewsSourceUseCase: _unfollowNewsSourceUseCase,
                  newsSourceUIModel: feed.newsSourceUIModel,
                ),
              ),
              BlocProvider<BookmarkUnBookmarkBloc>(
                create: (context) => BookmarkUnBookmarkBloc(
                  newsFeedUIModel: feed,
                  addBookmarkNewsUseCase: _bookmarkNewsUseCase,
                  removeBookmarkNewsUseCase: _unbookmarkNewsUseCase,
                ),
              ),
              BlocProvider<ShareBloc>(
                create: (context) => ShareBloc(
                  feedUIModel: feed,
                  shareNewsFeedUseCase: _shareNewsUseCase,
                ),
              ),
              BlocProvider<ViewBloc>(
                create: (context) => ViewBloc(
                  feedUIModel: feed,
                  viewNewsFeedUseCase: _viewNewsUseCase,
                )..add(View()),
              ),
            ],
            child: view,
          );
        },
      ),
    );
  }
}
