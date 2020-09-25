part of 'like_unlike_bloc.dart';

abstract class LikeUnlikeEvent extends Equatable {
  const LikeUnlikeEvent();

  @override
  List<Object> get props => [];
}

class LikeEvent extends LikeUnlikeEvent {
  const LikeEvent();
}

class UnlikeEvent extends LikeUnlikeEvent {
  const UnlikeEvent();
}
