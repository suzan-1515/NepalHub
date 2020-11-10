import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_main/presentation/models/home/latest_news_model.dart';
import 'package:samachar_hub/feature_main/presentation/ui/widgets/section_heading.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/bookmarks/bookmark_unbookmark/bookmark_un_bookmark_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_source/follow_unfollow/follow_un_follow_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_feed.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_list_view.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_thumbnail_view.dart';
import 'package:samachar_hub/feature_news/utils/provider.dart';
import 'package:scoped_model/scoped_model.dart';

class LatestNewsSection extends StatelessWidget {
  final LatestNewsUIModel latestNews;
  const LatestNewsSection({Key key, @required this.latestNews})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((_, int index) {
        if (index == 0) {
          return SectionHeading(
            title: 'Latest News',
            onTap: () =>
                GetIt.I.get<NavigationService>().toLatestNewsScreen(context),
          );
        }
        var feed = latestNews.feeds[index - 1];
        Widget feedWidget;
        if (index % 4 == 0) {
          feedWidget = const NewsThumbnailView();
        } else {
          feedWidget = const NewsListView();
        }
        return NewsProvider.feedItemBlocProvider(
          child: ScopedModel<NewsFeedUIModel>(
            model: feed,
            child: MultiBlocListener(
              listeners: [
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
              child: feedWidget,
            ),
          ),
        );
      }, childCount: latestNews.feeds.length + 1),
    );
  }
}
