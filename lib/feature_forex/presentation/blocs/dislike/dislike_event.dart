part of 'dislike_bloc.dart';

abstract class DislikeUndislikeEvent extends Equatable {
  const DislikeUndislikeEvent();
  @override
  List<Object> get props => [];
}

class DislikeEvent extends DislikeUndislikeEvent {
  final ForexEntity forex;

  DislikeEvent({@required this.forex});

  @override
  List<Object> get props => [this.forex];
}

class UndislikeEvent extends DislikeUndislikeEvent {
  final ForexEntity forex;

  UndislikeEvent({@required this.forex});

  @override
  List<Object> get props => [this.forex];
}
