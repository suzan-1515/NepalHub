import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../blocs/global_stats_bloc/global_stats_bloc.dart';
import '../../styles/styles.dart';
import '../common/pill.dart';
import '../common/timeline_graph.dart';
import 'stat_column.dart';

class GlobalStatsTile extends StatefulWidget {
  @override
  _GlobalStatsTileState createState() => _GlobalStatsTileState();
}

class _GlobalStatsTileState extends State<GlobalStatsTile> {
  double panelPos = 0.0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalStatsBloc, GlobalStatsState>(
      builder: (context, state) {
        if (state is InitialGlobalStatsState) {
          return const Offstage();
        } else if (state is LoadedGlobalStatsState) {
          return _buildPanel(state);
        } else if (state is ErrorGlobalStatsState) {
          return const Offstage();
        } else {
          return const Offstage();
        }
      },
    );
  }

  Widget _buildPanel(LoadedGlobalStatsState state) {
    return SlidingUpPanel(
      color: AppColors.dark,
      parallaxOffset: 0.2,
      isDraggable: true,
      parallaxEnabled: true,
      backdropEnabled: false,
      slideDirection: SlideDirection.DOWN,
      margin: const EdgeInsets.all(12.0),
      borderRadius: BorderRadius.circular(16.0),
      maxHeight: MediaQuery.of(context).size.height * 0.7,
      minHeight: 96.0,
      onPanelSlide: (value) => setState(() {
        panelPos = value;
      }),
      collapsed: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildStatsRow(state, context),
          const Pill(),
        ],
      ),
      panelBuilder: (_) => Transform.scale(
        scale: panelPos,
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              TimelineGraph(
                title: 'Global',
                timeline: state.globalTimeline,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsRow(LoadedGlobalStatsState state, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          StatColumn(
            label: 'Confirmed',
            count: state.globalTimeline.last.confirmed,
            color: Colors.blue,
          ),
          StatColumn(
            label: 'Recovered',
            count: state.globalTimeline.last.recovered,
            color: Colors.green,
          ),
          StatColumn(
            label: 'Deaths',
            count: state.globalTimeline.last.deaths,
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}
