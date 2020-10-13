import 'dart:async';
import 'dart:developer';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_auth/domain/entities/user_entity.dart';
import 'package:samachar_hub/feature_auth/domain/usecases/logout_use_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  UseCase _loginWithGoogleUseCase;
  UseCase _loginWithFacebookUseCase;
  UseCase _loginWithTwitterUseCase;
  UseCase _logoutUseCase;
  AuthBloc({
    @required UseCase loginWithGoogleUseCase,
    @required UseCase loginWithFacebookUseCase,
    @required UseCase loginWithTwitterUseCase,
    @required UseCase logoutUseCase,
  })  : _loginWithGoogleUseCase = loginWithGoogleUseCase,
        _loginWithFacebookUseCase = loginWithFacebookUseCase,
        _loginWithTwitterUseCase = loginWithTwitterUseCase,
        _logoutUseCase = logoutUseCase,
        super(AuthInitialState());

  UserEntity _currentUser;
  UserEntity get currentUser => _currentUser;
  bool get isLoggedIn => currentUser != null;

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is LoginWithGoogleEvent) {
      yield* _mapLoginWithGoogleEventToState(event);
    } else if (event is LoginWithFacebookEvent) {
      yield* _mapLoginWithFacebookEventToState(event);
    } else if (event is LoginWithTwitterEvent) {
      yield* _mapLoginWithTwitterEventToState(event);
    } else if (event is LogoutEvent) {
      yield* _mapLogoutEventToState(event);
    }
  }

  Stream<AuthState> _mapLoginWithGoogleEventToState(
    LoginWithGoogleEvent event,
  ) async* {
    if (state is AuthLoadingState) return;
    yield AuthLoadingState();
    try {
      this._currentUser = await _loginWithGoogleUseCase.call(NoParams());
      if (this._currentUser == null)
        yield AuthErrorState(message: 'Unable to login.');
      yield AuthSuccessState(this._currentUser);
    } catch (e) {
      log('Error login with google: ', error: e);
      yield AuthErrorState(message: 'Unable to login.');
    }
  }

  Stream<AuthState> _mapLoginWithFacebookEventToState(
    LoginWithFacebookEvent event,
  ) async* {
    if (state is AuthLoadingState) return;
    yield AuthLoadingState();
    try {
      this._currentUser = await _loginWithFacebookUseCase.call(NoParams());
      if (this._currentUser == null)
        yield AuthErrorState(message: 'Unable to login.');
      yield AuthSuccessState(this._currentUser);
    } catch (e) {
      log('Error login with facebook: ', error: e);
      yield AuthErrorState(message: 'Unable to login.');
    }
  }

  Stream<AuthState> _mapLoginWithTwitterEventToState(
    LoginWithTwitterEvent event,
  ) async* {
    if (state is AuthLoadingState) return;
    yield AuthLoadingState();
    try {
      this._currentUser = await _loginWithTwitterUseCase.call(NoParams());
      if (this._currentUser == null)
        yield AuthErrorState(message: 'Unable to login.');
      yield AuthSuccessState(this._currentUser);
    } catch (e) {
      log('Error login with twitter: ', error: e);
      yield AuthErrorState(message: 'Unable to login.');
    }
  }

  Stream<AuthState> _mapLogoutEventToState(
    LogoutEvent event,
  ) async* {
    try {
      await _logoutUseCase.call(LogoutUseCaseParams(userEntity: currentUser));
      yield AuthSuccessState(currentUser);
    } catch (e) {
      log('Error logout : ', error: e);
      yield AuthErrorState(message: 'Unable to logout.');
    }
  }
}
