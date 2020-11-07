part of 'like_unlike_bloc.dart';

abstract class LikeUnlikeEvent extends Equatable {
  const LikeUnlikeEvent();
  @override
  List<Object> get props => [];
}

class LikeEvent extends LikeUnlikeEvent {
  final ForexEntity forex;

  LikeEvent({@required this.forex});

  @override
  List<Object> get props => [forex];
}

class UnlikeEvent extends LikeUnlikeEvent {
  final ForexEntity forex;

  UnlikeEvent({@required this.forex});

  @override
  List<Object> get props => [forex];
}
