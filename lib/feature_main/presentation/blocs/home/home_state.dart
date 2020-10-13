part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadSuccessState extends HomeState {
  final HomeUIModel homeModel;

  HomeLoadSuccessState({@required this.homeModel});

  @override
  List<Object> get props => [homeModel];
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
