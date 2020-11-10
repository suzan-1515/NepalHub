part of 'like_unlike_bloc.dart';

abstract class CommentLikeUnlikeState extends Equatable {
  const CommentLikeUnlikeState();

  @override
  List<Object> get props => [];
}

class CommentLikeInitialState extends CommentLikeUnlikeState {}

class CommentLikeInProgressState extends CommentLikeUnlikeState {}

class CommentLikeSuccessState extends CommentLikeUnlikeState {
  final CommentEntity comment;

  CommentLikeSuccessState({@required this.comment});

  @override
  List<Object> get props => [comment];
}

class CommentUnlikeSuccessState extends CommentLikeUnlikeState {
  final CommentEntity comment;

  CommentUnlikeSuccessState({@required this.comment});

  @override
  List<Object> get props => [comment];
}

class CommentErrorState extends CommentLikeUnlikeState {
  final String message;

  CommentErrorState({this.message});
  @override
  List<Object> get props => [message];
}
