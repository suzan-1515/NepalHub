import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
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
  static setup() {
    GetIt.I.registerLazySingleton<NewsRemoteService>(
        () => NewsRemoteService(GetIt.I.get<HttpManager>()));
    GetIt.I.registerLazySingleton<NewsRemoteDataSource>(
        () => NewsRemoteDataSource(GetIt.I.get<NewsRemoteService>()));
    GetIt.I.registerLazySingleton<NewsRepository>(() => NewsRepository(
        remoteDataSource: GetIt.I.get<NewsRemoteDataSource>(),
        networkInfo: GetIt.I.get<NetworkInfo>(),
        analyticsService: GetIt.I.get<AnalyticsService>(),
        authRepository: GetIt.I.get<AuthRepository>()));
    GetIt.I.registerLazySingleton<BookmarkNewsUseCase>(
        () => BookmarkNewsUseCase(GetIt.I.get<NewsRepository>()));
    GetIt.I.registerLazySingleton<DislikeNewsUseCase>(
        () => DislikeNewsUseCase(GetIt.I.get<NewsRepository>()));
    GetIt.I.registerLazySingleton<FollowNewsCategoryUseCase>(
        () => FollowNewsCategoryUseCase(GetIt.I.get<NewsRepository>()));
    GetIt.I.registerLazySingleton<FollowNewsSourceUseCase>(
        () => FollowNewsSourceUseCase(GetIt.I.get<NewsRepository>()));
    GetIt.I.registerLazySingleton<FollowNewsTopicUseCase>(
        () => FollowNewsTopicUseCase(GetIt.I.get<NewsRepository>()));
    GetIt.I.registerLazySingleton<GetBookmarkedNewsUseCase>(
        () => GetBookmarkedNewsUseCase(GetIt.I.get<NewsRepository>()));
    GetIt.I.registerLazySingleton<GetFollowedNewsCategoriesUseCase>(
        () => GetFollowedNewsCategoriesUseCase(GetIt.I.get<NewsRepository>()));
    GetIt.I.registerLazySingleton<GetFollowedNewsSourcesUseCase>(
        () => GetFollowedNewsSourcesUseCase(GetIt.I.get<NewsRepository>()));
    GetIt.I.registerLazySingleton<GetFollowedNewsTopicsUseCase>(
        () => GetFollowedNewsTopicsUseCase(GetIt.I.get<NewsRepository>()));
    GetIt.I.registerLazySingleton<GetLatestNewsUseCase>(
        () => GetLatestNewsUseCase(GetIt.I.get<NewsRepository>()));
    GetIt.I.registerLazySingleton<GetNewsByCategoryUseCase>(
        () => GetNewsByCategoryUseCase(GetIt.I.get<NewsRepository>()));
    GetIt.I.registerLazySingleton<GetNewsBySourceUseCase>(
        () => GetNewsBySourceUseCase(GetIt.I.get<NewsRepository>()));
    GetIt.I.registerLazySingleton<GetNewsByTopicUseCase>(
        () => GetNewsByTopicUseCase(GetIt.I.get<NewsRepository>()));
    GetIt.I.registerLazySingleton<GetNewsCategoriesUseCase>(
        () => GetNewsCategoriesUseCase(GetIt.I.get<NewsRepository>()));
    GetIt.I.registerLazySingleton<GetNewsDetailUseCase>(
        () => GetNewsDetailUseCase(GetIt.I.get<NewsRepository>()));
    GetIt.I.registerLazySingleton<GetNewsSourcesUseCase>(
        () => GetNewsSourcesUseCase(GetIt.I.get<NewsRepository>()));
    GetIt.I.registerLazySingleton<GetNewsTopicsUseCase>(
        () => GetNewsTopicsUseCase(GetIt.I.get<NewsRepository>()));
    GetIt.I.registerLazySingleton<GetRecentNewsUseCase>(
        () => GetRecentNewsUseCase(GetIt.I.get<NewsRepository>()));
    GetIt.I.registerLazySingleton<GetRelatedNewsUseCase>(
        () => GetRelatedNewsUseCase(GetIt.I.get<NewsRepository>()));
    GetIt.I.registerLazySingleton<GetTrendingNewsUseCase>(
        () => GetTrendingNewsUseCase(GetIt.I.get<NewsRepository>()));
    GetIt.I.registerLazySingleton<LikeNewsUseCase>(
        () => LikeNewsUseCase(GetIt.I.get<NewsRepository>()));
    GetIt.I.registerLazySingleton<ShareNewsUseCase>(
        () => ShareNewsUseCase(GetIt.I.get<NewsRepository>()));
    GetIt.I.registerLazySingleton<UnBookmarkNewsUseCase>(
        () => UnBookmarkNewsUseCase(GetIt.I.get<NewsRepository>()));
    GetIt.I.registerLazySingleton<UndislikeNewsUseCase>(
        () => UndislikeNewsUseCase(GetIt.I.get<NewsRepository>()));
    GetIt.I.registerLazySingleton<UnFollowNewsCategoryUseCase>(
        () => UnFollowNewsCategoryUseCase(GetIt.I.get<NewsRepository>()));
    GetIt.I.registerLazySingleton<UnFollowNewsSourceUseCase>(
        () => UnFollowNewsSourceUseCase(GetIt.I.get<NewsRepository>()));
    GetIt.I.registerLazySingleton<UnFollowNewsTopicUseCase>(
        () => UnFollowNewsTopicUseCase(GetIt.I.get<NewsRepository>()));
    GetIt.I.registerLazySingleton<UnlikeNewsUseCase>(
        () => UnlikeNewsUseCase(GetIt.I.get<NewsRepository>()));
    GetIt.I.registerLazySingleton<ViewNewsUseCase>(
        () => ViewNewsUseCase(GetIt.I.get<NewsRepository>()));

    GetIt.I.registerFactory<FeedBloc>(() => FeedBloc(
        latestNewsUseCase: GetIt.I.get<GetLatestNewsUseCase>(),
        recentNewsUseCase: GetIt.I.get<GetRecentNewsUseCase>(),
        trendingNewsUseCase: GetIt.I.get<GetTrendingNewsUseCase>()));
    GetIt.I.registerFactoryParam<NewsDetailBloc, NewsFeedUIModel, void>(
        (param1, param2) => NewsDetailBloc(
            feed: param1,
            getDetailNewsUseCase: GetIt.I.get<GetNewsDetailUseCase>())
          ..add(GetNewsDetailEvent()));
    GetIt.I.registerFactoryParam<LikeUnlikeBloc, NewsFeedUIModel, void>(
        (param1, param2) => LikeUnlikeBloc(
            newsFeedUIModel: param1,
            likeNewsFeedUseCase: GetIt.I.get<LikeNewsUseCase>(),
            unLikeNewsFeedUseCase: GetIt.I.get<UnlikeNewsUseCase>()));
    GetIt.I.registerFactoryParam<DislikeBloc, NewsFeedUIModel, void>(
        (param1, param2) => DislikeBloc(
              newsFeedUIModel: param1,
              dislikeNewsFeedUseCase: GetIt.I.get<DislikeNewsUseCase>(),
              undislikeNewsFeedUseCase: GetIt.I.get<UndislikeNewsUseCase>(),
            ));
    GetIt.I.registerFactoryParam<BookmarkUnBookmarkBloc, NewsFeedUIModel, void>(
        (param1, param2) => BookmarkUnBookmarkBloc(
              newsFeedUIModel: param1,
              addBookmarkNewsUseCase: GetIt.I.get<BookmarkNewsUseCase>(),
              removeBookmarkNewsUseCase: GetIt.I.get<UnBookmarkNewsUseCase>(),
            ));
    GetIt.I.registerFactoryParam<ShareBloc, NewsFeedUIModel, void>(
        (param1, param2) => ShareBloc(
              feedUIModel: param1,
              shareNewsFeedUseCase: GetIt.I.get<ShareNewsUseCase>(),
            ));
    GetIt.I.registerFactoryParam<ViewBloc, NewsFeedUIModel, void>(
        (param1, param2) => ViewBloc(
              feedUIModel: param1,
              viewNewsFeedUseCase: GetIt.I.get<ViewNewsUseCase>(),
            ));
    GetIt.I.registerFactoryParam<RelatedNewsBloc, NewsFeedUIModel, void>(
        (param1, param2) => RelatedNewsBloc(
              feed: param1,
              getRelatedNewsUseCase: GetIt.I.get<GetRelatedNewsUseCase>(),
            )..add(GetRelatedNewsEvent()));
    GetIt.I.registerFactory<BookmarkNewsBloc>(() => BookmarkNewsBloc(
          getBookmarkNewsUseCase: GetIt.I.get<GetBookmarkedNewsUseCase>(),
        )..add(GetBookmarkedNews()));
    GetIt.I.registerFactory<NewsCategoryBloc>(() => NewsCategoryBloc(
          getNewsCategoriesUseCase: GetIt.I.get<GetNewsCategoriesUseCase>(),
          getNewsFollowedCategoriesUseCase:
              GetIt.I.get<GetFollowedNewsCategoriesUseCase>(),
        ));
    GetIt.I.registerFactory<NewsSourceBloc>(() => NewsSourceBloc(
          getNewsFollowedSourcesUseCase:
              GetIt.I.get<GetFollowedNewsSourcesUseCase>(),
          getNewsSourcesUseCase: GetIt.I.get<GetNewsSourcesUseCase>(),
        ));
    GetIt.I.registerFactory<NewsTopicBloc>(() => NewsTopicBloc(
          getNewsFollowedTopicsUseCase:
              GetIt.I.get<GetFollowedNewsTopicsUseCase>(),
          getNewsTopicsUseCase: GetIt.I.get<GetNewsTopicsUseCase>(),
        ));
    GetIt.I.registerFactory<NewsFilterBloc>(() => NewsFilterBloc(
          getNewsSourcesUseCase: GetIt.I.get<GetNewsSourcesUseCase>(),
        )..add(GetNewsFilterSourcesEvent()));
    GetIt.I.registerFactoryParam<newsCategory.FollowUnFollowBloc,
            NewsCategoryUIModel, void>(
        (param1, param2) => newsCategory.FollowUnFollowBloc(
              newsCategoryUIModel: param1,
              followNewsCategoryUseCase:
                  GetIt.I.get<FollowNewsCategoryUseCase>(),
              unFollowNewsCategoryUseCase:
                  GetIt.I.get<UnFollowNewsCategoryUseCase>(),
            ));
    GetIt.I.registerFactoryParam<newsSource.FollowUnFollowBloc,
            NewsSourceUIModel, void>(
        (param1, param2) => newsSource.FollowUnFollowBloc(
              newsSourceUIModel: param1,
              followNewsSourceUseCase: GetIt.I.get<FollowNewsSourceUseCase>(),
              unFollowNewsSourceUseCase:
                  GetIt.I.get<UnFollowNewsSourceUseCase>(),
            ));
    GetIt.I.registerFactoryParam<newsTopic.FollowUnFollowBloc,
            NewsTopicUIModel, void>(
        (param1, param2) => newsTopic.FollowUnFollowBloc(
              newsTopicUIModel: param1,
              followNewsTopicUseCase: GetIt.I.get<FollowNewsTopicUseCase>(),
              unFollowNewsTopicUseCase: GetIt.I.get<UnFollowNewsTopicUseCase>(),
            ));
    GetIt.I
        .registerFactoryParam<NewsCategoryFeedBloc, NewsCategoryUIModel, void>(
            (param1, param2) => NewsCategoryFeedBloc(
                  categoryModel: param1,
                  newsByCategoryUseCase:
                      GetIt.I.get<GetNewsByCategoryUseCase>(),
                  newsFilterBloc: GetIt.I.get<NewsFilterBloc>(),
                )..add(GetCategoryNewsEvent()));
    GetIt.I.registerFactoryParam<NewsSourceFeedBloc, NewsSourceUIModel, void>(
        (param1, param2) => NewsSourceFeedBloc(
              sourceModel: param1,
              newsFilterBloc: GetIt.I.get<NewsFilterBloc>(),
              newsBySourceUseCase: GetIt.I.get<GetNewsBySourceUseCase>(),
            )..add(GetSourceNewsEvent()));
    GetIt.I.registerFactoryParam<NewsTopicFeedBloc, NewsTopicUIModel, void>(
        (param1, param2) => NewsTopicFeedBloc(
              newsFilterBloc: GetIt.I.get<NewsFilterBloc>(),
              newsByTopicUseCase: GetIt.I.get<GetNewsByTopicUseCase>(),
              topicModel: param1,
            )..add(GetTopicNewsEvent()));
  }

  static List<RepositoryProvider> get newsRepositoryProviders => [
        RepositoryProvider<NewsRemoteService>(
          create: (context) => NewsRemoteService(
            GetIt.I.get<HttpManager>(),
          ),
        ),
        RepositoryProvider<NewsRemoteDataSource>(
          create: (context) => NewsRemoteDataSource(
            GetIt.I.get<NewsRemoteService>(),
          ),
        ),
        RepositoryProvider<NewsRepository>(
          create: (context) => NewsRepository(
            remoteDataSource: GetIt.I.get<NewsRemoteDataSource>(),
            networkInfo: GetIt.I.get<NetworkInfo>(),
            analyticsService: GetIt.I.get<AnalyticsService>(),
            authRepository: GetIt.I.get<AuthRepository>(),
          ),
        ),
        RepositoryProvider<BookmarkNewsUseCase>(
          create: (context) =>
              BookmarkNewsUseCase(GetIt.I.get<NewsRepository>()),
        ),
        RepositoryProvider<DislikeNewsUseCase>(
          create: (context) =>
              DislikeNewsUseCase(GetIt.I.get<NewsRepository>()),
        ),
        RepositoryProvider<FollowNewsCategoryUseCase>(
          create: (context) =>
              FollowNewsCategoryUseCase(GetIt.I.get<NewsRepository>()),
        ),
        RepositoryProvider<FollowNewsSourceUseCase>(
          create: (context) =>
              FollowNewsSourceUseCase(GetIt.I.get<NewsRepository>()),
        ),
        RepositoryProvider<FollowNewsTopicUseCase>(
          create: (context) =>
              FollowNewsTopicUseCase(GetIt.I.get<NewsRepository>()),
        ),
        RepositoryProvider<GetBookmarkedNewsUseCase>(
          create: (context) =>
              GetBookmarkedNewsUseCase(GetIt.I.get<NewsRepository>()),
        ),
        RepositoryProvider<GetFollowedNewsCategoriesUseCase>(
          create: (context) =>
              GetFollowedNewsCategoriesUseCase(GetIt.I.get<NewsRepository>()),
        ),
        RepositoryProvider<GetFollowedNewsSourcesUseCase>(
          create: (context) =>
              GetFollowedNewsSourcesUseCase(GetIt.I.get<NewsRepository>()),
        ),
        RepositoryProvider<GetFollowedNewsTopicsUseCase>(
          create: (context) =>
              GetFollowedNewsTopicsUseCase(GetIt.I.get<NewsRepository>()),
        ),
        RepositoryProvider<GetLatestNewsUseCase>(
          create: (context) =>
              GetLatestNewsUseCase(GetIt.I.get<NewsRepository>()),
        ),
        RepositoryProvider<GetNewsByCategoryUseCase>(
          create: (context) =>
              GetNewsByCategoryUseCase(GetIt.I.get<NewsRepository>()),
        ),
        RepositoryProvider<GetNewsBySourceUseCase>(
          create: (context) =>
              GetNewsBySourceUseCase(GetIt.I.get<NewsRepository>()),
        ),
        RepositoryProvider<GetNewsByTopicUseCase>(
          create: (context) =>
              GetNewsByTopicUseCase(GetIt.I.get<NewsRepository>()),
        ),
        RepositoryProvider<GetNewsCategoriesUseCase>(
          create: (context) =>
              GetNewsCategoriesUseCase(GetIt.I.get<NewsRepository>()),
        ),
        RepositoryProvider<GetNewsDetailUseCase>(
          create: (context) =>
              GetNewsDetailUseCase(GetIt.I.get<NewsRepository>()),
        ),
        RepositoryProvider<GetNewsSourcesUseCase>(
          create: (context) =>
              GetNewsSourcesUseCase(GetIt.I.get<NewsRepository>()),
        ),
        RepositoryProvider<GetNewsTopicsUseCase>(
          create: (context) =>
              GetNewsTopicsUseCase(GetIt.I.get<NewsRepository>()),
        ),
        RepositoryProvider<GetRecentNewsUseCase>(
          create: (context) =>
              GetRecentNewsUseCase(GetIt.I.get<NewsRepository>()),
        ),
        RepositoryProvider<GetRelatedNewsUseCase>(
          create: (context) =>
              GetRelatedNewsUseCase(GetIt.I.get<NewsRepository>()),
        ),
        RepositoryProvider<GetTrendingNewsUseCase>(
          create: (context) =>
              GetTrendingNewsUseCase(GetIt.I.get<NewsRepository>()),
        ),
        RepositoryProvider<LikeNewsUseCase>(
          create: (context) => LikeNewsUseCase(GetIt.I.get<NewsRepository>()),
        ),
        RepositoryProvider<ShareNewsUseCase>(
          create: (context) => ShareNewsUseCase(GetIt.I.get<NewsRepository>()),
        ),
        RepositoryProvider<UnBookmarkNewsUseCase>(
          create: (context) =>
              UnBookmarkNewsUseCase(GetIt.I.get<NewsRepository>()),
        ),
        RepositoryProvider<UndislikeNewsUseCase>(
          create: (context) =>
              UndislikeNewsUseCase(GetIt.I.get<NewsRepository>()),
        ),
        RepositoryProvider<UnFollowNewsCategoryUseCase>(
          create: (context) =>
              UnFollowNewsCategoryUseCase(GetIt.I.get<NewsRepository>()),
        ),
        RepositoryProvider<UnFollowNewsSourceUseCase>(
          create: (context) =>
              UnFollowNewsSourceUseCase(GetIt.I.get<NewsRepository>()),
        ),
        RepositoryProvider<UnFollowNewsTopicUseCase>(
          create: (context) =>
              UnFollowNewsTopicUseCase(GetIt.I.get<NewsRepository>()),
        ),
        RepositoryProvider<UnlikeNewsUseCase>(
          create: (context) => UnlikeNewsUseCase(GetIt.I.get<NewsRepository>()),
        ),
        RepositoryProvider<ViewNewsUseCase>(
          create: (context) => ViewNewsUseCase(GetIt.I.get<NewsRepository>()),
        ),
      ];
  static BlocProvider<FeedBloc> feedBlocProvider({
    @required Widget child,
  }) =>
      BlocProvider<FeedBloc>(
        create: (context) => GetIt.I.get<FeedBloc>(),
        child: child,
      );

  static MultiBlocProvider feedItemBlocProvider({
    @required Widget child,
    @required NewsFeedUIModel feedUIModel,
  }) =>
      MultiBlocProvider(
        providers: [
          BlocProvider<LikeUnlikeBloc>(
            create: (context) =>
                GetIt.I.get<LikeUnlikeBloc>(param1: feedUIModel),
          ),
          BlocProvider<DislikeBloc>(
            create: (context) => GetIt.I.get<DislikeBloc>(param1: feedUIModel),
          ),
          BlocProvider<newsSource.FollowUnFollowBloc>(
            create: (context) => GetIt.I.get<newsSource.FollowUnFollowBloc>(
                param1: feedUIModel.newsSourceUIModel),
          ),
          BlocProvider<BookmarkUnBookmarkBloc>(
            create: (context) =>
                GetIt.I.get<BookmarkUnBookmarkBloc>(param1: feedUIModel),
          ),
          BlocProvider<ShareBloc>(
            create: (context) => GetIt.I.get<ShareBloc>(param1: feedUIModel),
          ),
        ],
        child: child,
      );

  static BlocProvider<NewsDetailBloc> detailBlocProvider({
    @required Widget child,
    @required NewsFeedUIModel feedUIModel,
  }) =>
      BlocProvider<NewsDetailBloc>(
        create: (context) => GetIt.I.get<NewsDetailBloc>(param1: feedUIModel),
        child: child,
      );
  static MultiBlocProvider detailMultiBlocProvider({
    @required Widget child,
    @required NewsFeedUIModel feedUIModel,
  }) =>
      MultiBlocProvider(
        providers: [
          BlocProvider<LikeUnlikeBloc>(
            create: (context) =>
                GetIt.I.get<LikeUnlikeBloc>(param1: feedUIModel),
          ),
          BlocProvider<DislikeBloc>(
            create: (context) => GetIt.I.get<DislikeBloc>(param1: feedUIModel),
          ),
          BlocProvider<newsSource.FollowUnFollowBloc>(
            create: (context) => GetIt.I.get<newsSource.FollowUnFollowBloc>(
                param1: feedUIModel.newsSourceUIModel),
          ),
          BlocProvider<BookmarkUnBookmarkBloc>(
            create: (context) =>
                GetIt.I.get<BookmarkUnBookmarkBloc>(param1: feedUIModel),
          ),
          BlocProvider<ShareBloc>(
            create: (context) => GetIt.I.get<ShareBloc>(param1: feedUIModel),
          ),
          BlocProvider<ViewBloc>(
            create: (context) => GetIt.I.get<ViewBloc>(param1: feedUIModel),
          ),
          BlocProvider<NewsDetailBloc>(
            create: (context) =>
                GetIt.I.get<NewsDetailBloc>(param1: feedUIModel),
          ),
        ],
        child: child,
      );
  static BlocProvider<RelatedNewsBloc> relatedNewsBlocProvider({
    @required Widget child,
    @required NewsFeedUIModel feedUIModel,
  }) =>
      BlocProvider<RelatedNewsBloc>(
        create: (context) => GetIt.I.get<RelatedNewsBloc>(param1: feedUIModel),
        child: child,
      );
  static BlocProvider<BookmarkNewsBloc> bookmarkBlocProvider({
    @required Widget child,
  }) =>
      BlocProvider<BookmarkNewsBloc>(
        create: (context) => GetIt.I.get<BookmarkNewsBloc>(),
        child: child,
      );

  static MultiBlocProvider categoryFeedBlocProvider(
          {@required Widget child,
          @required NewsCategoryUIModel newsCategoryUIModel}) =>
      MultiBlocProvider(
        providers: [
          BlocProvider<NewsFilterBloc>(
            create: (context) => GetIt.I.get<NewsFilterBloc>(),
          ),
          BlocProvider<newsCategory.FollowUnFollowBloc>(
            create: (context) => GetIt.I.get<newsCategory.FollowUnFollowBloc>(
                param1: newsCategoryUIModel),
          ),
          BlocProvider<NewsCategoryFeedBloc>(
            create: (context) =>
                GetIt.I.get<NewsCategoryFeedBloc>(param1: newsCategoryUIModel),
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
            create: (context) => GetIt.I.get<NewsFilterBloc>(),
          ),
          BlocProvider<newsSource.FollowUnFollowBloc>(
            create: (context) => GetIt.I
                .get<newsSource.FollowUnFollowBloc>(param1: newsSourceUIModel),
          ),
          BlocProvider<NewsSourceFeedBloc>(
            create: (context) =>
                GetIt.I.get<NewsSourceFeedBloc>(param1: newsSourceUIModel),
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
            create: (context) => GetIt.I.get<NewsFilterBloc>(),
          ),
          BlocProvider<newsTopic.FollowUnFollowBloc>(
            create: (context) => GetIt.I
                .get<newsTopic.FollowUnFollowBloc>(param1: newsTopicUIModel),
          ),
          BlocProvider<NewsTopicFeedBloc>(
            create: (context) =>
                GetIt.I.get<NewsTopicFeedBloc>(param1: newsTopicUIModel),
          ),
        ],
        child: child,
      );
  static MultiBlocProvider feedMoreOptionMultiBlocProvider({
    @required Widget child,
    @required NewsFeedUIModel feedUIModel,
  }) =>
      MultiBlocProvider(
        providers: [
          BlocProvider<newsSource.FollowUnFollowBloc>(
            create: (context) => GetIt.I.get<newsSource.FollowUnFollowBloc>(
                param1: feedUIModel.newsSourceUIModel),
          ),
          BlocProvider<BookmarkUnBookmarkBloc>(
            create: (context) =>
                GetIt.I.get<BookmarkUnBookmarkBloc>(param1: feedUIModel),
          ),
          BlocProvider<ShareBloc>(
            create: (context) => GetIt.I.get<ShareBloc>(param1: feedUIModel),
          ),
          BlocProvider<DislikeBloc>(
            create: (context) => GetIt.I.get<DislikeBloc>(param1: feedUIModel),
          ),
        ],
        child: child,
      );
}
