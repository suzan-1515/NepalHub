import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/view/content_view_style.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/bookmarks/bookmark_unbookmark/bookmark_un_bookmark_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/like_unlike/like_unlike_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_source/follow_unfollow/follow_un_follow_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_feed.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_compact_view.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_list_view.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_thumbnail_view.dart';
import 'package:samachar_hub/core/widgets/progress_widget.dart';
import 'package:samachar_hub/feature_news/utils/provider.dart';
import 'package:scoped_model/scoped_model.dart';

class NewsListBuilder extends StatelessWidget {
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

  bool _shouldShowLoadMore(index) => hasMore && (index == data.length);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        itemCount: hasMore ? data.length + 1 : data.length,
        itemBuilder: (_, int index) {
          if (_shouldShowLoadMore(index)) {
            onLoadMore();
            return Center(
              child: ProgressView(),
            );
          }

          var feed = data[index];
          var view;
          switch (contentViewStyle) {
            case ContentViewStyle.LIST_VIEW:
              view = const NewsListView();
              break;
            case ContentViewStyle.THUMBNAIL_VIEW:
              view = const NewsThumbnailView();
              break;
            case ContentViewStyle.COMPACT_VIEW:
              view = const NewsCompactView();
              break;
          }
          return NewsProvider.feedItemBlocProvider(
            child: ScopedModel<NewsFeedUIModel>(
              model: feed,
              child: MultiBlocListener(
                listeners: [
                  BlocListener<LikeUnlikeBloc, LikeUnlikeState>(
                    listener: (context, state) {
                      if (state is NewsLikeSuccessState) {
                        ScopedModel.of<NewsFeedUIModel>(context).entity =
                            state.feed;
                      } else if (state is NewsUnLikeSuccessState) {
                        ScopedModel.of<NewsFeedUIModel>(context).entity =
                            state.feed;
                      }
                    },
                  ),
                  BlocListener<BookmarkUnBookmarkBloc, BookmarkUnBookmarkState>(
                    listener: (context, state) {
                      if (state is BookmarkSuccess) {
                        ScopedModel.of<NewsFeedUIModel>(context).entity =
                            state.feed;
                      } else if (state is UnbookmarkSuccess) {
                        ScopedModel.of<NewsFeedUIModel>(context).entity =
                            state.feed;
                      }
                    },
                  ),
                  BlocListener<SourceFollowUnFollowBloc,
                      SourceFollowUnFollowState>(
                    listener: (context, state) {
                      if (state is SourceFollowSuccessState) {
                        final entity =
                            ScopedModel.of<NewsFeedUIModel>(context).entity;
                        ScopedModel.of<NewsFeedUIModel>(context).entity =
                            entity.copyWith(source: state.source);
                      } else if (state is SourceUnFollowSuccessState) {
                        final entity =
                            ScopedModel.of<NewsFeedUIModel>(context).entity;
                        ScopedModel.of<NewsFeedUIModel>(context).entity =
                            entity.copyWith(source: state.source);
                      }
                    },
                  ),
                ],
                child: view,
              ),
            ),
          );
        },
      ),
    );
  }
}
