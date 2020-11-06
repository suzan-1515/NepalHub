import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_main/presentation/blocs/home/home_cubit.dart';
import 'package:samachar_hub/feature_main/presentation/ui/widgets/section_heading.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_feed_entity.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/bookmarks/bookmark_unbookmark/bookmark_un_bookmark_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/like_unlike/like_unlike_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_source/follow_unfollow/follow_un_follow_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_list_view.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_thumbnail_view.dart';
import 'package:samachar_hub/feature_news/utils/provider.dart';

class LatestNewsSection extends StatelessWidget {
  final List<NewsFeedEntity> latestNews;
  const LatestNewsSection({Key key, @required this.latestNews})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NewsProvider.feedItemBlocProvider(
      child: MultiBlocListener(
        listeners: [
          BlocListener<LikeUnlikeBloc, LikeUnlikeState>(
            listener: (context, state) {
              if (state is NewsLikeSuccessState) {
                context
                    .bloc<HomeCubit>()
                    .dataChangeEvent(data: state.feed, eventType: 'feed');
              } else if (state is NewsUnLikeSuccessState) {
                context
                    .bloc<HomeCubit>()
                    .dataChangeEvent(data: state.feed, eventType: 'feed');
              }
            },
          ),
          BlocListener<BookmarkUnBookmarkBloc, BookmarkUnBookmarkState>(
            listener: (context, state) {
              if (state is BookmarkSuccess) {
                context
                    .bloc<HomeCubit>()
                    .dataChangeEvent(data: state.feed, eventType: 'feed');
              } else if (state is UnbookmarkSuccess) {
                context
                    .bloc<HomeCubit>()
                    .dataChangeEvent(data: state.feed, eventType: 'feed');
              }
            },
          ),
          BlocListener<SourceFollowUnFollowBloc, SourceFollowUnFollowState>(
            listener: (context, state) {
              if (state is SourceFollowSuccessState) {
                context
                    .bloc<HomeCubit>()
                    .dataChangeEvent(data: state.source, eventType: 'source');
              } else if (state is SourceUnFollowSuccessState) {
                context
                    .bloc<HomeCubit>()
                    .dataChangeEvent(data: state.source, eventType: 'source');
              }
            },
          ),
        ],
        child: SliverList(
          delegate: SliverChildBuilderDelegate((_, int index) {
            if (index == 0) {
              return SectionHeading(
                title: 'Latest News',
                onTap: () => GetIt.I
                    .get<NavigationService>()
                    .toLatestNewsScreen(context),
              );
            }
            var feed = latestNews[index - 1];
            Widget feedWidget;
            if (index % 4 == 0) {
              feedWidget = NewsThumbnailView(
                feed: feed,
              );
            } else {
              feedWidget = NewsListView(
                feed: feed,
              );
            }
            return feedWidget;
          }, childCount: latestNews.length + 1),
        ),
      ),
    );
  }
}
