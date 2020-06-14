import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../../blocs/podcast_player_bloc/podcast_player_bloc.dart';
import '../../../../core/models/podcast.dart';
import '../../../styles/styles.dart';
import '../../common/scale_animator.dart';
import '../../common/tag.dart';


class PodcastCard extends StatelessWidget {
  final Podcast podcast;
  final Color color;
  final bool isLoading;
  final bool isPlaying;

  const PodcastCard({
    @required this.podcast,
    @required this.color,
    @required this.isLoading,
    @required this.isPlaying,
  })  : assert(podcast != null),
        assert(color != null),
        assert(isLoading != null),
        assert(isPlaying != null);

  @override
  Widget build(BuildContext context) {
    return ScaleAnimator(
      child: Card(
        color: AppColors.dark,
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: ExpansionTile(
          initiallyExpanded: isPlaying,
          backgroundColor: color.withOpacity(0.2),
          trailing: Offstage(),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: 8.0),
              _buildImage(),
              const SizedBox(width: 8.0),
              _buildTitle(),
              const SizedBox(width: 8.0),
              isLoading
                  ? _buildLoadingIndicator()
                  : isPlaying ? _buildPlayingIndicator() : _buildPlayIcon(context),
            ],
          ),
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildSubTitle(),
                _buildTag(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Card(
      margin: const EdgeInsets.all(8.0),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Image.network(
        podcast.imageUrl,
        fit: BoxFit.cover,
        width: 64.0,
        height: 64.0,
        errorBuilder: (_, __, ___) => Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(
            'assets/icon/icon.png',
            fit: BoxFit.cover,
            width: 44.0,
            height: 44.0,
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Expanded(
      child: Text(
        podcast.title.trim(),
        textAlign: TextAlign.left,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyles.largeLightSerif,
      ),
    );
  }

  Widget _buildSubTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        podcast.summary.trim(),
        textAlign: TextAlign.justify,
        style: AppTextStyles.smallLightSerif,
      ),
    );
  }

  Widget _buildTag() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Tag(
        label: podcast.source,
        color: color,
        iconData: null,
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return SizedBox(
      width: 24.0,
      height: 24.0,
      child: CircularProgressIndicator(
        backgroundColor: color,
      ),
    );
  }

  Widget _buildPlayingIndicator() {
    return SizedBox(
      width: 24.0,
      height: 24.0,
      child: LoadingIndicator(
        indicatorType: Indicator.audioEqualizer,
        color: color,
      ),
    );
  }

  Widget _buildPlayIcon(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(32.0),
      onTap: () => context.bloc<PodcastPlayerBloc>()
        ..add(InitPodcastEvent(
          podcast: podcast,
        )),
      child: Icon(
        Icons.play_circle_filled,
        size: 28.0,
        color: color,
      ),
    );
  }
}
