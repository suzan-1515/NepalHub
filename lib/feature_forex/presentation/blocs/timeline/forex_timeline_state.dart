part of 'forex_timeline_bloc.dart';

abstract class ForexTimelineState extends Equatable {
  const ForexTimelineState();

  @override
  List<Object> get props => [];
}

class ForexTimelineInitialState extends ForexTimelineState {}

class ForexTimeLineLoadingState extends ForexTimelineState {}

class ForexTimelineLoadSuccessState extends ForexTimelineState {
  final List<ForexUIModel> forexList;

  ForexTimelineLoadSuccessState({@required this.forexList});
}

class ForexTimelineLoadErrorState extends ForexTimelineState {
  final String message;

  ForexTimelineLoadErrorState({this.message});

  @override
  List<Object> get props => [message];
}

class ForexTimelineEmptyState extends ForexTimelineState {
  final String message;

  ForexTimelineEmptyState({this.message});

  @override
  List<Object> get props => [message];
}

class ForexTimelineErrorState extends ForexTimelineState {
  final String message;

  ForexTimelineErrorState({this.message});

  @override
  List<Object> get props => [message];
}
