import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/widgets/progress_widget.dart';
import 'package:samachar_hub/feature_forex/presentation/blocs/timeline/forex_timeline_bloc.dart';
import 'package:samachar_hub/feature_forex/presentation/ui/forex/widgets/forex_graph.dart';

class RateTimeline extends StatelessWidget {
  const RateTimeline({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForexTimelineBloc, ForexTimelineState>(
      buildWhen: (previous, current) => !(current is ForexTimelineErrorState),
      builder: (context, state) {
        if (state is ForexTimelineLoadSuccessState) {
          return ForexGraph(
            timeline: state.forexList,
          );
        } else if (state is ForexTimeLineLoadingState) {
          return Center(child: ProgressView());
        }
        return SizedBox.shrink();
      },
    );
  }
}
