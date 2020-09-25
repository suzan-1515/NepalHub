part of 'view_bloc.dart';

abstract class ViewEvent extends Equatable {
  const ViewEvent();
}

class View extends ViewEvent {
  final NewsFeedUIModel feedModel;

  View({@required this.feedModel});

  @override
  List<Object> get props => [feedModel.feed];
}
