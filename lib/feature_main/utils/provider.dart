import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/network/http_manager/http_manager.dart';
import 'package:samachar_hub/feature_auth/data/repositories/auth_repository.dart';
import 'package:samachar_hub/feature_main/data/datasources/local/settings/local_data_source.dart';
import 'package:samachar_hub/feature_main/data/datasources/remote/home/home_remote_data_source.dart';
import 'package:samachar_hub/feature_main/data/repositories/home_repository.dart';
import 'package:samachar_hub/feature_main/data/services/home/home_remote_service.dart';
import 'package:samachar_hub/feature_main/data/storage/settings/storage.dart';
import 'package:samachar_hub/feature_main/domain/repositories/settings/repository.dart';
import 'package:samachar_hub/feature_main/domain/usecases/home/get_home_feed_use_case.dart';
import 'package:samachar_hub/feature_main/presentation/blocs/home/home_cubit.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_main/data/datasources/local/settings/settings_local_data_source.dart';
import 'package:samachar_hub/feature_main/data/repositories/settings_repository.dart';
import 'package:samachar_hub/feature_main/data/storage/settings/settings_storage.dart';
import 'package:samachar_hub/feature_main/domain/usecases/settings/usecases.dart';
import 'package:samachar_hub/feature_main/presentation/blocs/settings/settings_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeProvider {
  HomeProvider._();
  static setup() {
    GetIt.I.registerLazySingleton<HomeRemoteService>(
        () => HomeRemoteService(GetIt.I.get<HttpManager>()));
    GetIt.I.registerLazySingleton<HomeRemoteDataSource>(
        () => HomeRemoteDataSource(GetIt.I.get<HomeRemoteService>()));
    GetIt.I.registerLazySingleton<HomeRepository>(
      () => HomeRepository(
        GetIt.I.get<HomeRemoteDataSource>(),
        GetIt.I.get<AnalyticsService>(),
        GetIt.I.get<AuthRepository>(),
      ),
    );
    GetIt.I.registerLazySingleton<GetHomeFeedUseCase>(
      () => GetHomeFeedUseCase(GetIt.I.get<HomeRepository>()),
    );
    GetIt.I.registerFactory<HomeCubit>(
      () => HomeCubit(getHomeFeedUseCase: GetIt.I.get<GetHomeFeedUseCase>())
        ..getHomeFeed(),
    );
  }

  static List<RepositoryProvider> get homeRepositoryProviders => [
        RepositoryProvider<HomeRemoteService>(
          create: (context) =>
              HomeRemoteService(context.repository<HttpManager>()),
        ),
        RepositoryProvider<HomeRemoteDataSource>(
          create: (context) =>
              HomeRemoteDataSource(context.repository<HomeRemoteService>()),
        ),
        RepositoryProvider<HomeRepository>(
          create: (context) => HomeRepository(
              context.repository<HomeRemoteDataSource>(),
              context.repository<AnalyticsService>(),
              context.repository<AuthRepository>()),
        ),
        RepositoryProvider<GetHomeFeedUseCase>(
          create: (context) =>
              GetHomeFeedUseCase(context.repository<HomeRepository>()),
        ),
      ];

  static BlocProvider<HomeCubit> homeBlocProvider({@required Widget child}) =>
      BlocProvider<HomeCubit>(
        create: (context) => GetIt.I.get<HomeCubit>(),
        child: child,
      );
}

