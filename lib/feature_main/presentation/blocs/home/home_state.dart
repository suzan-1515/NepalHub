part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadSuccessState extends HomeState {
  final HomeUIModel home;

  HomeLoadSuccessState({@required this.home});

  @override
  List<Object> get props => [home];
}

class HomeEmptyState extends HomeState {
  final String message;

  HomeEmptyState({@required this.message});

  @override
  List<Object> get props => [message];
}

class HomeErrorState extends HomeState {
  final String message;

  HomeErrorState({@required this.message});

  @override
  List<Object> get props => [message];
}

class HomeLoadErrorState extends HomeState {
  final String message;

  HomeLoadErrorState({@required this.message});

  @override
  List<Object> get props => [message];
}
