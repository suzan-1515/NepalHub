part of 'like_unlike_bloc.dart';

abstract class LikeUnlikeState extends Equatable {
  const LikeUnlikeState();
}

class InitialState extends LikeUnlikeState {
  @override
  List<Object> get props => [];
}

class InProgressState extends LikeUnlikeState {
  @override
  List<Object> get props => [];
}

class LikedState extends LikeUnlikeState {
  final HoroscopeEntity horoscope;

  LikedState({@required this.horoscope});

  @override
  List<Object> get props => [horoscope];
}

class UnlikedState extends LikeUnlikeState {
  final HoroscopeEntity horoscope;

  UnlikedState({@required this.horoscope});

  @override
  List<Object> get props => [horoscope];
}

class ErrorState extends LikeUnlikeState {
  final String message;

  ErrorState({this.message});

  @override
  List<Object> get props => [message];
}
