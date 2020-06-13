part of 'podcast_player_bloc.dart';

@immutable
abstract class PodcastPlayerState {}

class InitialPodcastPlayerState extends PodcastPlayerState {}

class LoadingPodcastPlayerState extends PodcastPlayerState {
  final Podcast currentPodcast;

  LoadingPodcastPlayerState({
    @required this.currentPodcast,
  }) : assert(currentPodcast != null);
}

class LoadedPodcastPlayerState extends PodcastPlayerState {
  final PodcastPlayerData playerState;

  LoadedPodcastPlayerState({
    @required this.playerState,
  }) : assert(playerState != null);
}

class ErrorPodcastPlayerState extends PodcastPlayerState {
  final String message;

  ErrorPodcastPlayerState({
    @required this.message,
  }) : assert(message != null);
}
