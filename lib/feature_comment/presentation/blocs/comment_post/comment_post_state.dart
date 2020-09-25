part of 'comment_post_bloc.dart';

abstract class CommentPostState extends Equatable {
  const CommentPostState();

  @override
  List<Object> get props => [];
}

class InitialState extends CommentPostState {}

class ProgressState extends CommentPostState {}

class SuccessState extends CommentPostState {
  final String message;

  SuccessState({@required this.message});

  @override
  List<Object> get props => [message];
}

class ErrorState extends CommentPostState {
  final String message;

  ErrorState({@required this.message});

  @override
  List<Object> get props => [message];
}
