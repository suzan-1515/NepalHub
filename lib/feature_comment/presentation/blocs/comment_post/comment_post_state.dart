part of 'comment_post_bloc.dart';

abstract class CommentPostState extends Equatable {
  const CommentPostState();

  @override
  List<Object> get props => [];
}

class CommentPostInitialState extends CommentPostState {}

class CommentPostProgressState extends CommentPostState {}

class CommentPostSuccessState extends CommentPostState {
  final CommentEntity comment;

  CommentPostSuccessState({@required this.comment});

  @override
  List<Object> get props => [comment];
}

class CommentPostErrorState extends CommentPostState {
  final String message;

  CommentPostErrorState({@required this.message});

  @override
  List<Object> get props => [message];
}
