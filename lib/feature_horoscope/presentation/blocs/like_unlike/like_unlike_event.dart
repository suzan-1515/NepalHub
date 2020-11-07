part of 'like_unlike_bloc.dart';

abstract class LikeUnlikeEvent extends Equatable {
  const LikeUnlikeEvent();
  @override
  List<Object> get props => [];
}

class LikeEvent extends LikeUnlikeEvent {
  final HoroscopeEntity horoscope;

  LikeEvent({@required this.horoscope});

  @override
  List<Object> get props => [horoscope];
}

class UnlikeEvent extends LikeUnlikeEvent {
  final HoroscopeEntity horoscope;

  UnlikeEvent({@required this.horoscope});

  @override
  List<Object> get props => [horoscope];
}
