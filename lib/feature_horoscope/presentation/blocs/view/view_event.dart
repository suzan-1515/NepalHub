part of 'view_bloc.dart';

abstract class ViewEvent extends Equatable {
  const ViewEvent();
  @override
  List<Object> get props => [];
}

class View extends ViewEvent {
  final HoroscopeEntity horoscope;

  View({@required this.horoscope});

  @override
  List<Object> get props => [horoscope];
}
