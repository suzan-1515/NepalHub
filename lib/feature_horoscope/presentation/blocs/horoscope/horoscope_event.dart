part of 'horoscope_bloc.dart';

abstract class HoroscopeEvent extends Equatable {
  const HoroscopeEvent();

  @override
  List<Object> get props => [];
}

class GetHoroscopeEvent extends HoroscopeEvent {
  final Language language;
  final int defaultSignIndex;

  GetHoroscopeEvent(
      {@required this.defaultSignIndex, this.language = Language.NEPALI});
  @override
  List<Object> get props => [language, defaultSignIndex];
}

class RefreshHoroscopeEvent extends HoroscopeEvent {
  final Language language;
  final int defaultSignIndex;

  RefreshHoroscopeEvent(
      {@required this.defaultSignIndex, this.language = Language.NEPALI});
  @override
  List<Object> get props => [language, defaultSignIndex];
}
