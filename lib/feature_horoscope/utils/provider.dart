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
import 'package:samachar_hub/feature_horoscope/domain/entities/horoscope_entity.dart';
import 'package:samachar_hub/feature_horoscope/domain/entities/horoscope_type.dart';
import 'package:samachar_hub/feature_horoscope/domain/usecases/usecases.dart';
import 'package:samachar_hub/feature_horoscope/presentation/blocs/dislike/dislike_bloc.dart';
import 'package:samachar_hub/feature_horoscope/presentation/blocs/horoscope/horoscope_bloc.dart';
import 'package:samachar_hub/feature_horoscope/presentation/blocs/like_unlike/like_unlike_bloc.dart';
import 'package:samachar_hub/feature_horoscope/presentation/blocs/share/share_bloc.dart';
import 'package:samachar_hub/feature_horoscope/presentation/blocs/view/view_bloc.dart';
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
    GetIt.I.registerFactory<LikeUnlikeBloc>(() => LikeUnlikeBloc(
        likeHoroscopeUseCase: GetIt.I.get<LikeHoroscopeUseCase>(),
        unLikeHoroscopeUseCase: GetIt.I.get<UnlikeHoroscopeUseCase>()));
    GetIt.I.registerFactory<DislikeBloc>(() => DislikeBloc(
        dislikeHoroscopeUseCase: GetIt.I.get<DislikeHoroscopeUseCase>(),
        undislikeHoroscopeUseCase: GetIt.I.get<UndislikeHoroscopeUseCase>()));
    GetIt.I.registerFactory<ShareBloc>(() =>
        ShareBloc(shareHoroscopeUseCase: GetIt.I.get<ShareHoroscopeUseCase>()));
    GetIt.I.registerFactoryParam<ViewBloc, HoroscopeEntity, void>(
        (param1, param2) =>
            ViewBloc(viewHoroscopeUseCase: GetIt.I.get<ViewHoroscopeUseCase>())
              ..add(View(horoscope: param1)));
  }

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
    @required HoroscopeEntity horoscope,
  }) =>
      MultiBlocProvider(
        providers: [
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
            create: (context) => GetIt.I.get<ViewBloc>(param1: horoscope),
          ),
        ],
        child: child,
      );
}
