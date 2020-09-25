import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../core/models/app_error.dart';
import '../../core/models/podcast.dart';
import '../../core/models/podcast_player_data.dart';
import '../../core/services/podcast_player_service.dart';

part 'podcast_player_event.dart';
part 'podcast_player_state.dart';

class PodcastPlayerBloc extends Bloc<PodcastPlayerEvent, PodcastPlayerState> {
  final PodcastPlayerService podcastPlayerService;

  PodcastPlayerBloc({
    @required this.podcastPlayerService,
  })  : assert(podcastPlayerService != null),
        super(InitialPodcastPlayerState());

  @override
  Stream<PodcastPlayerState> mapEventToState(
    PodcastPlayerEvent event,
  ) async* {
    if (event is InitPodcastEvent) yield* _mapInitToState(event.podcast);
    if (event is PlayPodcastEvent) yield* _mapPlayToState();
    if (event is PausePodcastEvent) yield* _mapPauseToState();
    if (event is StopPodcastEvent) yield* _mapStopToState();
    if (event is SeekPodcastEvent) yield* _mapSeekToState(event.seconds);
    if (event is SetSpeedPodcastEvent) yield* _mapSetSpeedToState(event.speed);
    if (event is CompletedPodcastEvent) yield* _mapCompletedToState();
  }

  Stream<PodcastPlayerState> _mapInitToState(Podcast podcast) async* {
    yield LoadingPodcastPlayerState(currentPodcast: podcast);
    try {
      await podcastPlayerService.init(podcast);
      yield LoadedPodcastPlayerState(
        playerState: podcastPlayerService.state,
      );
    } on AppError catch (e) {
      yield ErrorPodcastPlayerState(message: e.message);
      yield InitialPodcastPlayerState();
    }
  }

  Stream<PodcastPlayerState> _mapPlayToState() async* {
    podcastPlayerService.play();
    yield LoadedPodcastPlayerState(
      playerState: podcastPlayerService.state,
    );
  }

  Stream<PodcastPlayerState> _mapPauseToState() async* {
    await podcastPlayerService.pause();
    yield LoadedPodcastPlayerState(
      playerState: podcastPlayerService.state,
    );
  }

  Stream<PodcastPlayerState> _mapStopToState() async* {
    await podcastPlayerService.stop();
    yield InitialPodcastPlayerState();
  }

  Stream<PodcastPlayerState> _mapSeekToState(double seconds) async* {
    podcastPlayerService.seekTo(Duration(seconds: seconds.toInt()));
    yield LoadedPodcastPlayerState(
      playerState: podcastPlayerService.state,
    );
  }

  Stream<PodcastPlayerState> _mapSetSpeedToState(double speed) async* {
    await podcastPlayerService.setSpeed(speed);
    yield LoadedPodcastPlayerState(
      playerState: podcastPlayerService.state,
    );
  }

  Stream<PodcastPlayerState> _mapCompletedToState() async* {
    await podcastPlayerService.stop();
    yield InitialPodcastPlayerState();
  }
}