class SettingsProvider {
  SettingsProvider._();
  static setup() {
    GetIt.I.registerLazySingleton<Storage>(() =>
        SettingsStorage(sharedPreferences: GetIt.I.get<SharedPreferences>()));
    GetIt.I.registerLazySingleton<LocalDataSource>(
        () => SettingsLocalDataSource(GetIt.I.get<Storage>()));
    GetIt.I.registerLazySingleton<Repository>(() => SettingsRepository(
          GetIt.I.get<LocalDataSource>(),
          GetIt.I.get<AnalyticsService>(),
        ));
    GetIt.I.registerLazySingleton<GetSettingsUseCase>(
        () => GetSettingsUseCase(GetIt.I.get<Repository>()));
    GetIt.I.registerLazySingleton<SetCommentNotificationStatusUseCase>(
        () => SetCommentNotificationStatusUseCase(GetIt.I.get<Repository>()));
    GetIt.I.registerLazySingleton<SetDarkModeUseCase>(
        () => SetDarkModeUseCase(GetIt.I.get<Repository>()));
    GetIt.I.registerLazySingleton<SetDefaultForexCurrencyUseCase>(
        () => SetDefaultForexCurrencyUseCase(GetIt.I.get<Repository>()));
    GetIt.I.registerLazySingleton<SetDefaultHoroscopeSignUseCase>(
        () => SetDefaultHoroscopeSignUseCase(GetIt.I.get<Repository>()));
    GetIt.I.registerLazySingleton<SetMessageNotificationStatusUseCase>(
        () => SetMessageNotificationStatusUseCase(GetIt.I.get<Repository>()));
    GetIt.I.registerLazySingleton<SetMorningHoroscopeNotificationStatusUseCase>(
        () => SetMorningHoroscopeNotificationStatusUseCase(
            GetIt.I.get<Repository>()));
    GetIt.I.registerLazySingleton<SetMorningNewsNotificationStatusUseCase>(() =>
        SetMorningNewsNotificationStatusUseCase(GetIt.I.get<Repository>()));
    GetIt.I.registerLazySingleton<SetNewsNotificationStatusUseCase>(
        () => SetNewsNotificationStatusUseCase(GetIt.I.get<Repository>()));
    GetIt.I.registerLazySingleton<SetNewsReadModeUseCase>(
        () => SetNewsReadModeUseCase(GetIt.I.get<Repository>()));
    GetIt.I.registerLazySingleton<SetOtherNotificationStatusUseCase>(
        () => SetOtherNotificationStatusUseCase(GetIt.I.get<Repository>()));
    GetIt.I.registerLazySingleton<SetPitchBlackModeUseCase>(
        () => SetPitchBlackModeUseCase(GetIt.I.get<Repository>()));
    GetIt.I.registerLazySingleton<SetSystemThemeUseCase>(
        () => SetSystemThemeUseCase(GetIt.I.get<Repository>()));
    GetIt.I.registerLazySingleton<SetTrendingNotificationStatusUseCase>(
        () => SetTrendingNotificationStatusUseCase(GetIt.I.get<Repository>()));

    GetIt.I.registerFactory<SettingsCubit>(() => SettingsCubit(
          getSettingsUseCase: GetIt.I.get<GetSettingsUseCase>(),
          setCommentNotificationStatusUseCase:
              GetIt.I.get<SetCommentNotificationStatusUseCase>(),
          setDarkModeUseCase: GetIt.I.get<SetDarkModeUseCase>(),
          setDefaultForexCurrencyUseCase:
              GetIt.I.get<SetDefaultForexCurrencyUseCase>(),
          setDefaultHoroscopeSignUseCase:
              GetIt.I.get<SetDefaultHoroscopeSignUseCase>(),
          setMessageNotificationStatusUseCase:
              GetIt.I.get<SetMessageNotificationStatusUseCase>(),
          setMorningHoroscopeNotificationStatusUseCase:
              GetIt.I.get<SetMorningHoroscopeNotificationStatusUseCase>(),
          setMorningNewsNotificationStatusUseCase:
              GetIt.I.get<SetMorningNewsNotificationStatusUseCase>(),
          setNewsNotificationStatusUseCase:
              GetIt.I.get<SetNewsNotificationStatusUseCase>(),
          setNewsReadModeUseCase: GetIt.I.get<SetNewsReadModeUseCase>(),
          setOtherNotificationStatusUseCase:
              GetIt.I.get<SetOtherNotificationStatusUseCase>(),
          setPitchBlackModeUseCase: GetIt.I.get<SetPitchBlackModeUseCase>(),
          setSystemThemeUseCase: GetIt.I.get<SetSystemThemeUseCase>(),
          setTrendingNotificationStatusUseCase:
              GetIt.I.get<SetTrendingNotificationStatusUseCase>(),
        )..getSettings());
  }

