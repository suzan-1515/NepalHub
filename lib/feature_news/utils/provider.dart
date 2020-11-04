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
import 'package:samachar_hub/feature_news/domain/entities/news_category_entity.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_feed_entity.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_source_entity.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_topic_entity.dart';
import 'package:samachar_hub/feature_news/domain/usecases/get_news_category_use_case.dart';
import 'package:samachar_hub/feature_news/domain/usecases/usecases.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/bookmarks/bookmark_news_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/bookmarks/bookmark_unbookmark/bookmark_un_bookmark_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/dislike/dislike_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/feed_bloc/feed_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/like_unlike/like_unlike_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_category/category_feeds/news_category_feed_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_category/follow_unfollow/follow_un_follow_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_detail/news_detail_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_source/follow_unfollow/follow_un_follow_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_topic/follow_unfollow/follow_un_follow_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_category/news_category_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_filter/news_filter_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_source/news_sources_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_source/source_feeds/news_source_feed_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_topic/news_topic_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_topic/topic_feeds/news_topic_feed_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/related_news/related_news_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/share/share_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/view/view_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_feed.dart';

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
          trendingNewsUseCase: GetIt.I.get<GetTrendingNewsUseCase>(),
        ));
    GetIt.I.registerFactoryParam<NewsDetailBloc, NewsFeedEntity, void>(
        (param1, param2) => NewsDetailBloc(
            feed: param1,
            getDetailNewsUseCase: GetIt.I.get<GetNewsDetailUseCase>())
          ..add(GetNewsDetailEvent()));
    GetIt.I.registerFactory<LikeUnlikeBloc>(() => LikeUnlikeBloc(
        likeNewsFeedUseCase: GetIt.I.get<LikeNewsUseCase>(),
        unLikeNewsFeedUseCase: GetIt.I.get<UnlikeNewsUseCase>()));
    GetIt.I.registerFactory<DislikeBloc>(() => DislikeBloc(
          dislikeNewsFeedUseCase: GetIt.I.get<DislikeNewsUseCase>(),
          undislikeNewsFeedUseCase: GetIt.I.get<UndislikeNewsUseCase>(),
        ));
    GetIt.I
        .registerFactory<BookmarkUnBookmarkBloc>(() => BookmarkUnBookmarkBloc(
              addBookmarkNewsUseCase: GetIt.I.get<BookmarkNewsUseCase>(),
              removeBookmarkNewsUseCase: GetIt.I.get<UnBookmarkNewsUseCase>(),
            ));
    GetIt.I.registerFactory<ShareBloc>(() => ShareBloc(
          shareNewsFeedUseCase: GetIt.I.get<ShareNewsUseCase>(),
        ));
    GetIt.I.registerFactoryParam<ViewBloc, NewsFeedEntity, void>(
        (param1, param2) => ViewBloc(
              feed: param1,
              viewNewsFeedUseCase: GetIt.I.get<ViewNewsUseCase>(),
            ));
    GetIt.I.registerFactoryParam<RelatedNewsBloc, NewsFeedEntity, void>(
        (param1, param2) => RelatedNewsBloc(
              feed: param1,
              getRelatedNewsUseCase: GetIt.I.get<GetRelatedNewsUseCase>(),
            )..add(GetRelatedNewsEvent()));
    GetIt.I.registerFactory<BookmarkNewsBloc>(() => BookmarkNewsBloc(
          getBookmarkNewsUseCase: GetIt.I.get<GetBookmarkedNewsUseCase>(),
        )..add(GetBookmarkedNews()));
    GetIt.I.registerFactoryParam<
            NewsCategoryBloc, CategoryFollowUnFollowBloc, void>(
        (param1, param2) => NewsCategoryBloc(
              getNewsCategoriesUseCase: GetIt.I.get<GetNewsCategoriesUseCase>(),
              getNewsFollowedCategoriesUseCase:
                  GetIt.I.get<GetFollowedNewsCategoriesUseCase>(),
              followUnFollowBloc: param1,
            ));
    GetIt.I
        .registerFactoryParam<NewsSourceBloc, SourceFollowUnFollowBloc, void>(
            (param1, param2) => NewsSourceBloc(
                  getNewsFollowedSourcesUseCase:
                      GetIt.I.get<GetFollowedNewsSourcesUseCase>(),
                  getNewsSourcesUseCase: GetIt.I.get<GetNewsSourcesUseCase>(),
                  followUnFollowBloc: param1,
                ));
    GetIt.I.registerFactoryParam<NewsTopicBloc, TopicFollowUnFollowBloc, void>(
        (param1, param2) => NewsTopicBloc(
              getNewsFollowedTopicsUseCase:
                  GetIt.I.get<GetFollowedNewsTopicsUseCase>(),
              getNewsTopicsUseCase: GetIt.I.get<GetNewsTopicsUseCase>(),
              followUnFollowBloc: param1,
            ));
    GetIt.I.registerFactory<NewsFilterBloc>(() => NewsFilterBloc(
          getNewsSourcesUseCase: GetIt.I.get<GetNewsSourcesUseCase>(),
        )..add(GetNewsFilterSourcesEvent()));
    GetIt.I.registerFactory<CategoryFollowUnFollowBloc>(() =>
        CategoryFollowUnFollowBloc(
          followNewsCategoryUseCase: GetIt.I.get<FollowNewsCategoryUseCase>(),
          unFollowNewsCategoryUseCase:
              GetIt.I.get<UnFollowNewsCategoryUseCase>(),
        ));
    GetIt.I.registerFactory<SourceFollowUnFollowBloc>(() =>
        SourceFollowUnFollowBloc(
          followNewsSourceUseCase: GetIt.I.get<FollowNewsSourceUseCase>(),
          unFollowNewsSourceUseCase: GetIt.I.get<UnFollowNewsSourceUseCase>(),
        ));
    GetIt.I
        .registerFactory<TopicFollowUnFollowBloc>(() => TopicFollowUnFollowBloc(
              followNewsTopicUseCase: GetIt.I.get<FollowNewsTopicUseCase>(),
              unFollowNewsTopicUseCase: GetIt.I.get<UnFollowNewsTopicUseCase>(),
            ));
    GetIt.I.registerFactoryParam<NewsCategoryFeedBloc,
            NewsCategoryEntity, NewsFilterBloc>(
        (param1, param2) => NewsCategoryFeedBloc(
              category: param1,
              newsByCategoryUseCase: GetIt.I.get<GetNewsByCategoryUseCase>(),
              newsFilterBloc: param2,
            )..add(GetCategoryNewsEvent()));
    GetIt.I.registerFactoryParam<NewsSourceFeedBloc,
            NewsSourceEntity, NewsFilterBloc>(
        (param1, param2) => NewsSourceFeedBloc(
              source: param1,
              newsFilterBloc: param2,
              newsBySourceUseCase: GetIt.I.get<GetNewsBySourceUseCase>(),
            )..add(GetSourceNewsEvent()));
    GetIt.I.registerFactoryParam<
            NewsTopicFeedBloc, NewsTopicEntity, NewsFilterBloc>(
        (param1, param2) => NewsTopicFeedBloc(
              newsFilterBloc: param2,
              newsByTopicUseCase: GetIt.I.get<GetNewsByTopicUseCase>(),
              topic: param1,
            )..add(GetTopicNewsEvent()));
  }

  static BlocProvider<FeedBloc> feedBlocProvider({
    @required Widget child,
  }) =>
      BlocProvider<FeedBloc>(
        create: (context) => GetIt.I.get<FeedBloc>(),
        child: child,
      );

  static MultiBlocProvider feedItemBlocProvider({
    @required Widget child,
  }) =>
      MultiBlocProvider(
        providers: [
          BlocProvider<LikeUnlikeBloc>(
            create: (context) => GetIt.I.get<LikeUnlikeBloc>(),
          ),
          BlocProvider<BookmarkUnBookmarkBloc>(
            create: (context) => GetIt.I.get<BookmarkUnBookmarkBloc>(),
          ),
          BlocProvider<DislikeBloc>(
            create: (context) => GetIt.I.get<DislikeBloc>(),
          ),
          BlocProvider<SourceFollowUnFollowBloc>(
            create: (context) => GetIt.I.get<SourceFollowUnFollowBloc>(),
          ),
          BlocProvider<ShareBloc>(
            create: (context) => GetIt.I.get<ShareBloc>(),
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
    @required NewsFeedEntity feed,
  }) =>
      MultiBlocProvider(
        providers: [
          BlocProvider<LikeUnlikeBloc>(
            create: (context) => GetIt.I.get<LikeUnlikeBloc>(),
          ),
          BlocProvider<DislikeBloc>(
            create: (context) => GetIt.I.get<DislikeBloc>(param1: feed),
          ),
          BlocProvider<SourceFollowUnFollowBloc>(
            create: (context) => GetIt.I.get<SourceFollowUnFollowBloc>(),
          ),
          BlocProvider<BookmarkUnBookmarkBloc>(
            create: (context) => GetIt.I.get<BookmarkUnBookmarkBloc>(),
          ),
          BlocProvider<ShareBloc>(
            create: (context) => GetIt.I.get<ShareBloc>(),
          ),
          BlocProvider<ViewBloc>(
            create: (context) => GetIt.I.get<ViewBloc>(param1: feed),
          ),
          BlocProvider<NewsDetailBloc>(
            create: (context) => GetIt.I.get<NewsDetailBloc>(param1: feed),
          ),
        ],
        child: child,
      );

  static BlocProvider<RelatedNewsBloc> relatedNewsBlocProvider({
    @required Widget child,
    @required NewsFeedEntity feed,
  }) =>
      BlocProvider<RelatedNewsBloc>(
        create: (context) => GetIt.I.get<RelatedNewsBloc>(param1: feed),
        child: child,
      );

  static BlocProvider<BookmarkNewsBloc> bookmarkBlocProvider({
    @required Widget child,
  }) =>
      BlocProvider<BookmarkNewsBloc>(
        create: (context) => GetIt.I.get<BookmarkNewsBloc>(),
        child: child,
      );

  static MultiBlocProvider categoryBlocProvider({@required Widget child}) =>
      MultiBlocProvider(
        providers: [
          BlocProvider<CategoryFollowUnFollowBloc>(
            create: (context) => GetIt.I.get<CategoryFollowUnFollowBloc>(),
          ),
          BlocProvider<NewsCategoryBloc>(
            create: (context) => GetIt.I.get<NewsCategoryBloc>(
              param1: context.bloc<CategoryFollowUnFollowBloc>(),
            ),
          ),
        ],
        child: child,
      );

  static MultiBlocProvider categoryFeedBlocProvider(
          {@required Widget child,
          @required NewsCategoryEntity newsCategoryUIModel}) =>
      MultiBlocProvider(
        providers: [
          BlocProvider<NewsFilterBloc>(
            create: (context) => GetIt.I.get<NewsFilterBloc>(),
          ),
          BlocProvider<CategoryFollowUnFollowBloc>(
            create: (context) => GetIt.I.get<CategoryFollowUnFollowBloc>(),
          ),
          BlocProvider<NewsCategoryFeedBloc>(
            create: (context) => GetIt.I.get<NewsCategoryFeedBloc>(
                param1: newsCategoryUIModel,
                param2: context.bloc<NewsFilterBloc>()),
          ),
        ],
        child: child,
      );

  static MultiBlocProvider sourceBlocProvider({@required Widget child}) =>
      MultiBlocProvider(
        providers: [
          BlocProvider<SourceFollowUnFollowBloc>(
            create: (context) => GetIt.I.get<SourceFollowUnFollowBloc>(),
          ),
          BlocProvider<NewsSourceBloc>(
            create: (context) => GetIt.I.get<NewsSourceBloc>(
              param1: context.bloc<SourceFollowUnFollowBloc>(),
            ),
          ),
        ],
        child: child,
      );

  static MultiBlocProvider sourceFeedBlocProvider(
          {@required Widget child, @required NewsSourceEntity source}) =>
      MultiBlocProvider(
        providers: [
          BlocProvider<NewsFilterBloc>(
            create: (context) => GetIt.I.get<NewsFilterBloc>(),
          ),
          BlocProvider<SourceFollowUnFollowBloc>(
            create: (context) => GetIt.I.get<SourceFollowUnFollowBloc>(),
          ),
          BlocProvider<NewsSourceFeedBloc>(
            create: (context) => GetIt.I.get<NewsSourceFeedBloc>(
                param1: source, param2: context.bloc<NewsFilterBloc>()),
          ),
        ],
        child: child,
      );

  static MultiBlocProvider topicBlocProvider({@required Widget child}) =>
      MultiBlocProvider(
        providers: [
          BlocProvider<TopicFollowUnFollowBloc>(
            create: (context) => GetIt.I.get<TopicFollowUnFollowBloc>(),
          ),
          BlocProvider<NewsTopicBloc>(
            create: (context) => GetIt.I.get<NewsTopicBloc>(
              param1: context.bloc<TopicFollowUnFollowBloc>(),
            ),
          ),
        ],
        child: child,
      );

  static MultiBlocProvider topicFeedBlocProvider(
          {@required Widget child, @required NewsTopicEntity topic}) =>
      MultiBlocProvider(
        providers: [
          BlocProvider<NewsFilterBloc>(
            create: (context) => GetIt.I.get<NewsFilterBloc>(),
          ),
          BlocProvider<TopicFollowUnFollowBloc>(
            create: (context) => GetIt.I.get<TopicFollowUnFollowBloc>(),
          ),
          BlocProvider<NewsTopicFeedBloc>(
            create: (context) => GetIt.I.get<NewsTopicFeedBloc>(
                param1: topic, param2: context.bloc<NewsFilterBloc>()),
          ),
        ],
        child: child,
      );
}
