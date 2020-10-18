import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/network/http_manager/http_manager.dart';
import 'package:samachar_hub/core/network/network_info.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_auth/data/repositories/auth_repository.dart';
import 'package:samachar_hub/feature_news/data/datasource/remote/news_remote_data_source.dart';
import 'package:samachar_hub/feature_news/data/repository/news_repository.dart';
import 'package:samachar_hub/feature_news/data/service/news_remote_service_impl.dart';
import 'package:samachar_hub/feature_news/domain/usecases/get_news_category_use_case.dart';
import 'package:samachar_hub/feature_news/domain/usecases/usecases.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/bookmarks/bookmark_news_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/bookmarks/bookmark_unbookmark/bookmark_un_bookmark_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/dislike/dislike_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/feed_bloc/feed_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/like_unlike/like_unlike_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_category/category_feeds/news_category_feed_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_category/follow_unfollow/follow_un_follow_bloc.dart'
    as newsCategory;
import 'package:samachar_hub/feature_news/presentation/blocs/news_detail/news_detail_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_source/follow_unfollow/follow_un_follow_bloc.dart'
    as newsSource;
import 'package:samachar_hub/feature_news/presentation/blocs/news_source/follow_unfollow/follow_un_follow_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_topic/follow_unfollow/follow_un_follow_bloc.dart'
    as newsTopic;
import 'package:samachar_hub/feature_news/presentation/blocs/news_category/news_category_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_filter/news_filter_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_source/news_sources_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_source/source_feeds/news_source_feed_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_topic/news_topic_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_topic/topic_feeds/news_topic_feed_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/related_news/related_news_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/share/share_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/view/view_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_category.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_feed.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_source.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_topic.dart';

