import 'package:flutter/material.dart';

import '../../../core/models/country.dart';
import '../../styles/styles.dart';
import '../common/stat_card.dart';

class CountryStatsGrid extends StatelessWidget {
  final Country country;

  const CountryStatsGrid({
    @required this.country,
  }) : assert(country != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'STATS',
          textAlign: TextAlign.center,
          style: AppTextStyles.mediumLight,
        ),
        const SizedBox(height: 8.0),
        GridView.count(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            StatCard(
              label: 'Confirmed',
              count: country.totalConfirmed.toString(),
              color: Colors.blue,
            ),
            StatCard(
              label: 'Active',
              count: country.activeCases.toString(),
              color: Colors.yellow,
            ),
            StatCard(
              label: 'Recovered',
              count: country.totalRecovered.toString(),
              color: Colors.green,
            ),
            StatCard(
              label: 'Critical',
              count: country.totalCritical.toString(),
              color: Colors.orange,
            ),
            StatCard(
              label: 'Deaths',
              count: country.totalDeaths.toString(),
              color: Colors.red,
            ),
            StatCard(
              label: 'Confirmed per million',
              count: country.confirmedPerMillion.toString(),
              color: Colors.deepPurple,
            ),
          ],
        ),
      ],
    );
  }
}
