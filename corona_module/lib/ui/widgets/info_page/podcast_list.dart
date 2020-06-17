import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../blocs/podcast_bloc/podcast_bloc.dart';
import '../../../blocs/podcast_player_bloc/podcast_player_bloc.dart';
import '../../../core/models/podcast.dart';
import '../../styles/styles.dart';
import '../indicators/busy_indicator.dart';
import '../indicators/empty_icon.dart';
import '../indicators/error_icon.dart';
import 'podcast_details/min_podcast_player.dart';
import 'podcast_details/podcast_card.dart';
import 'podcast_details/podcast_player.dart';


class PodcastList extends StatefulWidget {
  const PodcastList();

  @override
  _PodcastListState createState() => _PodcastListState();
}

class _PodcastListState extends State<PodcastList> {
  double _panelPos = 0.0;
  double _minPanelHeight = 0.0;
  PanelController _panelController;

  @override
  void initState() {
    super.initState();
    _panelController = PanelController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PodcastBloc, PodcastState>(
      builder: (context, state) {
        if (state is InitialPodcastState) {
          return const EmptyIcon();
        } else if (state is LoadedPodcastState) {
          return _buildScaffold(state.podcasts);
        } else if (state is ErrorPodcastState) {
          return ErrorIcon(message: state.message);
        } else {
          return const BusyIndicator();
        }
      },
    );
  }

  SlidingUpPanel _buildScaffold(List<Podcast> podcasts) {
    return SlidingUpPanel(
      controller: _panelController,
      color: AppColors.primary,
      isDraggable: true,
      backdropEnabled: true,
      backdropTapClosesPanel: true,
      slideDirection: SlideDirection.UP,
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 72.0),
      borderRadius: BorderRadius.circular(12.0),
      minHeight: _minPanelHeight,
      onPanelSlide: (value) => setState(() => _panelPos = value),
      body: _buildList(podcasts),
      collapsed: _buildMinimizedPlayer(),
      panelBuilder: (sc) => Transform.scale(
        scale: _panelPos,
        child: _buildPlayer(sc),
      ),
    );
  }

  ListView _buildList(List<Podcast> podcasts) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 16.0, bottom: 250.0),
      itemCount: podcasts.length,
      itemBuilder: (_, index) {
        final podcast = podcasts[index];
        return BlocBuilder<PodcastPlayerBloc, PodcastPlayerState>(
          builder: (context, state) {
            return PodcastCard(
              podcast: podcast,
              color: AppColors.accentColors[index % AppColors.accentColors.length],
              isLoading:
                  (state is LoadingPodcastPlayerState) ? state.currentPodcast == podcast : false,
              isPlaying: (state is LoadedPodcastPlayerState)
                  ? state.playerState.currentPodcast == podcast
                  : false,
            );
          },
        );
      },
    );
  }

  Widget _buildMinimizedPlayer() {
    return BlocConsumer<PodcastPlayerBloc, PodcastPlayerState>(
      listener: (context, state) {
        if (state is ErrorPodcastPlayerState) {
          setState(() => _minPanelHeight = 0.0);
          Scaffold.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.primary,
              duration: const Duration(milliseconds: 1500),
              content: Text(
                state.message,
                style: AppTextStyles.smallLight,
              ),
            ),
          );
        } else if (state is LoadedPodcastPlayerState) {
          setState(() => _minPanelHeight = 90.0);
        } else {
          setState(() => _minPanelHeight = 0.0);
        }
      },
      builder: (context, state) {
        if (state is LoadedPodcastPlayerState) {
          return MinPodcastPlayer(playerState: state.playerState);
        } else {
          return Offstage();
        }
      },
    );
  }

  Widget _buildPlayer(ScrollController controller) {
    return BlocBuilder<PodcastPlayerBloc, PodcastPlayerState>(
      builder: (context, state) {
        if (state is LoadingPodcastPlayerState) {
          return const BusyIndicator();
        } else if (state is LoadedPodcastPlayerState) {
          return PodcastPlayer(
            playerState: state.playerState,
            controller: controller,
          );
        } else if (state is ErrorPodcastPlayerState) {
          return const ErrorIcon();
        } else {
          _panelController.close();
          return const Offstage();
        }
      },
    );
  }
}
