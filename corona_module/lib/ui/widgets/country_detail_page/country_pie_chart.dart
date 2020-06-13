import 'package:flutter/material.dart';

import '../../../core/models/country.dart';
import '../../styles/styles.dart';
import '../common/country_stat_chart.dart';
import '../common/label.dart';


class CountryPieChart extends StatelessWidget {
  final Country country;

  const CountryPieChart({
    @required this.country,
  }) : assert(country != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'CASES DISTRIBUTION',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: AppTextStyles.mediumLight,
        ),
        const SizedBox(height: 24.0),
        CountryStatChart(
          opacity: 0.4,
          active: country.activeCases,
          recovered: country.totalRecovered,
          deaths: country.totalDeaths,
          centerSpaceRadius: 50.0,
          radius: 40.0,
          showPercent: true,
        ),
        const SizedBox(height: 8.0),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Label(text: 'Active (${country.activeCases})', color: Colors.yellow),
            const SizedBox(height: 8.0),
            Label(text: 'Recovered (${country.totalRecovered})', color: Colors.green),
            const SizedBox(height: 8.0),
            Label(text: 'Deaths (${country.totalDeaths})', color: Colors.red),
          ],
        ),
      ],
    );
  }
}
