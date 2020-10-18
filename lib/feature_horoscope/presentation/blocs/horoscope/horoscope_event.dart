part of 'horoscope_bloc.dart';

abstract class HoroscopeEvent extends Equatable {
  const HoroscopeEvent();

  @override
  List<Object> get props => [];
}

class GetHoroscopeEvent extends HoroscopeEvent {
  final Language language;

  GetHoroscopeEvent({this.language = Language.NEPALI});
  @override
  List<Object> get props => [language];
}

class RefreshHoroscopeEvent extends HoroscopeEvent {
  final Language language;

  RefreshHoroscopeEvent({this.language = Language.NEPALI});
  @override
  List<Object> get props => [language];
}
