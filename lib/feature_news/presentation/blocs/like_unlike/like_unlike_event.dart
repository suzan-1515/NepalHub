part of 'like_unlike_bloc.dart';

abstract class LikeUnlikeEvent extends Equatable {
  const LikeUnlikeEvent();
}

class LikeEvent extends LikeUnlikeEvent {
  final NewsFeedUIModel feedModel;

  LikeEvent({@required this.feedModel});

  @override
  List<Object> get props => [feedModel.feed];
}

class UnlikeEvent extends LikeUnlikeEvent {
  final NewsFeedUIModel feedModel;

  UnlikeEvent({@required this.feedModel});

  @override
  List<Object> get props => [feedModel.feed];
}
