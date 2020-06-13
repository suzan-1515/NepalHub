part of 'podcast_bloc.dart';

@immutable
abstract class PodcastState {}

class InitialPodcastState extends PodcastState {}

class LoadingPodcastState extends PodcastState {}

class LoadedPodcastState extends PodcastState {
  final List<Podcast> podcasts;

  LoadedPodcastState({
    @required this.podcasts,
  }) : assert(podcasts != null);
}

class ErrorPodcastState extends PodcastState {
  final String message;

  ErrorPodcastState({
    @required this.message,
  }) : assert(message != null);
}
