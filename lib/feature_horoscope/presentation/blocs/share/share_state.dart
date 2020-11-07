part of 'share_bloc.dart';

abstract class ShareState extends Equatable {
  const ShareState();
}

class ShareInitial extends ShareState {
  @override
  List<Object> get props => [];
}

class ShareInProgress extends ShareState {
  @override
  List<Object> get props => [];
}

class ShareSuccess extends ShareState {
  final HoroscopeEntity horoscope;

  ShareSuccess({@required this.horoscope});

  @override
  List<Object> get props => [horoscope];
}

class ShareError extends ShareState {
  final String message;

  ShareError({this.message});

  @override
  List<Object> get props => [message];
}
