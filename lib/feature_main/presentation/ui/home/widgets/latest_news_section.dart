import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_main/presentation/models/home/latest_news_model.dart';
import 'package:samachar_hub/feature_main/presentation/ui/widgets/section_heading.dart';
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
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_list_view.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_thumbnail_view.dart';

class LatestNewsSection extends StatefulWidget {
  final LatestNewsUIModel latestNewsUIModel;
  const LatestNewsSection({Key key, @required this.latestNewsUIModel})
      : super(key: key);

  @override
  _LatestNewsSectionState createState() => _LatestNewsSectionState();
}

class _LatestNewsSectionState extends State<LatestNewsSection> {
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

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((_, int index) {
        if (index == 0) {
          SectionHeading(
            title: 'Latest News',
            subtitle: 'Latest stories around you',
          );
        }
        var feed = widget.latestNewsUIModel.feeds[index];
        Widget feedWidget;
        if (index % 4 == 0) {
          feedWidget = NewsThumbnailView(
            feedUIModel: feed,
          );
        } else {
          feedWidget = NewsListView(
            feedUIModel: feed,
          );
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
                    viewNewsFeedUseCase: _viewNewsUseCase, feedUIModel: feed)
                  ..add(View())),
          ],
          child: feedWidget,
        );
      }, childCount: widget.latestNewsUIModel.feeds.length + 1),
    );
  }
}
