import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../core/models/app_error.dart';
import '../../core/models/podcast.dart';
import '../../core/services/nepal_api_service.dart';

part 'podcast_event.dart';
part 'podcast_state.dart';

class PodcastBloc extends Bloc<PodcastEvent, PodcastState> {
  final NepalApiService apiService;

  PodcastBloc({
    @required this.apiService,
  })  : assert(apiService != null),
        super(InitialPodcastState());

  @override
  Stream<PodcastState> mapEventToState(
    PodcastEvent event,
  ) async* {
    if (event is GetPodcastEvent) {
      yield LoadingPodcastState();
      try {
        final List<Podcast> podcasts = await apiService.fetchPodcasts(0);
        yield LoadedPodcastState(
          podcasts: podcasts,
        );
      } on AppError catch (e) {
        print(e.error);
        yield ErrorPodcastState(message: e.message);
      }
    }
  }
}
