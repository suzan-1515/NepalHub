part of 'podcast_player_bloc.dart';

@immutable
abstract class PodcastPlayerEvent {}

class InitPodcastEvent extends PodcastPlayerEvent {
  final Podcast podcast;

  InitPodcastEvent({
    @required this.podcast,
  }) : assert(podcast != null);
}

class PlayPodcastEvent extends PodcastPlayerEvent {}

class PausePodcastEvent extends PodcastPlayerEvent {}

class StopPodcastEvent extends PodcastPlayerEvent {}

class SeekPodcastEvent extends PodcastPlayerEvent {
  final double seconds;

  SeekPodcastEvent({
    @required this.seconds,
  }) : assert(seconds != null);
}

class SetSpeedPodcastEvent extends PodcastPlayerEvent {
  final double speed;

  SetSpeedPodcastEvent({
    @required this.speed,
  }) : assert(speed != null);
}

class CompletedPodcastEvent extends PodcastPlayerEvent {}
