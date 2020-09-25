part of 'comment_post_bloc.dart';

abstract class CommentPostEvent extends Equatable {
  const CommentPostEvent();

  @override
  List<Object> get props => [];
}

class PostCommentEvent extends CommentPostEvent {
  final String comment;

  PostCommentEvent(this.comment);
  @override
  List<Object> get props => [comment];
}
