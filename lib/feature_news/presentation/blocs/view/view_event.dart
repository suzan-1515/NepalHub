part of 'view_bloc.dart';

abstract class ViewEvent extends Equatable {
  const ViewEvent();
  @override
  List<Object> get props => [];
}

class View extends ViewEvent {
  final NewsFeedEntity feed;

  View({this.feed});

  @override
  List<Object> get props => [feed];
}
