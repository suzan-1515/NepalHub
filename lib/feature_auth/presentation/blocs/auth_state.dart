part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthSuccessState extends AuthState {
  final UserEntity user;

  AuthSuccessState(this.user);
  @override
  List<Object> get props => [user];
}

class AuthErrorState extends AuthState {
  final String message;

  AuthErrorState({this.message});
  @override
  List<Object> get props => [message];
}

class AuthUnauthorisedState extends AuthState {
  final String message;

  AuthUnauthorisedState({this.message});
  @override
  List<Object> get props => [message];
}

class AuthLogoutState extends AuthState {
  final String message;

  AuthLogoutState({this.message});
  @override
  List<Object> get props => [message];
}
