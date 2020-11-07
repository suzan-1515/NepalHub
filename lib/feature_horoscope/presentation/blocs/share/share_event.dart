part of 'share_bloc.dart';

abstract class ShareEvent extends Equatable {
  const ShareEvent();
  @override
  List<Object> get props => [];
}

class Share extends ShareEvent {
  final HoroscopeEntity horoscope;

  Share({@required this.horoscope});

  @override
  List<Object> get props => [horoscope];
}
