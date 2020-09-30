part of 'latest_forex_bloc.dart';

abstract class ForexState extends Equatable {
  const ForexState();

  @override
  List<Object> get props => [];
}

class ForexInitialState extends ForexState {}

class ForexLoadingState extends ForexState {}

class ForexLoadSuccessState extends ForexState {
  final List<ForexUIModel> forexList;
  final ForexUIModel defaultForex;

  const ForexLoadSuccessState({
    @required this.forexList,
    @required this.defaultForex,
  });
}

class ForexEmptyState extends ForexState {
  final String message;

  const ForexEmptyState({this.message});

  @override
  List<Object> get props => [message];
}

class ForexErrorState extends ForexState {
  final String message;

  const ForexErrorState({this.message});

  @override
  List<Object> get props => [message];
}

class ForexLoadErrorState extends ForexState {
  final String message;

  const ForexLoadErrorState({this.message});

  @override
  List<Object> get props => [message];
}
