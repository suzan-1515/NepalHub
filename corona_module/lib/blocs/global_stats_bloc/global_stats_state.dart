part of 'global_stats_bloc.dart';

@immutable
abstract class GlobalStatsState {}

class InitialGlobalStatsState extends GlobalStatsState {}

class LoadingGlobalStatsState extends GlobalStatsState {}

class LoadedGlobalStatsState extends GlobalStatsState {
  final List<TimelineData> globalTimeline;

  LoadedGlobalStatsState({
    @required this.globalTimeline,
  }) : assert(globalTimeline != null);
}

class ErrorGlobalStatsState extends GlobalStatsState {
  final String message;

  ErrorGlobalStatsState({
    @required this.message,
  }) : assert(message != null);
}
