part of 'delete_cubit.dart';

abstract class CommentDeleteState extends Equatable {
  const CommentDeleteState();

  @override
  List<Object> get props => [];
}

class CommentDeleteInitialState extends CommentDeleteState {}

class CommentDeleteInProgressState extends CommentDeleteState {}

class CommentDeleteSuccessState extends CommentDeleteState {
  final CommentEntity comment;

  CommentDeleteSuccessState({@required this.comment});
  @override
  List<Object> get props => [comment];
}

class CommentDeleteErrorState extends CommentDeleteState {
  final String message;

  CommentDeleteErrorState({this.message});
  @override
  List<Object> get props => [message];
}
