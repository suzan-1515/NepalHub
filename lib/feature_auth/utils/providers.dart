import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:samachar_hub/core/network/http_manager/http_manager.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_auth/data/datasources/local/auth_local_data_source.dart';
import 'package:samachar_hub/feature_auth/data/datasources/remote/auth_remote_data_source_.dart';
import 'package:samachar_hub/feature_auth/data/repositories/auth_repository.dart';
import 'package:samachar_hub/feature_auth/data/services/auth_service.dart';
import 'package:samachar_hub/feature_auth/data/storage/auth_storage.dart';
import 'package:samachar_hub/feature_auth/domain/usecases/usecases.dart';
import 'package:samachar_hub/feature_auth/presentation/blocs/auth_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProviders {
  AuthProviders._();
  static List<RepositoryProvider> get authRepositoryProviders => [
        RepositoryProvider<AuthStorage>(
          create: (context) =>
              AuthStorage(context.repository<SharedPreferences>()),
        ),
        RepositoryProvider<AuthRemoteService>(
          create: (context) => AuthRemoteService(
            FirebaseAuth.instance,
            GoogleSignIn(),
            FacebookAuth.instance,
            context.repository<HttpManager>(),
          ),
        ),
        RepositoryProvider<AuthRemoteDataSource>(
          create: (context) =>
              AuthRemoteDataSource(context.repository<AuthRemoteService>()),
        ),
        RepositoryProvider<AuthLocalDataSource>(
          create: (context) =>
              AuthLocalDataSource(context.repository<AuthStorage>()),
        ),
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(
            context.repository<AuthRemoteDataSource>(),
            context.repository<AnalyticsService>(),
            context.repository<AuthLocalDataSource>(),
          ),
        ),
        RepositoryProvider<GetUserProfileUseCase>(
          create: (context) =>
              GetUserProfileUseCase(context.repository<AuthRepository>()),
        ),
        RepositoryProvider<LoginWithFacebookUseCase>(
          create: (context) =>
              LoginWithFacebookUseCase(context.repository<AuthRepository>()),
        ),
        RepositoryProvider<LoginWithGoogleUseCase>(
          create: (context) =>
              LoginWithGoogleUseCase(context.repository<AuthRepository>()),
        ),
        RepositoryProvider<LoginWithTwitterUseCase>(
          create: (context) =>
              LoginWithTwitterUseCase(context.repository<AuthRepository>()),
        ),
        RepositoryProvider<GetUserProfileUseCase>(
          create: (context) =>
              GetUserProfileUseCase(context.repository<AuthRepository>()),
        ),
        RepositoryProvider<AutoLoginUseCase>(
          create: (context) =>
              AutoLoginUseCase(context.repository<AuthRepository>()),
        ),
        RepositoryProvider<LogoutUseCase>(
          create: (context) =>
              LogoutUseCase(context.repository<AuthRepository>()),
        ),
      ];
  static BlocProvider<AuthBloc> authBlocProvider({@required Widget child}) =>
      BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(
          autoLoginUseCase: context.repository<AutoLoginUseCase>(),
          loginWithFacebookUseCase:
              context.repository<LoginWithFacebookUseCase>(),
          loginWithGoogleUseCase: context.repository<LoginWithGoogleUseCase>(),
          loginWithTwitterUseCase:
              context.repository<LoginWithTwitterUseCase>(),
          logoutUseCase: context.repository<LogoutUseCase>(),
        ),
        child: child,
      );
}
