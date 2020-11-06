part of 'view_bloc.dart';

abstract class ViewEvent extends Equatable {
  const ViewEvent();
  @override
  List<Object> get props => [];
}

class View extends ViewEvent {
  final GoldSilverEntity goldSilver;

  View({@required this.goldSilver});

  @override
  List<Object> get props => [goldSilver];
}
