import 'package:flutter/material.dart';

import '../../../core/models/nepal_stats.dart';
import '../../styles/styles.dart';
import '../common/pill.dart';
import '../common/timeline_graph.dart';
import 'stats_grid.dart';

class NepalStatsList extends StatelessWidget {
  final ScrollController controller;
  final NepalStats nepalStats;

  const NepalStatsList({
    @required this.controller,
    @required this.nepalStats,
  })  : assert(controller != null),
        assert(nepalStats != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 4.0),
        const Pill(),
        const SizedBox(height: 8.0),
        Text(
          'NEPAL STATS',
          style: AppTextStyles.largeLight,
        ),
        const SizedBox(height: 8.0),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            controller: controller,
            children: [
              StatsGrid(nepalStats: nepalStats),
              TimelineGraph(
                title: 'Nepal',
                timeline: nepalStats.timeline,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
