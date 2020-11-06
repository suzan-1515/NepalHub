import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/widgets/progress_widget.dart';
import 'package:samachar_hub/feature_gold/presentation/blocs/timeline/gold_silver_timeline_bloc.dart';
import 'package:samachar_hub/feature_gold/presentation/ui/gold_silver/widgets/gold_silver_graph.dart';

class PriceTimeline extends StatelessWidget {
  const PriceTimeline({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoldSilverTimelineBloc, GoldSilverTimelineState>(
      buildWhen: (previous, current) =>
          !(current is GoldSilverTimelineErrorState),
      builder: (context, state) {
        if (state is GoldSilverTimelineLoadSuccessState) {
          return GoldSilverGraph(
            timeline: state.goldSilverList,
          );
        } else if (state is GoldSilverTimeLineLoadingState) {
          return Center(child: ProgressView());
        }
        return SizedBox.shrink();
      },
    );
  }
}
