part of 'myth_bloc.dart';

@immutable
abstract class MythState {}

class InitialMythState extends MythState {}

class LoadingMythState extends MythState {}

class LoadedMythState extends MythState {
  final List<Myth> myths;

  LoadedMythState({
    @required this.myths,
  }) : assert(myths != null);
}

class ErrorMythState extends MythState {
  final String message;

  ErrorMythState({
    @required this.message,
  }) : assert(message != null);
}
