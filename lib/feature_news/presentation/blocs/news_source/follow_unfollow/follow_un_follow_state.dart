part of 'follow_un_follow_bloc.dart';

abstract class SourceFollowUnFollowState extends Equatable {
  const SourceFollowUnFollowState();

  @override
  List<Object> get props => [];
}

class SourceFollowInitialState extends SourceFollowUnFollowState {
  SourceFollowInitialState();
}

class SourceFollowInProgressState extends SourceFollowUnFollowState {
  @override
  List<Object> get props => [];
}

class SourceFollowSuccessState extends SourceFollowUnFollowState {
  final NewsSourceEntity source;

  SourceFollowSuccessState({this.source});

  @override
  List<Object> get props => [source];
}

class SourceUnFollowSuccessState extends SourceFollowUnFollowState {
  final NewsSourceEntity source;

  SourceUnFollowSuccessState({this.source});

  @override
  List<Object> get props => [source];
}

class SourceFollowErrorState extends SourceFollowUnFollowState {
  final String message;

  SourceFollowErrorState({this.message});

  @override
  List<Object> get props => [message];
}
