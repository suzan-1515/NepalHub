import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/network/http_manager/http_manager.dart';
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
        RepositoryProvider(
          create: (context) =>
              HomeRemoteService(context.repository<HttpManager>()),
        ),
        RepositoryProvider(
          create: (context) =>
              HomeRemoteDataSource(context.repository<HomeRemoteService>()),
        ),
        RepositoryProvider(
          create: (context) =>
              HomeRepository(context.repository<HomeRemoteDataSource>()),
        ),
        RepositoryProvider(
          create: (context) =>
              GetHomeFeedUseCase(context.repository<HomeRepository>()),
        ),
      ];

  static BlocProvider homeBlocProvider({@required Widget child}) =>
      BlocProvider(
        create: (context) => HomeCubit(
          getHomeFeedUseCase: context.repository<GetHomeFeedUseCase>(),
        ),
        child: child,
      );
}

class SettingsProvider {
  SettingsProvider._();
  static List<RepositoryProvider> get settingsRepositoryProviders => [
        RepositoryProvider(
          create: (context) => SettingsStorage(
            sharedPreferences: context.repository<SharedPreferences>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => SettingsLocalDataSource(
            context.repository<SettingsStorage>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => SettingsRepository(
            context.repository<SettingsLocalDataSource>(),
            context.repository<AnalyticsService>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => GetSettingsUseCase(
            context.repository<SettingsRepository>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => SetCommentNotificationStatusUseCase(
            context.repository<SettingsRepository>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => SetDarkModeUseCase(
            context.repository<SettingsRepository>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => SetDefaultForexCurrencyUseCase(
            context.repository<SettingsRepository>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => SetDefaultHoroscopeSignUseCase(
            context.repository<SettingsRepository>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => SetMessageNotificationStatusUseCase(
            context.repository<SettingsRepository>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => SetMorningHoroscopeNotificationStatusUseCase(
            context.repository<SettingsRepository>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => SetMorningNewsNotificationStatusUseCase(
            context.repository<SettingsRepository>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => SetNewsNotificationStatusUseCase(
            context.repository<SettingsRepository>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => SetNewsReadModeUseCase(
            context.repository<SettingsRepository>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => SetOtherNotificationStatusUseCase(
            context.repository<SettingsRepository>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => SetPitchBlackModeUseCase(
            context.repository<SettingsRepository>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => SetSystemThemeUseCase(
            context.repository<SettingsRepository>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => SetTrendingNotificationStatusUseCase(
            context.repository<SettingsRepository>(),
          ),
        ),
      ];

  static BlocProvider settingsBlocProvider({@required Widget child}) =>
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
        ),
        child: child,
      );
}
