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
  final HoroscopeEntity horoscope;

  DislikeSuccess({@required this.horoscope});

  @override
  List<Object> get props => [horoscope];
}

class UndislikeSuccess extends DislikeState {
  final HoroscopeEntity horoscope;

  UndislikeSuccess({@required this.horoscope});

  @override
  List<Object> get props => [horoscope];
}

class DislikeError extends DislikeState {
  final String message;

  DislikeError({this.message});

  @override
  List<Object> get props => [message];
}
