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
        RepositoryProvider(
          create: (context) => HoroscopeRepository(
            HoroscopeRemoteDataSource(
              HoroscopeRemoteService(
                context.repository<HttpManager>(),
              ),
            ),
            HoroscopeLocalDataSource(
              HoroscopeStorage(
                context.repository<SharedPreferences>(),
              ),
            ),
            context.repository<AnalyticsService>(),
            context.repository<AuthRepository>(),
          ),
        ),
      ];
  static List<RepositoryProvider> get horoscope2RepositoryProviders => [
        RepositoryProvider(
          create: (context) => DislikeHoroscopeUseCase(
              context.repository<HoroscopeRepository>()),
        ),
        RepositoryProvider(
          create: (context) => GetDailyHoroscopeUseCase(
              context.repository<HoroscopeRepository>()),
        ),
        RepositoryProvider(
          create: (context) => GetWeeklyHoroscopeUseCase(
              context.repository<HoroscopeRepository>()),
        ),
        RepositoryProvider(
          create: (context) => GetMonthlyHoroscopeUseCase(
              context.repository<HoroscopeRepository>()),
        ),
        RepositoryProvider(
          create: (context) => GetYearlyHoroscopeUseCase(
              context.repository<HoroscopeRepository>()),
        ),
        RepositoryProvider(
          create: (context) => GetDefaultHoroscopeSignUseCase(
              context.repository<HoroscopeRepository>()),
        ),
        RepositoryProvider(
          create: (context) =>
              LikeHoroscopeUseCase(context.repository<HoroscopeRepository>()),
        ),
        RepositoryProvider(
          create: (context) =>
              ShareHoroscopeUseCase(context.repository<HoroscopeRepository>()),
        ),
        RepositoryProvider(
          create: (context) => UndislikeHoroscopeUseCase(
              context.repository<HoroscopeRepository>()),
        ),
        RepositoryProvider(
          create: (context) =>
              UnlikeHoroscopeUseCase(context.repository<HoroscopeRepository>()),
        ),
        RepositoryProvider(
          create: (context) =>
              ViewHoroscopeUseCase(context.repository<HoroscopeRepository>()),
        ),
      ];
  static BlocProvider horoscopeBlocProvider({
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
        ),
        child: child,
      );
}
