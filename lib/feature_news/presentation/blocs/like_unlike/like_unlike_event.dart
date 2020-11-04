part of 'like_unlike_bloc.dart';

abstract class LikeUnlikeEvent extends Equatable {
  const LikeUnlikeEvent();
  @override
  List<Object> get props => [];
}

class LikeEvent extends LikeUnlikeEvent {
  final NewsFeedEntity feed;

  LikeEvent({@required this.feed});

  @override
  List<Object> get props => [feed];
}

class UnlikeEvent extends LikeUnlikeEvent {
  final NewsFeedEntity feed;

  UnlikeEvent({@required this.feed});

  @override
  List<Object> get props => [feed];
}

class UpdateLikeEvent extends LikeUnlikeEvent {
  final NewsFeedEntity feed;

  UpdateLikeEvent({@required this.feed});

  @override
  List<Object> get props => [feed];
}

class UpdateUnlikeEvent extends LikeUnlikeEvent {
  final NewsFeedEntity feed;

  UpdateUnlikeEvent({@required this.feed});

  @override
  List<Object> get props => [feed];
}
