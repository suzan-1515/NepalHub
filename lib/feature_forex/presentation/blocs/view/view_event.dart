part of 'view_bloc.dart';

abstract class ViewEvent extends Equatable {
  const ViewEvent();
  @override
  List<Object> get props => [];
}

class View extends ViewEvent {
  final ForexEntity forex;

  View({@required this.forex});

  @override
  List<Object> get props => [forex];
}
