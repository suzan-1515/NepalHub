part of 'latest_gold_silver_bloc.dart';

abstract class GoldSilverState extends Equatable {
  const GoldSilverState();

  @override
  List<Object> get props => [];
}

class GoldSilverInitialState extends GoldSilverState {}

class GoldSilverLoadingState extends GoldSilverState {}

class GoldSilverLoadSuccessState extends GoldSilverState {
  final List<GoldSilverUIModel> goldSilverList;
  final GoldSilverUIModel defaultGoldSilver;

  const GoldSilverLoadSuccessState({
    @required this.goldSilverList,
    @required this.defaultGoldSilver,
  });
  @override
  List<Object> get props => [goldSilverList, defaultGoldSilver];
}

class GoldSilverEmptyState extends GoldSilverState {
  final String message;

  const GoldSilverEmptyState({this.message});

  @override
  List<Object> get props => [message];
}

class GoldSilverErrorState extends GoldSilverState {
  final String message;

  const GoldSilverErrorState({this.message});

  @override
  List<Object> get props => [message];
}

class GoldSilverLoadErrorState extends GoldSilverState {
  final String message;

  const GoldSilverLoadErrorState({this.message});

  @override
  List<Object> get props => [message];
}
