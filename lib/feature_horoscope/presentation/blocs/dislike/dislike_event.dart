part of 'dislike_bloc.dart';

abstract class DislikeUndislikeEvent extends Equatable {
  const DislikeUndislikeEvent();
  @override
  List<Object> get props => [];
}

class DislikeEvent extends DislikeUndislikeEvent {}

class UndislikeEvent extends DislikeUndislikeEvent {}
