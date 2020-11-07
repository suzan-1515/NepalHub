import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/network/http_manager/http_manager.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_auth/data/repositories/auth_repository.dart';
import 'package:samachar_hub/feature_forex/data/datasources/local/forex_local_data_source.dart';
import 'package:samachar_hub/feature_forex/data/datasources/local/local_data_source.dart';
import 'package:samachar_hub/feature_forex/data/datasources/remote/forex_remote_data_source.dart';
import 'package:samachar_hub/feature_forex/data/datasources/remote/remote_data_source.dart';
import 'package:samachar_hub/feature_forex/data/repositories/forex_repository.dart';
import 'package:samachar_hub/feature_forex/data/services/forex_remote_service.dart';
import 'package:samachar_hub/feature_forex/data/services/remote_service.dart';
import 'package:samachar_hub/feature_forex/data/storage/forex_storage.dart';
import 'package:samachar_hub/feature_forex/data/storage/storage.dart';
import 'package:samachar_hub/feature_forex/domain/entities/forex_entity.dart';
import 'package:samachar_hub/feature_forex/domain/usecases/share_forex_use_case.dart';
import 'package:samachar_hub/feature_forex/domain/usecases/usecases.dart';
import 'package:samachar_hub/feature_forex/presentation/blocs/currency/forex_currency_bloc.dart';
import 'package:samachar_hub/feature_forex/presentation/blocs/dislike/dislike_bloc.dart';
import 'package:samachar_hub/feature_forex/presentation/blocs/latest/latest_forex_bloc.dart';
import 'package:samachar_hub/feature_forex/presentation/blocs/like_unlike/like_unlike_bloc.dart';
import 'package:samachar_hub/feature_forex/presentation/blocs/share/share_bloc.dart';
import 'package:samachar_hub/feature_forex/presentation/blocs/timeline/forex_timeline_bloc.dart';
import 'package:samachar_hub/feature_forex/presentation/blocs/view/view_bloc.dart';
import 'package:samachar_hub/feature_forex/presentation/models/forex_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForexProvider {
  ForexProvider._();
  static setup() {
    GetIt.I.registerLazySingleton<Storage>(
        () => ForexStorage(GetIt.I.get<SharedPreferences>()));
    GetIt.I.registerLazySingleton<RemoteService>(
        () => ForexRemoteService(GetIt.I.get<HttpManager>()));
    GetIt.I.registerLazySingleton<RemoteDataSource>(
        () => ForexRemoteDataSource(GetIt.I.get<RemoteService>()));
    GetIt.I.registerLazySingleton<LocalDataSource>(
        () => ForexLocalDataSource(GetIt.I.get<Storage>()));
    GetIt.I.registerLazySingleton<ForexRepository>(() => ForexRepository(
        GetIt.I.get<RemoteDataSource>(),
        GetIt.I.get<LocalDataSource>(),
        GetIt.I.get<AnalyticsService>(),
        GetIt.I.get<AuthRepository>()));

    GetIt.I.registerLazySingleton<DislikeForexUseCase>(
        () => DislikeForexUseCase(GetIt.I.get<ForexRepository>()));
    GetIt.I.registerLazySingleton<GetForexCurrenciesUseCase>(
        () => GetForexCurrenciesUseCase(GetIt.I.get<ForexRepository>()));
    GetIt.I.registerLazySingleton<GetForexTimelineUseCase>(
        () => GetForexTimelineUseCase(GetIt.I.get<ForexRepository>()));
    GetIt.I.registerLazySingleton<GetLatestForexUseCase>(
        () => GetLatestForexUseCase(GetIt.I.get<ForexRepository>()));
    GetIt.I.registerLazySingleton<LikeForexUseCase>(
        () => LikeForexUseCase(GetIt.I.get<ForexRepository>()));
    GetIt.I.registerLazySingleton<ShareForexUseCase>(
        () => ShareForexUseCase(GetIt.I.get<ForexRepository>()));
    GetIt.I.registerLazySingleton<UndislikeForexUseCase>(
        () => UndislikeForexUseCase(GetIt.I.get<ForexRepository>()));
    GetIt.I.registerLazySingleton<UnlikeForexUseCase>(
        () => UnlikeForexUseCase(GetIt.I.get<ForexRepository>()));
    GetIt.I.registerLazySingleton<ViewForexUseCase>(
        () => ViewForexUseCase(GetIt.I.get<ForexRepository>()));

    GetIt.I.registerFactory<ForexBloc>(() => ForexBloc(
          getLatestForexUseCase: GetIt.I.get<GetLatestForexUseCase>(),
        ));
    GetIt.I.registerFactoryParam<ForexTimelineBloc, ForexEntity, void>(
        (param1, param2) => ForexTimelineBloc(
            getForexTimelineUseCase: GetIt.I.get<GetForexTimelineUseCase>())
          ..add(GetForexTimelineEvent(forex: param1)));
    GetIt.I.registerFactory<ForexCurrencyBloc>(() => ForexCurrencyBloc(
        getForexCurrenciesUseCase: GetIt.I.get<GetForexCurrenciesUseCase>())
      ..add(GetForexCurrencies()));
    GetIt.I.registerFactory<LikeUnlikeBloc>(() => LikeUnlikeBloc(
        likeForexUseCase: GetIt.I.get<LikeForexUseCase>(),
        unLikeForexUseCase: GetIt.I.get<UnlikeForexUseCase>()));
    GetIt.I.registerFactory<DislikeBloc>(() => DislikeBloc(
        dislikeForexUseCase: GetIt.I.get<DislikeForexUseCase>(),
        undislikeForexUseCase: GetIt.I.get<UndislikeForexUseCase>()));
    GetIt.I.registerFactory<ShareBloc>(
        () => ShareBloc(shareForexUseCase: GetIt.I.get<ShareForexUseCase>()));
    GetIt.I.registerFactoryParam<ViewBloc, ForexEntity, void>(
        (param1, param2) =>
            ViewBloc(viewForexUseCase: GetIt.I.get<ViewForexUseCase>())
              ..add(View(forex: param1)));
  }

  static BlocProvider<ForexBloc> forexBlocProvider({
    @required Widget child,
  }) =>
      BlocProvider<ForexBloc>(
        create: (context) => GetIt.I.get<ForexBloc>(),
        child: child,
      );

  static BlocProvider<ForexTimelineBloc> forexTimelineBlocProvider(
          {@required Widget child, @required ForexUIModel forexUIModel}) =>
      BlocProvider<ForexTimelineBloc>(
        create: (context) =>
            GetIt.I.get<ForexTimelineBloc>(param1: forexUIModel.entity),
        child: child,
      );

  static BlocProvider<ForexCurrencyBloc> forexCurrencyBlocProvider(
          {@required Widget child}) =>
      BlocProvider<ForexCurrencyBloc>(
        create: (context) => GetIt.I.get<ForexCurrencyBloc>(),
        child: child,
      );

  static MultiBlocProvider forexDetailBlocProvider({
    @required Widget child,
    @required ForexEntity forex,
  }) =>
      MultiBlocProvider(
        providers: [
          BlocProvider<ForexTimelineBloc>(
            create: (context) => GetIt.I.get<ForexTimelineBloc>(param1: forex),
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
            create: (context) => GetIt.I.get<ViewBloc>(param1: forex),
          ),
        ],
        child: child,
      );
}
