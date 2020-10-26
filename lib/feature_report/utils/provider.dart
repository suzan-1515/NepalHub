import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/network/http_manager/http_manager.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_auth/data/repositories/auth_repository.dart';
import 'package:samachar_hub/feature_report/data/datasources/remote/remote_data_service.dart';
import 'package:samachar_hub/feature_report/data/datasources/remote/report_remote_data_source.dart';
import 'package:samachar_hub/feature_report/data/repositories/report_repository.dart';
import 'package:samachar_hub/feature_report/data/services/remote_service.dart';
import 'package:samachar_hub/feature_report/data/services/report_remote_service.dart';
import 'package:samachar_hub/feature_report/domain/repositories/repository.dart';
import 'package:samachar_hub/feature_report/domain/usecases/post_report_use_case.dart';
import 'package:samachar_hub/feature_report/presentation/blocs/report_cubit.dart';

class ReportProvider {
  ReportProvider._();
  static setup() {
    GetIt.I.registerLazySingleton<RemoteService>(
        () => ReportRemoteService(GetIt.I.get<HttpManager>()));
    GetIt.I.registerLazySingleton<RemoteDataSource>(
        () => ReportRemoteDataSource(GetIt.I.get<RemoteService>()));
    GetIt.I.registerLazySingleton<Repository>(
      () => ReportRepository(
        GetIt.I.get<RemoteDataSource>(),
        GetIt.I.get<AnalyticsService>(),
        GetIt.I.get<AuthRepository>(),
      ),
    );
    GetIt.I.registerLazySingleton<PostReportUseCase>(
      () => PostReportUseCase(GetIt.I.get<Repository>()),
    );
    GetIt.I.registerFactory<ReportCubit>(
      () => ReportCubit(postReportUseCase: GetIt.I.get<PostReportUseCase>()),
    );
  }

  static BlocProvider<ReportCubit> reportBlocProvider(
          {@required Widget child}) =>
      BlocProvider<ReportCubit>(
        create: (context) => GetIt.I.get<ReportCubit>(),
        child: child,
      );
}
