part of 'thread_stats_cubit.dart';

abstract class ThreadStatsState extends Equatable {
  const ThreadStatsState();

  @override
  List<Object> get props => [];
}

class ThreadStatsInitial extends ThreadStatsState {}

class ThreadStatsLoading extends ThreadStatsState {}

class ThreadStatsLoadSuccess extends ThreadStatsState {
  final ThreadStatsUIModel threadStatsUIModel;

  ThreadStatsLoadSuccess({@required this.threadStatsUIModel});

  @override
  List<Object> get props => [threadStatsUIModel];
}

class ThreadStatsLoadEmpty extends ThreadStatsState {
  final String message;

  ThreadStatsLoadEmpty({@required this.message});

  @override
  List<Object> get props => [message];
}

class ThreadStatsLoadError extends ThreadStatsState {
  final String message;

  ThreadStatsLoadError({@required this.message});

  @override
  List<Object> get props => [message];
}
