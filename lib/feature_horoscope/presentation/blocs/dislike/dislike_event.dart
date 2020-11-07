part of 'dislike_bloc.dart';

abstract class DislikeUndislikeEvent extends Equatable {
  const DislikeUndislikeEvent();
  @override
  List<Object> get props => [];
}

class DislikeEvent extends DislikeUndislikeEvent {
  final HoroscopeEntity horoscope;

  DislikeEvent({@required this.horoscope});

  @override
  List<Object> get props => [horoscope];
}

class UndislikeEvent extends DislikeUndislikeEvent {
  final HoroscopeEntity horoscope;

  UndislikeEvent({@required this.horoscope});

  @override
  List<Object> get props => [horoscope];
}
