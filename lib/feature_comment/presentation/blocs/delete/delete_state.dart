part of 'delete_cubit.dart';

abstract class CommentDeleteState extends Equatable {
  const CommentDeleteState();

  @override
  List<Object> get props => [];
}

class InitialState extends CommentDeleteState {}

class InProgressState extends CommentDeleteState {}

class SuccessState extends CommentDeleteState {
  final String message;

  SuccessState({this.message});
  @override
  List<Object> get props => [message];
}

class ErrorState extends CommentDeleteState {
  final String message;

  ErrorState({this.message});
  @override
  List<Object> get props => [message];
}