class NewsProvider {
  NewsProvider._();
  static List<RepositoryProvider> get newsRepositoryProviders => [
        RepositoryProvider(
          create: (context) => NewsRepository(
            remoteDataSource: NewsRemoteDataSource(
              NewsRemoteService(
                context.repository<HttpManager>(),
              ),
            ),
            networkInfo: context.repository<NetworkInfoImpl>(),
            analyticsService: context.repository<AnalyticsService>(),
            authRepository: context.repository<AuthRepository>(),
          ),
        ),
      ];
  static List<RepositoryProvider> get news2RepositoryProviders => [
        RepositoryProvider(
          create: (context) =>
              BookmarkNewsUseCase(context.repository<NewsRepository>()),
        ),
        RepositoryProvider(
          create: (context) =>
              DislikeNewsUseCase(context.repository<NewsRepository>()),
        ),
        RepositoryProvider(
          create: (context) =>
              FollowNewsCategoryUseCase(context.repository<NewsRepository>()),
        ),
        RepositoryProvider(
          create: (context) =>
              FollowNewsSourceUseCase(context.repository<NewsRepository>()),
        ),
        RepositoryProvider(
          create: (context) =>
              FollowNewsTopicUseCase(context.repository<NewsRepository>()),
        ),
        RepositoryProvider(
          create: (context) =>
              GetBookmarkedNewsUseCase(context.repository<NewsRepository>()),
        ),
        RepositoryProvider(
          create: (context) => GetFollowedNewsCategoriesUseCase(
              context.repository<NewsRepository>()),
        ),
        RepositoryProvider(
          create: (context) => GetFollowedNewsSourcesUseCase(
              context.repository<NewsRepository>()),
        ),
        RepositoryProvider(
          create: (context) => GetFollowedNewsTopicsUseCase(
              context.repository<NewsRepository>()),
        ),
        RepositoryProvider(
          create: (context) =>
              GetLatestNewsUseCase(context.repository<NewsRepository>()),
        ),
        RepositoryProvider(
          create: (context) =>
              GetNewsByCategoryUseCase(context.repository<NewsRepository>()),
        ),
        RepositoryProvider(
          create: (context) =>
              GetNewsBySourceUseCase(context.repository<NewsRepository>()),
        ),
        RepositoryProvider(
          create: (context) =>
              GetNewsByTopicUseCase(context.repository<NewsRepository>()),
        ),
        RepositoryProvider(
          create: (context) =>
              GetNewsCategoriesUseCase(context.repository<NewsRepository>()),
        ),
        RepositoryProvider(
          create: (context) =>
              GetNewsByCategoryUseCase(context.repository<NewsRepository>()),
        ),
        RepositoryProvider(
          create: (context) =>
              GetNewsDetailUseCase(context.repository<NewsRepository>()),
        ),
        RepositoryProvider(
          create: (context) =>
              GetNewsSourcesUseCase(context.repository<NewsRepository>()),
        ),
        RepositoryProvider(
          create: (context) =>
              GetNewsTopicsUseCase(context.repository<NewsRepository>()),
        ),
        RepositoryProvider(
          create: (context) =>
              GetRecentNewsUseCase(context.repository<NewsRepository>()),
        ),
        RepositoryProvider(
          create: (context) =>
              GetRelatedNewsUseCase(context.repository<NewsRepository>()),
        ),
        RepositoryProvider(
          create: (context) =>
              GetTrendingNewsUseCase(context.repository<NewsRepository>()),
        ),
        RepositoryProvider(
          create: (context) =>
              LikeNewsUseCase(context.repository<NewsRepository>()),
        ),
        RepositoryProvider(
          create: (context) =>
              ShareNewsUseCase(context.repository<NewsRepository>()),
        ),
        RepositoryProvider(
          create: (context) =>
              UnBookmarkNewsUseCase(context.repository<NewsRepository>()),
        ),
        RepositoryProvider(
          create: (context) =>
              UndislikeNewsUseCase(context.repository<NewsRepository>()),
        ),
        RepositoryProvider(
          create: (context) =>
              UnFollowNewsCategoryUseCase(context.repository<NewsRepository>()),
        ),
        RepositoryProvider(
          create: (context) =>
              UnFollowNewsSourceUseCase(context.repository<NewsRepository>()),
        ),
        RepositoryProvider(
          create: (context) =>
              UnFollowNewsTopicUseCase(context.repository<NewsRepository>()),
        ),
        RepositoryProvider(
          create: (context) =>
              UnlikeNewsUseCase(context.repository<NewsRepository>()),
        ),
        RepositoryProvider(
          create: (context) =>
              ViewNewsUseCase(context.repository<NewsRepository>()),
        ),
      ];
  static BlocProvider feedBlocProvider({
    @required Widget child,
  }) =>
      BlocProvider<FeedBloc>(
        create: (context) => FeedBloc(
          latestNewsUseCase: context.repository<GetLatestNewsUseCase>(),
          recentNewsUseCase: context.repository<GetRecentNewsUseCase>(),
          trendingNewsUseCase: context.repository<GetTrendingNewsUseCase>(),
        ),
        child: child,
      );
  static BlocProvider detailBlocProvider({
    @required Widget child,
    @required NewsFeedUIModel feedUIModel,
  }) =>
      BlocProvider<NewsDetailBloc>(
        create: (context) => NewsDetailBloc(
          feed: feedUIModel,
          getDetailNewsUseCase: context.repository<GetNewsDetailUseCase>(),
        ),
        child: child,
      );
  static MultiBlocProvider detailMultiBlocProvider({
    @required Widget child,
    @required NewsFeedUIModel feedUIModel,
  }) =>
      MultiBlocProvider(
        providers: [
          BlocProvider<LikeUnlikeBloc>(
            create: (context) => LikeUnlikeBloc(
              newsFeedUIModel: feedUIModel,
              likeNewsFeedUseCase: context.repository<LikeNewsUseCase>(),
              unLikeNewsFeedUseCase: context.repository<UnlikeNewsUseCase>(),
            ),
          ),
          BlocProvider<DislikeBloc>(
            create: (context) => DislikeBloc(
              newsFeedUIModel: feedUIModel,
              dislikeNewsFeedUseCase: context.repository<DislikeNewsUseCase>(),
              undislikeNewsFeedUseCase:
                  context.repository<UndislikeNewsUseCase>(),
            ),
          ),
          BlocProvider<FollowUnFollowBloc>(
            create: (context) => FollowUnFollowBloc(
              followNewsSourceUseCase:
                  context.repository<FollowNewsSourceUseCase>(),
              unFollowNewsSourceUseCase:
                  context.repository<UnFollowNewsSourceUseCase>(),
              newsSourceUIModel: feedUIModel.newsSourceUIModel,
            ),
          ),
          BlocProvider<BookmarkUnBookmarkBloc>(
            create: (context) => BookmarkUnBookmarkBloc(
              newsFeedUIModel: feedUIModel,
              addBookmarkNewsUseCase: context.repository<BookmarkNewsUseCase>(),
              removeBookmarkNewsUseCase:
                  context.repository<UnBookmarkNewsUseCase>(),
            ),
          ),
          BlocProvider<ShareBloc>(
            create: (context) => ShareBloc(
              feedUIModel: feedUIModel,
              shareNewsFeedUseCase: context.repository<ShareNewsUseCase>(),
            ),
          ),
          BlocProvider<ViewBloc>(
            create: (context) => ViewBloc(
              feedUIModel: feedUIModel,
              viewNewsFeedUseCase: context.repository<ViewNewsUseCase>(),
            )..add(View()),
          ),
        ],
        child: child,
      );
  static BlocProvider relatedNewsBlocProvider({
    @required Widget child,
    @required NewsFeedUIModel feedUIModel,
  }) =>
      BlocProvider<RelatedNewsBloc>(
        create: (context) => RelatedNewsBloc(
          feed: feedUIModel,
          getRelatedNewsUseCase: context.repository<GetRelatedNewsUseCase>(),
        ),
        child: child,
      );
  static BlocProvider bookmarkBlocProvider({
    @required Widget child,
  }) =>
      BlocProvider<BookmarkNewsBloc>(
        create: (context) => BookmarkNewsBloc(
          getBookmarkNewsUseCase:
              context.repository<GetBookmarkedNewsUseCase>(),
        ),
        child: child,
      );
  static BlocProvider categoryBlocProvider({
    @required Widget child,
  }) =>
      BlocProvider<NewsCategoryBloc>(
        create: (context) => NewsCategoryBloc(
          getNewsCategoriesUseCase:
              context.repository<GetNewsCategoriesUseCase>(),
          getNewsFollowedCategoriesUseCase:
              context.repository<GetFollowedNewsCategoriesUseCase>(),
        ),
        child: child,
      );
  static BlocProvider sourceBlocProvider({
    @required Widget child,
  }) =>
      BlocProvider<NewsSourceBloc>(
        create: (context) => NewsSourceBloc(
          getNewsFollowedSourcesUseCase:
              context.repository<GetFollowedNewsSourcesUseCase>(),
          getNewsSourcesUseCase: context.repository<GetNewsSourcesUseCase>(),
        ),
        child: child,
      );
  static BlocProvider topicBlocProvider({
    @required Widget child,
  }) =>
      BlocProvider<NewsTopicBloc>(
        create: (context) => NewsTopicBloc(
          getNewsFollowedTopicsUseCase:
              context.repository<GetFollowedNewsTopicsUseCase>(),
          getNewsTopicsUseCase: context.repository<GetNewsTopicsUseCase>(),
        ),
        child: child,
      );
  static MultiBlocProvider categoryFeedBlocProvider(
          {@required Widget child,
          @required NewsCategoryUIModel newsCategoryUIModel}) =>
      MultiBlocProvider(
        providers: [
          BlocProvider<NewsFilterBloc>(
            create: (context) => NewsFilterBloc(
              getNewsSourcesUseCase:
                  context.repository<GetNewsSourcesUseCase>(),
            ),
          ),
          BlocProvider<newsCategory.FollowUnFollowBloc>(
            create: (context) => newsCategory.FollowUnFollowBloc(
              newsCategoryUIModel: newsCategoryUIModel,
              followNewsCategoryUseCase:
                  context.repository<FollowNewsCategoryUseCase>(),
              unFollowNewsCategoryUseCase:
                  context.repository<UnFollowNewsCategoryUseCase>(),
            ),
          ),
          BlocProvider<NewsCategoryFeedBloc>(
            create: (context) => NewsCategoryFeedBloc(
              categoryModel: newsCategoryUIModel,
              newsByCategoryUseCase:
                  context.repository<GetNewsByCategoryUseCase>(),
              newsFilterBloc: context.bloc<NewsFilterBloc>(),
            ),
          ),
        ],
        child: child,
      );
  static MultiBlocProvider sourceFeedBlocProvider(
          {@required Widget child,
          @required NewsSourceUIModel newsSourceUIModel}) =>
      MultiBlocProvider(
        providers: [
          BlocProvider<NewsFilterBloc>(
            create: (context) => NewsFilterBloc(
              getNewsSourcesUseCase:
                  context.repository<GetNewsSourcesUseCase>(),
            ),
          ),
          BlocProvider<newsSource.FollowUnFollowBloc>(
            create: (context) => newsSource.FollowUnFollowBloc(
              newsSourceUIModel: newsSourceUIModel,
              followNewsSourceUseCase:
                  context.repository<FollowNewsSourceUseCase>(),
              unFollowNewsSourceUseCase:
                  context.repository<UnFollowNewsSourceUseCase>(),
            ),
          ),
          BlocProvider<NewsSourceFeedBloc>(
            create: (context) => NewsSourceFeedBloc(
              sourceModel: newsSourceUIModel,
              newsFilterBloc: context.bloc<NewsFilterBloc>(),
              newsBySourceUseCase: context.repository<GetNewsBySourceUseCase>(),
            ),
          ),
        ],
        child: child,
      );
  static MultiBlocProvider topicFeedBlocProvider(
          {@required Widget child,
          @required NewsTopicUIModel newsTopicUIModel}) =>
      MultiBlocProvider(
        providers: [
          BlocProvider<NewsFilterBloc>(
            create: (context) => NewsFilterBloc(
              getNewsSourcesUseCase:
                  context.repository<GetNewsSourcesUseCase>(),
            ),
          ),
          BlocProvider<newsTopic.FollowUnFollowBloc>(
            create: (context) => newsTopic.FollowUnFollowBloc(
              newsTopicUIModel: newsTopicUIModel,
              followNewsTopicUseCase:
                  context.repository<FollowNewsTopicUseCase>(),
              unFollowNewsTopicUseCase:
                  context.repository<UnFollowNewsTopicUseCase>(),
            ),
          ),
          BlocProvider<NewsTopicFeedBloc>(
            create: (context) => NewsTopicFeedBloc(
              newsFilterBloc: context.bloc<NewsFilterBloc>(),
              newsByTopicUseCase: context.repository<GetNewsByTopicUseCase>(),
              topicModel: newsTopicUIModel,
            ),
          ),
        ],
        child: child,
      );
}
