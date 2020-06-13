import 'package:flutter/material.dart';

import '../../../core/models/district.dart';
import '../../styles/styles.dart';
import 'covid_case_card.dart';


class DistrictDetails extends StatelessWidget {
  final District district;

  const DistrictDetails({
    @required this.district,
  }) : assert(district != null);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 16.0),
        Text(
          district.title.toUpperCase(),
          style: AppTextStyles.mediumLight.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8.0),
        const Divider(height: 16.0, indent: 32.0, endIndent: 32.0),
        _buildStat(),
        const Divider(height: 16.0, indent: 32.0, endIndent: 32.0),
        const SizedBox(height: 8.0),
        Text(
          'Individual Cases',
          style: AppTextStyles.mediumLight,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        _buildGrid(),
      ],
    );
  }

  Widget _buildStat() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(
              'Province',
              style: AppTextStyles.smallLight,
            ),
            leading: Icon(Icons.map),
            trailing: Text(
              district.province.toString(),
              style: AppTextStyles.mediumLight.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: Text(
              'Confirmed',
              style: AppTextStyles.smallLight,
            ),
            leading: Icon(Icons.local_hospital, color: Colors.red),
            trailing: Text(
              district.cases.length.toString(),
              style: AppTextStyles.mediumLight.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGrid() {
    return Center(
      child: Container(
        height: 320.0,
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
          ),
          padding: const EdgeInsets.all(16.0),
          scrollDirection: Axis.horizontal,
          addAutomaticKeepAlives: true,
          itemCount: district.cases.length,
          itemBuilder: (context, index) {
            return CovidCaseCard(
              covidCase: district.cases[index],
              color: AppColors.accentColors[index % AppColors.accentColors.length],
            );
          },
        ),
      ),
    );
  }
}
