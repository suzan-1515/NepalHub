import 'package:flutter/material.dart';

import '../../../core/models/nepal_stats.dart';
import '../common/stat_card.dart';


class StatsGrid extends StatelessWidget {
  final NepalStats nepalStats;

  const StatsGrid({@required this.nepalStats}) : assert(nepalStats != null);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        StatCard(
          label: 'Tested',
          count: nepalStats.total.toString(),
          color: Colors.blue,
        ),
        StatCard(
          label: 'Negative',
          count: nepalStats.negative.toString(),
          color: Colors.teal,
        ),
        StatCard(
          label: 'Positive',
          count: nepalStats.positive.toString(),
          color: Colors.yellow,
        ),
        StatCard(
          label: 'Tested RDT',
          count: nepalStats.testedRdt.toString(),
          color: Colors.pinkAccent,
        ),
        StatCard(
          label: 'Isolation',
          count: nepalStats.isolation.toString(),
          color: Colors.deepPurple,
        ),
        StatCard(
          label: 'Quarantine',
          count: nepalStats.quarantine.toString(),
          color: Colors.grey,
        ),
        StatCard(
          label: 'Recovered',
          count: nepalStats.recovered.toString(),
          color: Colors.green,
        ),
        StatCard(
          label: 'Active',
          count: nepalStats.active.toString(),
          color: Colors.orange,
        ),
        StatCard(
          label: 'Deaths',
          count: nepalStats.deaths.toString(),
          color: Colors.red,
        ),
      ],
    );
  }
}
