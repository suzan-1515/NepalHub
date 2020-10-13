part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AutoLoginEvent extends AuthEvent {}

class LoginWithGoogleEvent extends AuthEvent {}

class LoginWithFacebookEvent extends AuthEvent {}

class LoginWithTwitterEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}
