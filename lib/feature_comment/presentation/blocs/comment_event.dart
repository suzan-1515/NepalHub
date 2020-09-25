part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

class GetCommentsEvent extends CommentEvent {}

class RefreshCommentsEvent extends CommentEvent {}

class LoadMoreCommentsEvent extends CommentEvent {
  final int page;
  const LoadMoreCommentsEvent({
    @required this.page,
  });

  @override
  List<Object> get props => [page];
}
