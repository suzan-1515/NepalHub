part of 'like_unlike_bloc.dart';

abstract class CommentLikeUnlikeEvent extends Equatable {
  const CommentLikeUnlikeEvent();

  @override
  List<Object> get props => [];
}

class CommentLikeEvent extends CommentLikeUnlikeEvent {
  final CommentEntity comment;
  const CommentLikeEvent({@required this.comment});
  @override
  List<Object> get props => [comment];
}

class CommentUnlikeEvent extends CommentLikeUnlikeEvent {
  final CommentEntity comment;
  const CommentUnlikeEvent({@required this.comment});
  @override
  List<Object> get props => [comment];
}
