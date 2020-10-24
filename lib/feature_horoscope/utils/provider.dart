import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/network/http_manager/http_manager.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_auth/data/repositories/auth_repository.dart';
import 'package:samachar_hub/feature_horoscope/data/datasources/local/horoscope_local_data_source.dart';
import 'package:samachar_hub/feature_horoscope/data/datasources/remote/horoscope_remote_data_source.dart';
import 'package:samachar_hub/feature_horoscope/data/repositories/horoscope_repository.dart';
import 'package:samachar_hub/feature_horoscope/data/services/horoscope_remote_service.dart';
import 'package:samachar_hub/feature_horoscope/data/storage/horoscope_storage.dart';
import 'package:samachar_hub/feature_horoscope/domain/entities/horoscope_type.dart';
import 'package:samachar_hub/feature_horoscope/domain/usecases/usecases.dart';
import 'package:samachar_hub/feature_horoscope/presentation/blocs/dislike/dislike_bloc.dart';
import 'package:samachar_hub/feature_horoscope/presentation/blocs/horoscope/horoscope_bloc.dart';
import 'package:samachar_hub/feature_horoscope/presentation/blocs/like_unlike/like_unlike_bloc.dart';
import 'package:samachar_hub/feature_horoscope/presentation/blocs/share/share_bloc.dart';
import 'package:samachar_hub/feature_horoscope/presentation/blocs/view/view_bloc.dart';
import 'package:samachar_hub/feature_horoscope/presentation/models/horoscope_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HoroscopeProvider {
  HoroscopeProvider._();
  static setup() {
    GetIt.I.registerLazySingleton<HoroscopeStorage>(
        () => HoroscopeStorage(GetIt.I.get<SharedPreferences>()));
    GetIt.I.registerLazySingleton<HoroscopeRemoteService>(
        () => HoroscopeRemoteService(GetIt.I.get<HttpManager>()));
    GetIt.I.registerLazySingleton<HoroscopeRemoteDataSource>(
        () => HoroscopeRemoteDataSource(GetIt.I.get<HoroscopeRemoteService>()));
    GetIt.I.registerLazySingleton<HoroscopeLocalDataSource>(
        () => HoroscopeLocalDataSource(GetIt.I.get<HoroscopeStorage>()));
    GetIt.I.registerLazySingleton<HoroscopeRepository>(() =>
        HoroscopeRepository(
            GetIt.I.get<HoroscopeRemoteDataSource>(),
            GetIt.I.get<HoroscopeLocalDataSource>(),
            GetIt.I.get<AnalyticsService>(),
            GetIt.I.get<AuthRepository>()));

    GetIt.I.registerLazySingleton<DislikeHoroscopeUseCase>(
        () => DislikeHoroscopeUseCase(GetIt.I.get<HoroscopeRepository>()));
    GetIt.I.registerLazySingleton<GetDailyHoroscopeUseCase>(
        () => GetDailyHoroscopeUseCase(GetIt.I.get<HoroscopeRepository>()));
    GetIt.I.registerLazySingleton<GetMonthlyHoroscopeUseCase>(
        () => GetMonthlyHoroscopeUseCase(GetIt.I.get<HoroscopeRepository>()));
    GetIt.I.registerLazySingleton<GetWeeklyHoroscopeUseCase>(
        () => GetWeeklyHoroscopeUseCase(GetIt.I.get<HoroscopeRepository>()));
    GetIt.I.registerLazySingleton<GetYearlyHoroscopeUseCase>(
        () => GetYearlyHoroscopeUseCase(GetIt.I.get<HoroscopeRepository>()));
    GetIt.I.registerLazySingleton<LikeHoroscopeUseCase>(
        () => LikeHoroscopeUseCase(GetIt.I.get<HoroscopeRepository>()));
    GetIt.I.registerLazySingleton<ShareHoroscopeUseCase>(
        () => ShareHoroscopeUseCase(GetIt.I.get<HoroscopeRepository>()));
    GetIt.I.registerLazySingleton<UndislikeHoroscopeUseCase>(
        () => UndislikeHoroscopeUseCase(GetIt.I.get<HoroscopeRepository>()));
    GetIt.I.registerLazySingleton<UnlikeHoroscopeUseCase>(
        () => UnlikeHoroscopeUseCase(GetIt.I.get<HoroscopeRepository>()));
    GetIt.I.registerLazySingleton<ViewHoroscopeUseCase>(
        () => ViewHoroscopeUseCase(GetIt.I.get<HoroscopeRepository>()));

    GetIt.I.registerFactoryParam<HoroscopeBloc, HoroscopeType, void>((param1,
            param2) =>
        HoroscopeBloc(
          getDailyHoroscopeUseCase: GetIt.I.get<GetDailyHoroscopeUseCase>(),
          getMonthlyHoroscopeUseCase: GetIt.I.get<GetMonthlyHoroscopeUseCase>(),
          getWeeklyHoroscopeUseCase: GetIt.I.get<GetWeeklyHoroscopeUseCase>(),
          getYearlyHoroscopeUseCase: GetIt.I.get<GetYearlyHoroscopeUseCase>(),
          type: param1,
        )..add(GetHoroscopeEvent()));
    GetIt.I.registerFactoryParam<LikeUnlikeBloc, HoroscopeUIModel, void>(
        (param1, param2) => LikeUnlikeBloc(
            horoscopeUIModel: param1,
            likeHoroscopeUseCase: GetIt.I.get<LikeHoroscopeUseCase>(),
            unLikeHoroscopeUseCase: GetIt.I.get<UnlikeHoroscopeUseCase>()));
    GetIt.I.registerFactoryParam<DislikeBloc, HoroscopeUIModel, void>(
        (param1, param2) => DislikeBloc(
            horoscopeUIModel: param1,
            dislikeHoroscopeUseCase: GetIt.I.get<DislikeHoroscopeUseCase>(),
            undislikeHoroscopeUseCase:
                GetIt.I.get<UndislikeHoroscopeUseCase>()));
    GetIt.I.registerFactoryParam<ShareBloc, HoroscopeUIModel, void>(
        (param1, param2) => ShareBloc(
            horoscopeUIModel: param1,
            shareHoroscopeUseCase: GetIt.I.get<ShareHoroscopeUseCase>()));
    GetIt.I.registerFactoryParam<ViewBloc, HoroscopeUIModel, void>(
        (param1, param2) => ViewBloc(
            horoscopeUIModel: param1,
            viewHoroscopeUseCase: GetIt.I.get<ViewHoroscopeUseCase>()));
  }

  static List<RepositoryProvider> get horoscopeRepositoryProviders => [
        RepositoryProvider<HoroscopeStorage>(
          create: (context) => HoroscopeStorage(
            context.repository<SharedPreferences>(),
          ),
        ),
        RepositoryProvider<HoroscopeRemoteService>(
          create: (context) => HoroscopeRemoteService(
            context.repository<HttpManager>(),
          ),
        ),
        RepositoryProvider<HoroscopeRemoteDataSource>(
          create: (context) => HoroscopeRemoteDataSource(
            context.repository<HoroscopeRemoteService>(),
          ),
        ),
        RepositoryProvider<HoroscopeLocalDataSource>(
          create: (context) => HoroscopeLocalDataSource(
            context.repository<HoroscopeStorage>(),
          ),
        ),
        RepositoryProvider<HoroscopeRepository>(
          create: (context) => HoroscopeRepository(
            context.repository<HoroscopeRemoteDataSource>(),
            context.repository<HoroscopeLocalDataSource>(),
            context.repository<AnalyticsService>(),
            context.repository<AuthRepository>(),
          ),
        ),
        RepositoryProvider<DislikeHoroscopeUseCase>(
          create: (context) => DislikeHoroscopeUseCase(
              context.repository<HoroscopeRepository>()),
        ),
        RepositoryProvider<GetDailyHoroscopeUseCase>(
          create: (context) => GetDailyHoroscopeUseCase(
              context.repository<HoroscopeRepository>()),
        ),
        RepositoryProvider<GetWeeklyHoroscopeUseCase>(
          create: (context) => GetWeeklyHoroscopeUseCase(
              context.repository<HoroscopeRepository>()),
        ),
        RepositoryProvider<GetMonthlyHoroscopeUseCase>(
          create: (context) => GetMonthlyHoroscopeUseCase(
              context.repository<HoroscopeRepository>()),
        ),
        RepositoryProvider<GetYearlyHoroscopeUseCase>(
          create: (context) => GetYearlyHoroscopeUseCase(
              context.repository<HoroscopeRepository>()),
        ),
        RepositoryProvider<LikeHoroscopeUseCase>(
          create: (context) =>
              LikeHoroscopeUseCase(context.repository<HoroscopeRepository>()),
        ),
        RepositoryProvider<ShareHoroscopeUseCase>(
          create: (context) =>
              ShareHoroscopeUseCase(context.repository<HoroscopeRepository>()),
        ),
        RepositoryProvider<UndislikeHoroscopeUseCase>(
          create: (context) => UndislikeHoroscopeUseCase(
              context.repository<HoroscopeRepository>()),
        ),
        RepositoryProvider<UnlikeHoroscopeUseCase>(
          create: (context) =>
              UnlikeHoroscopeUseCase(context.repository<HoroscopeRepository>()),
        ),
        RepositoryProvider<ViewHoroscopeUseCase>(
          create: (context) =>
              ViewHoroscopeUseCase(context.repository<HoroscopeRepository>()),
        ),
      ];

  static BlocProvider<HoroscopeBloc> horoscopeBlocProvider({
    @required Widget child,
    @required HoroscopeType type,
  }) =>
      BlocProvider<HoroscopeBloc>(
        create: (context) => GetIt.I.get<HoroscopeBloc>(param1: type),
        child: child,
      );
  static MultiBlocProvider horoscopeDetailBlocProvider({
    @required Widget child,
    @required HoroscopeUIModel horoscopeUIModel,
  }) =>
      MultiBlocProvider(
        providers: [
          BlocProvider<LikeUnlikeBloc>(
            create: (context) =>
                GetIt.I.get<LikeUnlikeBloc>(param1: horoscopeUIModel),
          ),
          BlocProvider<DislikeBloc>(
            create: (context) =>
                GetIt.I.get<DislikeBloc>(param1: horoscopeUIModel),
          ),
          BlocProvider<ShareBloc>(
            create: (context) =>
                GetIt.I.get<ShareBloc>(param1: horoscopeUIModel),
          ),
          BlocProvider<ViewBloc>(
            create: (context) =>
                GetIt.I.get<ViewBloc>(param1: horoscopeUIModel),
          ),
        ],
        child: child,
      );
}
