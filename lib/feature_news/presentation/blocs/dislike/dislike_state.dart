part of 'dislike_bloc.dart';

abstract class DislikeState extends Equatable {
  const DislikeState();
}

class DislikeInitial extends DislikeState {
  @override
  List<Object> get props => [];
}

class DislikeInProgress extends DislikeState {
  @override
  List<Object> get props => [];
}

class DislikeSuccess extends DislikeState {
  final NewsFeedEntity feed;

  DislikeSuccess({this.feed});

  @override
  List<Object> get props => [feed];
}

class UndislikeSuccess extends DislikeState {
  final NewsFeedEntity feed;

  UndislikeSuccess({this.feed});

  @override
  List<Object> get props => [feed];
}

class DislikeError extends DislikeState {
  final String message;

  DislikeError({this.message});

  @override
  List<Object> get props => [message];
}
