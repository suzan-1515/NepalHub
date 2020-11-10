part of 'follow_un_follow_bloc.dart';

abstract class SourceFollowUnFollowEvent extends Equatable {
  const SourceFollowUnFollowEvent();
  @override
  List<Object> get props => [];
}

class SourceFollowEvent extends SourceFollowUnFollowEvent {
  final NewsSourceEntity source;

  SourceFollowEvent({@required this.source});

  @override
  List<Object> get props => [source];
}

class SourceUnFollowEvent extends SourceFollowUnFollowEvent {
  final NewsSourceEntity source;

  SourceUnFollowEvent({@required this.source});

  @override
  List<Object> get props => [source];
}
