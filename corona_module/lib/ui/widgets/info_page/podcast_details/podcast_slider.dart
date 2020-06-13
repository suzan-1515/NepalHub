import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/podcast_player_bloc/podcast_player_bloc.dart';
import '../../../../core/models/podcast_player_data.dart';
import '../../../styles/styles.dart';


class PodcastSlider extends StatefulWidget {
  final PodcastPlayerData playerState;

  const PodcastSlider({
    @required this.playerState,
  }) : assert(playerState != null);

  @override
  _PodcastSliderState createState() => _PodcastSliderState();
}

class _PodcastSliderState extends State<PodcastSlider> {
  bool isSeeking = false;
  double seekValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration>(
      stream: widget.playerState.currentPosition,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final Duration currentDuration = snapshot.data;

          if (currentDuration.inSeconds >= widget.playerState.duration.inSeconds - 1 &&
              !isSeeking) {
            context.bloc<PodcastPlayerBloc>()..add(CompletedPodcastEvent());
          }

          return _buildSlider(currentDuration, context);
        }
        return Center(
          child: CircularProgressIndicator(
            backgroundColor: AppColors.light,
          ),
        );
      },
    );
  }

  Row _buildSlider(Duration currentDuration, BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          format(currentDuration),
          style: AppTextStyles.extraSmallLight,
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0),
            valueIndicatorColor: AppColors.light.withOpacity(0.5),
            valueIndicatorTextStyle: AppTextStyles.smallDark,
          ),
          child: Slider(
            activeColor: AppColors.light,
            inactiveColor: AppColors.light.withOpacity(0.2),
            divisions: widget.playerState.duration.inSeconds,
            min: 0.0,
            max: widget.playerState.duration.inSeconds.toDouble(),
            value: isSeeking ? seekValue : currentDuration.inSeconds.toDouble(),
            label:
                isSeeking ? format(Duration(seconds: seekValue.toInt())) : format(currentDuration),
            onChangeStart: (_) => isSeeking = true,
            onChangeEnd: (value) {
              isSeeking = false;
              context.bloc<PodcastPlayerBloc>()
                ..add(SeekPodcastEvent(
                  seconds: value,
                ));
            },
            onChanged: (value) {
              setState(() {
                seekValue = value;
              });
            },
          ),
        ),
        Text(
          format(widget.playerState.duration),
          style: AppTextStyles.extraSmallLight,
        ),
      ],
    );
  }

  String format(Duration d) {
    List<String> durationList = d.toString().split(':');
    durationList.last = durationList.last.split('.').first;

    if (durationList.first == '0') {
      durationList.removeAt(0);
      return durationList.join(':');
    }
    return durationList.join(':');
  }
}
