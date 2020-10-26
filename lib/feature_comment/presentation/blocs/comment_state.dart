part of 'comment_bloc.dart';

abstract class CommentState extends Equatable {
  const CommentState();

  @override
  List<Object> get props => [];
}

class CommentInitial extends CommentState {}

class CommentLoading extends CommentState {}

class CommentMoreLoading extends CommentState {}

class CommentLoadSuccess extends CommentState {
  final List<CommentUIModel> comments;
  final bool hasMore;

  CommentLoadSuccess(this.comments, {this.hasMore = true});
  CommentLoadSuccess copyWith(
          {List<CommentUIModel> comments, bool hasMore = true}) =>
      CommentLoadSuccess(comments ?? this.comments,
          hasMore: hasMore ?? this.hasMore);
  @override
  List<Object> get props => [comments, hasMore];
}

class CommentLoadEmpty extends CommentState {
  final String message;

  CommentLoadEmpty({this.message});

  @override
  List<Object> get props => [message];
}

class CommentLoadError extends CommentState {
  final String message;

  CommentLoadError({this.message});

  @override
  List<Object> get props => [message];
}

class CommentError extends CommentState {
  final String message;

  CommentError({this.message});

  @override
  List<Object> get props => [message];
}
