import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/network/http_manager/http_manager.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_auth/data/repositories/auth_repository.dart';
import 'package:samachar_hub/feature_stats/data/datasources/remote/remote_data_source.dart';
import 'package:samachar_hub/feature_stats/data/datasources/remote/thread_stats_remote_data_source.dart';
import 'package:samachar_hub/feature_stats/data/repositories/thread_stats_repository.dart';
import 'package:samachar_hub/feature_stats/data/services/remote_service.dart';
import 'package:samachar_hub/feature_stats/data/services/thread_stats_remote_service.dart';
import 'package:samachar_hub/feature_stats/domain/entities/thread_type.dart';
import 'package:samachar_hub/feature_stats/domain/repositories/repository.dart';
import 'package:samachar_hub/feature_stats/domain/usecases/get_thread_stats_use_case.dart';
import 'package:samachar_hub/feature_stats/presentation/blocs/thread_stats_cubit.dart';

class ThreadStatsProvider {
  ThreadStatsProvider._();
  static setup() {
    GetIt.I.registerLazySingleton<RemoteService>(
        () => ThreadStatsRemoteService(GetIt.I.get<HttpManager>()));
    GetIt.I.registerLazySingleton<RemoteDataSource>(
        () => ThreadStatsRemoteDataSource(GetIt.I.get<RemoteService>()));
    GetIt.I.registerLazySingleton<Repository>(
      () => ThreadStatsRepository(
        GetIt.I.get<RemoteDataSource>(),
        GetIt.I.get<AnalyticsService>(),
        GetIt.I.get<AuthRepository>(),
      ),
    );
    GetIt.I.registerLazySingleton<GetThreadStatsUseCase>(
      () => GetThreadStatsUseCase(GetIt.I.get<Repository>()),
    );
    GetIt.I.registerFactoryParam<ThreadStatsCubit, String, ThreadType>(
      (param1, param2) => ThreadStatsCubit(
          getThreadStatsUseCase: GetIt.I.get<GetThreadStatsUseCase>(),
          threadId: param1,
          threadType: param2)
        ..getStats(),
    );
  }

  static BlocProvider<ThreadStatsCubit> threadStatsBlocProvider(
          {@required Widget child,
          @required String threadId,
          @required ThreadType threadType}) =>
      BlocProvider<ThreadStatsCubit>(
        create: (context) =>
            GetIt.I.get<ThreadStatsCubit>(param1: threadId, param2: threadType),
        child: child,
      );
}
