part of 'dislike_bloc.dart';

abstract class DislikeUndislikeEvent extends Equatable {
  const DislikeUndislikeEvent();

  @override
  List<Object> get props => [];
}

class DislikeEvent extends DislikeUndislikeEvent {
  final NewsFeedEntity feed;

  DislikeEvent({@required this.feed});

  @override
  List<Object> get props => [feed];
}

class UndislikeEvent extends DislikeUndislikeEvent {
  final NewsFeedEntity feed;

  UndislikeEvent({@required this.feed});

  @override
  List<Object> get props => [feed];
}
