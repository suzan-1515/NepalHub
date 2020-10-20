import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:samachar_hub/feature_forex/presentation/blocs/latest/latest_forex_bloc.dart';
import 'package:samachar_hub/feature_forex/presentation/blocs/timeline/forex_timeline_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForexProvider {
  ForexProvider._();
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
  }) =>
      BlocProvider<ForexBloc>(
        create: (context) => ForexBloc(
          getLatestForexUseCase: context.repository<GetLatestForexUseCase>(),
          getDefaultForexCurrencyUseCase:
              context.repository<GetDefaultForexCurrencyUseCase>(),
        )..add(GetLatestForexEvent()),
        child: child,
      );
  static BlocProvider<ForexTimelineBloc> forexTimelineBlocProvider(
          {@required Widget child, @required String currencyId}) =>
      BlocProvider<ForexTimelineBloc>(
        create: (context) => ForexTimelineBloc(
          currencyId: currencyId,
          getForexTimelineUseCase:
              context.repository<GetForexTimelineUseCase>(),
        )..add(GetForexTimelineEvent()),
        child: child,
      );
  static BlocProvider<ForexCurrencyBloc> forexCurrencyBlocProvider(
          {@required Widget child}) =>
      BlocProvider<ForexCurrencyBloc>(
        create: (context) => ForexCurrencyBloc(
          getForexCurrenciesUseCase:
              context.repository<GetForexCurrenciesUseCase>(),
        )..add(GetForexCurrencies()),
        child: child,
      );
}
