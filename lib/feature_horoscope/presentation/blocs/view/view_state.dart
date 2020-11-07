part of 'view_bloc.dart';

abstract class ViewState extends Equatable {
  const ViewState();
}

class ViewInitial extends ViewState {
  @override
  List<Object> get props => [];
}

class ViewInProgress extends ViewState {
  @override
  List<Object> get props => [];
}

class ViewSuccess extends ViewState {
  final HoroscopeEntity horoscope;

  ViewSuccess({@required this.horoscope});

  @override
  List<Object> get props => [horoscope];
}

class ViewError extends ViewState {
  final String message;

  ViewError({this.message});

  @override
  List<Object> get props => [message];
}
