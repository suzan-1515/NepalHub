import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get_it/get_it.dart';
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
  static setup() {
    GetIt.I.registerLazySingleton<AuthStorage>(
        () => AuthStorage(GetIt.I.get<SharedPreferences>()));
    GetIt.I.registerLazySingleton<AuthRemoteService>(
      () => AuthRemoteService(
        FirebaseAuth.instance,
        GoogleSignIn(),
        FacebookAuth.instance,
        GetIt.I.get<HttpManager>(),
      ),
    );
    GetIt.I.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSource(
        GetIt.I.get<AuthRemoteService>(),
      ),
    );
    GetIt.I.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSource(
        GetIt.I.get<AuthStorage>(),
      ),
    );
    GetIt.I.registerLazySingleton<AuthRepository>(
      () => AuthRepository(
        GetIt.I.get<AuthRemoteDataSource>(),
        GetIt.I.get<AnalyticsService>(),
        GetIt.I.get<AuthLocalDataSource>(),
      ),
    );
    GetIt.I.registerLazySingleton<GetUserProfileUseCase>(
      () => GetUserProfileUseCase(
        GetIt.I.get<AuthRepository>(),
      ),
    );
    GetIt.I.registerLazySingleton<LoginWithFacebookUseCase>(
      () => LoginWithFacebookUseCase(
        GetIt.I.get<AuthRepository>(),
      ),
    );
    GetIt.I.registerLazySingleton<LoginWithGoogleUseCase>(
      () => LoginWithGoogleUseCase(
        GetIt.I.get<AuthRepository>(),
      ),
    );
    GetIt.I.registerLazySingleton<LoginWithTwitterUseCase>(
      () => LoginWithTwitterUseCase(
        GetIt.I.get<AuthRepository>(),
      ),
    );
    GetIt.I.registerLazySingleton<AutoLoginUseCase>(
      () => AutoLoginUseCase(
        GetIt.I.get<AuthRepository>(),
      ),
    );
    GetIt.I.registerLazySingleton<LogoutUseCase>(
      () => LogoutUseCase(
        GetIt.I.get<AuthRepository>(),
      ),
    );
    GetIt.I.registerFactory<AuthBloc>(
      () => AuthBloc(
        autoLoginUseCase: GetIt.I.get<AutoLoginUseCase>(),
        loginWithFacebookUseCase: GetIt.I.get<LoginWithFacebookUseCase>(),
        loginWithGoogleUseCase: GetIt.I.get<LoginWithGoogleUseCase>(),
        loginWithTwitterUseCase: GetIt.I.get<LoginWithTwitterUseCase>(),
        logoutUseCase: GetIt.I.get<LogoutUseCase>(),
      ),
    );
  }

  static BlocProvider<AuthBloc> authBlocProvider({@required Widget child}) =>
      BlocProvider<AuthBloc>(
        create: (context) => GetIt.I.get<AuthBloc>(),
        child: child,
      );
}
