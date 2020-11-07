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
  final ForexEntity forex;

  DislikeSuccess({@required this.forex});

  @override
  List<Object> get props => [this.forex];
}

class UndislikeSuccess extends DislikeState {
  final ForexEntity forex;

  UndislikeSuccess({@required this.forex});

  @override
  List<Object> get props => [this.forex];
}

class DislikeError extends DislikeState {
  final String message;

  DislikeError({this.message});

  @override
  List<Object> get props => [message];
}
