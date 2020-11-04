import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/core/widgets/comment_bar_placeholder_widget.dart';
import 'package:samachar_hub/core/widgets/empty_data_widget.dart';
import 'package:samachar_hub/core/widgets/error_data_widget.dart';
import 'package:samachar_hub/core/widgets/progress_widget.dart';
import 'package:samachar_hub/feature_main/presentation/blocs/settings/settings_cubit.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_feed_entity.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/bookmarks/bookmark_unbookmark/bookmark_un_bookmark_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/like_unlike/like_unlike_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_detail/news_detail_bloc.dart';
import 'package:samachar_hub/core/extensions/view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_source/follow_unfollow/follow_un_follow_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/view/view_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/ui/details/widgets/body.dart';
import 'package:samachar_hub/feature_news/presentation/ui/details/widgets/comment.dart';
import 'package:samachar_hub/feature_news/utils/provider.dart';

class NewsDetailScreen extends StatefulWidget {
  final NewsFeedEntity feedEntity;
  final BuildContext masterContext;

  const NewsDetailScreen(
      {Key key, @required this.feedEntity, @required this.masterContext})
      : super(key: key);

  static Future navigate(NewsFeedEntity feedEntity, BuildContext context) {
    if (context.bloc<SettingsCubit>().settings.newsReadMode == 2) {
      return GetIt.I
          .get<NavigationService>()
          .toWebViewScreen(feedEntity.title, feedEntity.link, context);
    }
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => NewsProvider.detailMultiBlocProvider(
          feed: feedEntity,
          child: NewsDetailScreen(
            feedEntity: feedEntity,
            masterContext: context,
          ),
        ),
      ),
    );
  }

  @override
  _NewsDetailScreenState createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.bloc<ViewBloc>().add(View());
  }

  Widget _buildComment() {
    return BlocBuilder<NewsDetailBloc, NewsDetailState>(
      buildWhen: (previous, current) => !(current is NewsDetailErrorState),
      builder: (context, detailState) {
        if (detailState is NewsDetailLoadSuccessState) {
          return NewsDetailComment(context: context, feed: detailState.feed);
        }
        return const CommentBarPlaceholder();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: MultiBlocListener(
        listeners: [
          BlocListener<LikeUnlikeBloc, LikeUnlikeState>(
            listener: (context, state) {
              if (state is NewsLikeSuccessState) {
                context
                    .bloc<NewsDetailBloc>()
                    .add(FeedChangeEvent(data: state.feed, eventType: 'feed'));
              } else if (state is NewsUnLikeSuccessState) {
                context
                    .bloc<NewsDetailBloc>()
                    .add(FeedChangeEvent(data: state.feed, eventType: 'feed'));
              }
            },
          ),
          BlocListener<BookmarkUnBookmarkBloc, BookmarkUnBookmarkState>(
            listener: (context, state) {
              if (state is BookmarkSuccess) {
                context
                    .bloc<NewsDetailBloc>()
                    .add(FeedChangeEvent(data: state.feed, eventType: 'feed'));
              } else if (state is UnbookmarkSuccess) {
                context
                    .bloc<NewsDetailBloc>()
                    .add(FeedChangeEvent(data: state.feed, eventType: 'feed'));
              }
            },
          ),
          BlocListener<SourceFollowUnFollowBloc, SourceFollowUnFollowState>(
            listener: (context, state) {
              if (state is SourceFollowSuccessState) {
                context.bloc<NewsDetailBloc>().add(
                    FeedChangeEvent(data: state.source, eventType: 'source'));
              } else if (state is SourceUnFollowSuccessState) {
                context.bloc<NewsDetailBloc>().add(
                    FeedChangeEvent(data: state.source, eventType: 'source'));
              }
            },
          ),
          BlocListener<NewsDetailBloc, NewsDetailState>(
            listener: (context, state) {
              if (state is NewsDetailErrorState) {
                context.showMessage(state.message);
              } else if (state is NewsDetailLoadErrorState) {
                context.showMessage(state.message);
              }
            },
          ),
        ],
        child: BlocBuilder<NewsDetailBloc, NewsDetailState>(
            buildWhen: (previous, current) =>
                !(current is NewsDetailErrorState),
            builder: (context, state) {
              if (state is NewsDetailInitialState) {
                return NewsDetailBody(
                    key: ValueKey(state.feed.id),
                    context: context,
                    feed: state.feed);
              } else if (state is NewsDetailLoadSuccessState) {
                return NewsDetailBody(
                    key: ValueKey(state.feed.id),
                    context: context,
                    feed: state.feed);
              } else if (state is NewsDetailLoadErrorState) {
                return Center(
                  child: ErrorDataView(
                    onRetry: () => context
                        .bloc<NewsDetailBloc>()
                        .add(GetNewsDetailEvent()),
                    message: state.message,
                  ),
                );
              } else if (state is NewsDetailEmptyState) {
                return Center(
                  child: EmptyDataView(
                    text: state.message,
                  ),
                );
              }

              return Center(
                child: ProgressView(),
              );
            }),
      ),
      bottomNavigationBar: BottomAppBar(
        child: _buildComment(),
      ),
    );
  }
}
