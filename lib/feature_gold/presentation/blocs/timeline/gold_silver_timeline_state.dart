part of 'gold_silver_timeline_bloc.dart';

abstract class GoldSilverTimelineState extends Equatable {
  const GoldSilverTimelineState();

  @override
  List<Object> get props => [];
}

class GoldSilverTimelineInitialState extends GoldSilverTimelineState {}

class GoldSilverTimeLineLoadingState extends GoldSilverTimelineState {}

class GoldSilverTimelineLoadSuccessState extends GoldSilverTimelineState {
  final List<GoldSilverEntity> goldSilverList;

  GoldSilverTimelineLoadSuccessState({@required this.goldSilverList});

  @override
  List<Object> get props => [goldSilverList];
}

class GoldSilverTimelineLoadErrorState extends GoldSilverTimelineState {
  final String message;

  GoldSilverTimelineLoadErrorState({this.message});

  @override
  List<Object> get props => [message];
}

class GoldSilverTimelineEmptyState extends GoldSilverTimelineState {
  final String message;

  GoldSilverTimelineEmptyState({this.message});

  @override
  List<Object> get props => [message];
}

class GoldSilverTimelineErrorState extends GoldSilverTimelineState {
  final String message;

  GoldSilverTimelineErrorState({this.message});

  @override
  List<Object> get props => [message];
}
