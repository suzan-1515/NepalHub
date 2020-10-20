import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:samachar_hub/feature_horoscope/presentation/blocs/horoscope/horoscope_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HoroscopeProvider {
  HoroscopeProvider._();
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
        RepositoryProvider<GetDefaultHoroscopeSignUseCase>(
          create: (context) => GetDefaultHoroscopeSignUseCase(
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
        create: (context) => HoroscopeBloc(
          getDailyHoroscopeUseCase:
              context.repository<GetDailyHoroscopeUseCase>(),
          getDefaultHoroscopeSignIndex:
              context.repository<GetDefaultHoroscopeSignUseCase>(),
          getMonthlyHoroscopeUseCase:
              context.repository<GetMonthlyHoroscopeUseCase>(),
          getWeeklyHoroscopeUseCase:
              context.repository<GetWeeklyHoroscopeUseCase>(),
          getYearlyHoroscopeUseCase:
              context.repository<GetYearlyHoroscopeUseCase>(),
          type: type,
        )..add(GetHoroscopeEvent()),
        child: child,
      );
}
