part of 'horoscope_bloc.dart';

abstract class HoroscopeState extends Equatable {
  const HoroscopeState();

  @override
  List<Object> get props => [];
}

class HoroscopeInitialState extends HoroscopeState {}

class HoroscopeLoadingState extends HoroscopeState {}

class HoroscopeLoadSuccessState extends HoroscopeState {
  final HoroscopeUIModel horoscope;

  const HoroscopeLoadSuccessState({
    @required this.horoscope,
  });

  @override
  List<Object> get props => [horoscope];
}

class HoroscopeEmptyState extends HoroscopeState {
  final String message;

  const HoroscopeEmptyState({this.message});

  @override
  List<Object> get props => [message];
}

class HoroscopeErrorState extends HoroscopeState {
  final String message;

  const HoroscopeErrorState({this.message});

  @override
  List<Object> get props => [message];
}

class HoroscopeLoadErrorState extends HoroscopeState {
  final String message;

  const HoroscopeLoadErrorState({this.message});

  @override
  List<Object> get props => [message];
}
