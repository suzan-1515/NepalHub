import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/network/http_manager/http_manager.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_auth/data/repositories/auth_repository.dart';
import 'package:samachar_hub/feature_forex/data/datasources/local/forex_local_data_source.dart';
import 'package:samachar_hub/feature_forex/data/datasources/remote/forex_remote_data_source.dart';
import 'package:samachar_hub/feature_forex/data/repositories/forex_repository.dart';
import 'package:samachar_hub/feature_forex/data/services/forex_remote_service.dart';
import 'package:samachar_hub/feature_forex/data/storage/forex_storage.dart';
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
    GetIt.I.registerLazySingleton<ForexStorage>(
        () => ForexStorage(GetIt.I.get<SharedPreferences>()));
    GetIt.I.registerLazySingleton<ForexRemoteService>(
        () => ForexRemoteService(GetIt.I.get<HttpManager>()));
    GetIt.I.registerLazySingleton<ForexRemoteDataSource>(
        () => ForexRemoteDataSource(GetIt.I.get<ForexRemoteService>()));
    GetIt.I.registerLazySingleton<ForexLocalDataSource>(
        () => ForexLocalDataSource(GetIt.I.get<ForexStorage>()));
    GetIt.I.registerLazySingleton<ForexRepository>(() => ForexRepository(
        GetIt.I.get<ForexRemoteDataSource>(),
        GetIt.I.get<ForexLocalDataSource>(),
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

    GetIt.I.registerFactoryParam<ForexBloc, String, void>(
        (param1, param2) => ForexBloc(
              getLatestForexUseCase: GetIt.I.get<GetLatestForexUseCase>(),
            )..add(GetLatestForexEvent(defaultCurrencyCode: param1)));
    GetIt.I.registerFactoryParam<ForexTimelineBloc, ForexUIModel, void>(
        (param1, param2) => ForexTimelineBloc(
            forexUIModel: param1,
            getForexTimelineUseCase: GetIt.I.get<GetForexTimelineUseCase>())
          ..add(GetForexTimelineEvent()));
    GetIt.I.registerFactory<ForexCurrencyBloc>(() => ForexCurrencyBloc(
        getForexCurrenciesUseCase: GetIt.I.get<GetForexCurrenciesUseCase>())
      ..add(GetForexCurrencies()));
    GetIt.I.registerFactoryParam<LikeUnlikeBloc, ForexUIModel, void>(
        (param1, param2) => LikeUnlikeBloc(
            forexUIModel: param1,
            likeForexUseCase: GetIt.I.get<LikeForexUseCase>(),
            unLikeForexUseCase: GetIt.I.get<UnlikeForexUseCase>()));
    GetIt.I.registerFactoryParam<DislikeBloc, ForexUIModel, void>(
        (param1, param2) => DislikeBloc(
            forexUIModel: param1,
            dislikeForexUseCase: GetIt.I.get<DislikeForexUseCase>(),
            undislikeForexUseCase: GetIt.I.get<UndislikeForexUseCase>()));
    GetIt.I.registerFactoryParam<ShareBloc, ForexUIModel, void>(
        (param1, param2) => ShareBloc(
            forexUIModel: param1,
            shareForexUseCase: GetIt.I.get<ShareForexUseCase>()));
    GetIt.I.registerFactoryParam<ViewBloc, ForexUIModel, void>(
        (param1, param2) => ViewBloc(
            forexUIModel: param1,
            viewForexUseCase: GetIt.I.get<ViewForexUseCase>()));
  }

  static List<RepositoryProvider> get forexRepositoryProviders => [
        RepositoryProvider<ForexStorage>(
          create: (context) => ForexStorage(
            context.repository<SharedPreferences>(),
          ),
        ),
        RepositoryProvider<ForexRemoteService>(
          create: (context) => ForexRemoteService(
            context.repository<HttpManager>(),
          ),
        ),
        RepositoryProvider<ForexRemoteDataSource>(
          create: (context) => ForexRemoteDataSource(
            context.repository<ForexRemoteService>(),
          ),
        ),
        RepositoryProvider<ForexLocalDataSource>(
          create: (context) => ForexLocalDataSource(
            context.repository<ForexStorage>(),
          ),
        ),
        RepositoryProvider<ForexRepository>(
          create: (context) => ForexRepository(
            context.repository<ForexRemoteDataSource>(),
            context.repository<ForexLocalDataSource>(),
            context.repository<AnalyticsService>(),
            context.repository<AuthRepository>(),
          ),
        ),
        RepositoryProvider<DislikeForexUseCase>(
          create: (context) =>
              DislikeForexUseCase(context.repository<ForexRepository>()),
        ),
        RepositoryProvider<GetForexCurrenciesUseCase>(
          create: (context) =>
              GetForexCurrenciesUseCase(context.repository<ForexRepository>()),
        ),
        RepositoryProvider<GetForexTimelineUseCase>(
          create: (context) =>
              GetForexTimelineUseCase(context.repository<ForexRepository>()),
        ),
        RepositoryProvider<GetLatestForexUseCase>(
          create: (context) =>
              GetLatestForexUseCase(context.repository<ForexRepository>()),
        ),
        RepositoryProvider<LikeForexUseCase>(
          create: (context) =>
              LikeForexUseCase(context.repository<ForexRepository>()),
        ),
        RepositoryProvider<ShareForexUseCase>(
          create: (context) =>
              ShareForexUseCase(context.repository<ForexRepository>()),
        ),
        RepositoryProvider<UndislikeForexUseCase>(
          create: (context) =>
              UndislikeForexUseCase(context.repository<ForexRepository>()),
        ),
        RepositoryProvider<UnlikeForexUseCase>(
          create: (context) =>
              UnlikeForexUseCase(context.repository<ForexRepository>()),
        ),
        RepositoryProvider<ViewForexUseCase>(
          create: (context) =>
              ViewForexUseCase(context.repository<ForexRepository>()),
        ),
      ];
  static BlocProvider<ForexBloc> forexBlocProvider({
    @required Widget child,
    @required String defaultCurrencyCode,
  }) =>
      BlocProvider<ForexBloc>(
        create: (context) =>
            GetIt.I.get<ForexBloc>(param1: defaultCurrencyCode),
        child: child,
      );
  static BlocProvider<ForexTimelineBloc> forexTimelineBlocProvider(
          {@required Widget child, @required ForexUIModel forexUIModel}) =>
      BlocProvider<ForexTimelineBloc>(
        create: (context) =>
            GetIt.I.get<ForexTimelineBloc>(param1: forexUIModel),
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
    @required ForexUIModel forexUIModel,
  }) =>
      MultiBlocProvider(
        providers: [
          BlocProvider<ForexTimelineBloc>(
            create: (context) =>
                GetIt.I.get<ForexTimelineBloc>(param1: forexUIModel),
          ),
          BlocProvider<LikeUnlikeBloc>(
            create: (context) =>
                GetIt.I.get<LikeUnlikeBloc>(param1: forexUIModel),
          ),
          BlocProvider<DislikeBloc>(
            create: (context) => GetIt.I.get<DislikeBloc>(param1: forexUIModel),
          ),
          BlocProvider<ShareBloc>(
            create: (context) => GetIt.I.get<ShareBloc>(param1: forexUIModel),
          ),
          BlocProvider<ViewBloc>(
            create: (context) => GetIt.I.get<ViewBloc>(param1: forexUIModel),
          ),
        ],
        child: child,
      );
}
