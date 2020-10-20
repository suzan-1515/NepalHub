import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/network/http_manager/http_manager.dart';
import 'package:samachar_hub/feature_auth/data/repositories/auth_repository.dart';
import 'package:samachar_hub/feature_main/data/datasources/remote/home/home_remote_data_source.dart';
import 'package:samachar_hub/feature_main/data/repositories/home_repository.dart';
import 'package:samachar_hub/feature_main/data/services/home/home_remote_service.dart';
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
        create: (context) => HomeCubit(
          getHomeFeedUseCase: context.repository<GetHomeFeedUseCase>(),
        )..getHomeFeed(),
        child: child,
      );
}

class SettingsProvider {
  SettingsProvider._();
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
        create: (context) => SettingsCubit(
          getSettingsUseCase: context.repository<GetSettingsUseCase>(),
          setCommentNotificationStatusUseCase:
              context.repository<SetCommentNotificationStatusUseCase>(),
          setDarkModeUseCase: context.repository<SetDarkModeUseCase>(),
          setDefaultForexCurrencyUseCase:
              context.repository<SetDefaultForexCurrencyUseCase>(),
          setDefaultHoroscopeSignUseCase:
              context.repository<SetDefaultHoroscopeSignUseCase>(),
          setMessageNotificationStatusUseCase:
              context.repository<SetMessageNotificationStatusUseCase>(),
          setMorningHoroscopeNotificationStatusUseCase: context
              .repository<SetMorningHoroscopeNotificationStatusUseCase>(),
          setMorningNewsNotificationStatusUseCase:
              context.repository<SetMorningNewsNotificationStatusUseCase>(),
          setNewsNotificationStatusUseCase:
              context.repository<SetNewsNotificationStatusUseCase>(),
          setNewsReadModeUseCase: context.repository<SetNewsReadModeUseCase>(),
          setOtherNotificationStatusUseCase:
              context.repository<SetOtherNotificationStatusUseCase>(),
          setPitchBlackModeUseCase:
              context.repository<SetPitchBlackModeUseCase>(),
          setSystemThemeUseCase: context.repository<SetSystemThemeUseCase>(),
          setTrendingNotificationStatusUseCase:
              context.repository<SetTrendingNotificationStatusUseCase>(),
        )..getSettings(),
        child: child,
      );
}
