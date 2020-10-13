part of 'like_unlike_bloc.dart';

abstract class LikeUnlikeEvent extends Equatable {
  const LikeUnlikeEvent();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LikeEvent extends LikeUnlikeEvent {}

class UnlikeEvent extends LikeUnlikeEvent {}
