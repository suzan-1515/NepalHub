part of 'dislike_bloc.dart';

abstract class DislikeUndislikeEvent extends Equatable {
  const DislikeUndislikeEvent();
}

class DislikeEvent extends DislikeUndislikeEvent {
  final NewsFeedUIModel feedModel;

  DislikeEvent({@required this.feedModel});

  @override
  List<Object> get props => [feedModel.feed];
}

class UndislikeEvent extends DislikeUndislikeEvent {
  final NewsFeedUIModel feedModel;

  UndislikeEvent({@required this.feedModel});

  @override
  List<Object> get props => [feedModel.feed];
}
