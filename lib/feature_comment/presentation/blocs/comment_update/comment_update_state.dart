part of 'comment_update_bloc.dart';

abstract class CommentUpdateState extends Equatable {
  const CommentUpdateState();

  @override
  List<Object> get props => [];
}

class CommentUpdateInitialState extends CommentUpdateState {}

class CommentUpdateProgressState extends CommentUpdateState {}

class CommentUpdateSuccessState extends CommentUpdateState {
  final CommentEntity comment;

  CommentUpdateSuccessState({@required this.comment});

  @override
  List<Object> get props => [comment];
}

class CommentUpdateErrorState extends CommentUpdateState {
  final String message;

  CommentUpdateErrorState({@required this.message});

  @override
  List<Object> get props => [message];
}

class CommentEditState extends CommentUpdateState {
  final CommentEntity comment;

  CommentEditState({@required this.comment});

  @override
  List<Object> get props => [comment];
}
