import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/network/http_manager/http_manager.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_auth/data/repositories/auth_repository.dart';
import 'package:samachar_hub/feature_gold/data/datasources/remote/gold_silver_remote_data_source.dart';
import 'package:samachar_hub/feature_gold/data/datasources/remote/remote_data_source.dart';
import 'package:samachar_hub/feature_gold/data/repositories/gold_silver_repository.dart';
import 'package:samachar_hub/feature_gold/data/services/gold_silver_remote_service.dart';
import 'package:samachar_hub/feature_gold/data/services/remote_service.dart';
import 'package:samachar_hub/feature_gold/domain/entities/gold_silver_entity.dart';
import 'package:samachar_hub/feature_gold/domain/repositories/repository.dart';
import 'package:samachar_hub/feature_gold/domain/usecases/usecases.dart';
import 'package:samachar_hub/feature_gold/presentation/blocs/categories/gold_silver_category_bloc.dart';
import 'package:samachar_hub/feature_gold/presentation/blocs/dislike/dislike_bloc.dart';
import 'package:samachar_hub/feature_gold/presentation/blocs/latest/latest_gold_silver_bloc.dart';
import 'package:samachar_hub/feature_gold/presentation/blocs/like_unlike/like_unlike_bloc.dart';
import 'package:samachar_hub/feature_gold/presentation/blocs/share/share_bloc.dart';
import 'package:samachar_hub/feature_gold/presentation/blocs/timeline/gold_silver_timeline_bloc.dart';
import 'package:samachar_hub/feature_gold/presentation/blocs/view/view_bloc.dart';
import 'package:samachar_hub/feature_gold/presentation/models/gold_silver_model.dart';

class GoldSilverProvider {
  GoldSilverProvider._();
  static setup() {
    GetIt.I.registerLazySingleton<RemoteService>(
        () => GoldSilverRemoteService(GetIt.I.get<HttpManager>()));
    GetIt.I.registerLazySingleton<RemoteDataSource>(
        () => GoldSilverRemoteDataSource(GetIt.I.get<RemoteService>()));
    GetIt.I.registerLazySingleton<Repository>(() => GoldSilverRepository(
        GetIt.I.get<RemoteDataSource>(),
        GetIt.I.get<AnalyticsService>(),
        GetIt.I.get<AuthRepository>()));

    GetIt.I.registerLazySingleton<DislikeGoldSilverUseCase>(
        () => DislikeGoldSilverUseCase(GetIt.I.get<Repository>()));
    GetIt.I.registerLazySingleton<GetGoldSilverCategoriesUseCase>(
        () => GetGoldSilverCategoriesUseCase(GetIt.I.get<Repository>()));
    GetIt.I.registerLazySingleton<GetGoldSilverTimelineUseCase>(
        () => GetGoldSilverTimelineUseCase(GetIt.I.get<Repository>()));
    GetIt.I.registerLazySingleton<GetLatestGoldSilverUseCase>(
        () => GetLatestGoldSilverUseCase(GetIt.I.get<Repository>()));
    GetIt.I.registerLazySingleton<LikeGoldSilverUseCase>(
        () => LikeGoldSilverUseCase(GetIt.I.get<Repository>()));
    GetIt.I.registerLazySingleton<ShareGoldSilverUseCase>(
        () => ShareGoldSilverUseCase(GetIt.I.get<Repository>()));
    GetIt.I.registerLazySingleton<UndislikeGoldSilverUseCase>(
        () => UndislikeGoldSilverUseCase(GetIt.I.get<Repository>()));
    GetIt.I.registerLazySingleton<UnlikeGoldSilverUseCase>(
        () => UnlikeGoldSilverUseCase(GetIt.I.get<Repository>()));
    GetIt.I.registerLazySingleton<ViewGoldSilverUseCase>(
        () => ViewGoldSilverUseCase(GetIt.I.get<Repository>()));

    GetIt.I.registerFactory<GoldSilverBloc>(() => GoldSilverBloc(
        getLatestGoldSilverUseCase: GetIt.I.get<GetLatestGoldSilverUseCase>()));
    GetIt.I
        .registerFactoryParam<GoldSilverTimelineBloc, GoldSilverEntity, void>(
      (param1, param2) => GoldSilverTimelineBloc(
          getGoldSilverTimelineUseCase:
              GetIt.I.get<GetGoldSilverTimelineUseCase>())
        ..add(GetGoldSilverTimelineEvent(goldSilver: param1)),
    );
    GetIt.I.registerFactory<GoldCategoryBloc>(() => GoldCategoryBloc(
        getGoldCategoriesUseCase:
            GetIt.I.get<GetGoldSilverCategoriesUseCase>()));
    GetIt.I.registerFactory<LikeUnlikeBloc>(() => LikeUnlikeBloc(
        likeGoldSilverUseCase: GetIt.I.get<LikeGoldSilverUseCase>(),
        unLikeGoldSilverUseCase: GetIt.I.get<UnlikeGoldSilverUseCase>()));
    GetIt.I.registerFactory<DislikeBloc>(() => DislikeBloc(
        dislikeGoldSilverUseCase: GetIt.I.get<DislikeGoldSilverUseCase>(),
        undislikeGoldSilverUseCase: GetIt.I.get<UndislikeGoldSilverUseCase>()));
    GetIt.I.registerFactory<ShareBloc>(() => ShareBloc(
        shareGoldSilverUseCase: GetIt.I.get<ShareGoldSilverUseCase>()));
    GetIt.I.registerFactoryParam<ViewBloc, GoldSilverEntity, void>((param1,
            param2) =>
        ViewBloc(viewGoldSilverUseCase: GetIt.I.get<ViewGoldSilverUseCase>())
          ..add(View(goldSilver: param1)));
  }

  static BlocProvider<GoldSilverBloc> goldSilverBlocProvider({
    @required Widget child,
  }) =>
      BlocProvider<GoldSilverBloc>(
        create: (context) => GetIt.I.get<GoldSilverBloc>(),
        child: child,
      );

  static BlocProvider<GoldSilverTimelineBloc> goldSilverTimelineBlocProvider(
          {@required Widget child, @required GoldSilverUIModel goldSilver}) =>
      BlocProvider<GoldSilverTimelineBloc>(
        create: (context) =>
            GetIt.I.get<GoldSilverTimelineBloc>(param1: goldSilver.entity),
        child: child,
      );

  static BlocProvider<GoldCategoryBloc> goldSilverCategoryBlocProvider(
          {@required Widget child}) =>
      BlocProvider<GoldCategoryBloc>(
        create: (context) => GetIt.I.get<GoldCategoryBloc>(),
        child: child,
      );

  static MultiBlocProvider goldSilverDetailBlocProvider({
    @required Widget child,
    @required GoldSilverEntity goldSilver,
  }) =>
      MultiBlocProvider(
        providers: [
          BlocProvider<GoldSilverTimelineBloc>(
            create: (context) =>
                GetIt.I.get<GoldSilverTimelineBloc>(param1: goldSilver),
          ),
          BlocProvider<LikeUnlikeBloc>(
            create: (context) => GetIt.I.get<LikeUnlikeBloc>(),
          ),
          BlocProvider<DislikeBloc>(
            create: (context) => GetIt.I.get<DislikeBloc>(),
          ),
          BlocProvider<ShareBloc>(
            create: (context) => GetIt.I.get<ShareBloc>(),
          ),
          BlocProvider<ViewBloc>(
            create: (context) => GetIt.I.get<ViewBloc>(param1: goldSilver),
          ),
        ],
        child: child,
      );
}