  static List<RepositoryProvider> get settingsRepositoryProviders => [
        RepositoryProvider<SettingsStorage>(
          create: (context) => SettingsStorage(
            sharedPreferences: context.repository<SharedPreferences>(),
          ),
        ),
        RepositoryProvider<SettingsLocalDataSource>(
          create: (context) => SettingsLocalDataSource(
            context.repository<SettingsStorage>(),
          ),
        ),
        RepositoryProvider<SettingsRepository>(
          create: (context) => SettingsRepository(
            context.repository<SettingsLocalDataSource>(),
            context.repository<AnalyticsService>(),
          ),
        ),
        RepositoryProvider<GetSettingsUseCase>(
          create: (context) => GetSettingsUseCase(
            context.repository<SettingsRepository>(),
          ),
        ),
        RepositoryProvider<SetCommentNotificationStatusUseCase>(
          create: (context) => SetCommentNotificationStatusUseCase(
            context.repository<SettingsRepository>(),
          ),
        ),
        RepositoryProvider<SetDarkModeUseCase>(
          create: (context) => SetDarkModeUseCase(
            context.repository<SettingsRepository>(),
          ),
        ),
        RepositoryProvider<SetDefaultForexCurrencyUseCase>(
          create: (context) => SetDefaultForexCurrencyUseCase(
            context.repository<SettingsRepository>(),
          ),
        ),
        RepositoryProvider<SetDefaultHoroscopeSignUseCase>(
          create: (context) => SetDefaultHoroscopeSignUseCase(
            context.repository<SettingsRepository>(),
          ),
        ),
        RepositoryProvider<SetMessageNotificationStatusUseCase>(
          create: (context) => SetMessageNotificationStatusUseCase(
            context.repository<SettingsRepository>(),
          ),
        ),
        RepositoryProvider<SetMorningHoroscopeNotificationStatusUseCase>(
          create: (context) => SetMorningHoroscopeNotificationStatusUseCase(
            context.repository<SettingsRepository>(),
          ),
        ),
        RepositoryProvider<SetMorningNewsNotificationStatusUseCase>(
          create: (context) => SetMorningNewsNotificationStatusUseCase(
            context.repository<SettingsRepository>(),
          ),
        ),
        RepositoryProvider<SetNewsNotificationStatusUseCase>(
          create: (context) => SetNewsNotificationStatusUseCase(
            context.repository<SettingsRepository>(),
          ),
        ),
        RepositoryProvider<SetNewsReadModeUseCase>(
          create: (context) => SetNewsReadModeUseCase(
            context.repository<SettingsRepository>(),
          ),
        ),
        RepositoryProvider<SetOtherNotificationStatusUseCase>(
          create: (context) => SetOtherNotificationStatusUseCase(
            context.repository<SettingsRepository>(),
          ),
        ),
        RepositoryProvider<SetPitchBlackModeUseCase>(
          create: (context) => SetPitchBlackModeUseCase(
            context.repository<SettingsRepository>(),
          ),
        ),
        RepositoryProvider<SetSystemThemeUseCase>(
          create: (context) => SetSystemThemeUseCase(
            context.repository<SettingsRepository>(),
          ),
        ),
        RepositoryProvider<SetTrendingNotificationStatusUseCase>(
          create: (context) => SetTrendingNotificationStatusUseCase(
            context.repository<SettingsRepository>(),
          ),
        ),
      ];

  static BlocProvider<SettingsCubit> settingsBlocProvider(
          {@required Widget child}) =>
      BlocProvider<SettingsCubit>(
        create: (context) => GetIt.I.get<SettingsCubit>(),
        child: child,
      );
}
