part of 'comment_update_bloc.dart';

abstract class CommentUpdateEvent extends Equatable {
  const CommentUpdateEvent();

  @override
  List<Object> get props => [];
}

class UpdateCommentEvent extends CommentUpdateEvent {
  final CommentEntity comment;

  UpdateCommentEvent(this.comment);
  @override
  List<Object> get props => [comment];
}

class EditCommentEvent extends CommentUpdateEvent {
  final CommentEntity comment;

  EditCommentEvent(this.comment);
  @override
  List<Object> get props => [comment];
}
