part of 'like_unlike_bloc.dart';

abstract class LikeUnlikeState extends Equatable {
  const LikeUnlikeState();
}

class NewsLikeInitialState extends LikeUnlikeState {
  @override
  List<Object> get props => [];
}

class NewsLikeInProgressState extends LikeUnlikeState {
  @override
  List<Object> get props => [];
}

class NewsLikeSuccessState extends LikeUnlikeState {
  final NewsFeedEntity feed;

  NewsLikeSuccessState({@required this.feed});

  @override
  List<Object> get props => [feed];
}

class NewsUnLikeSuccessState extends LikeUnlikeState {
  final NewsFeedEntity feed;

  NewsUnLikeSuccessState({@required this.feed});

  @override
  List<Object> get props => [feed];
}

class NewsLikeErrorState extends LikeUnlikeState {
  final String message;

  NewsLikeErrorState({this.message});

  @override
  List<Object> get props => [message];
}
