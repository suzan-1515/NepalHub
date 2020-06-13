import 'package:flutter/material.dart';

import '../../../../core/models/capacity.dart';
import '../../../styles/styles.dart';
import '../../common/stat_card.dart';


class CapacityCard extends StatelessWidget {
  final Capacity capacity;
  final Color bgColor = AppColors.background.withOpacity(0.25);

  CapacityCard({
    @required this.capacity,
  }) : assert(capacity != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'CAPACITY',
            style: AppTextStyles.mediumLight,
          ),
        ),
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            if (capacity.beds.isNotEmpty)
              StatCard(
                label: 'Beds',
                count: capacity.beds,
                color: AppColors.accentColors[1],
                backgroundColor: bgColor,
              ),
            if (capacity.ventilators.isNotEmpty)
              StatCard(
                label: 'Ventilators',
                count: capacity.ventilators,
                color: AppColors.accentColors[0],
                backgroundColor: bgColor,
              ),
            if (capacity.isolationBeds.isNotEmpty)
              StatCard(
                label: 'Isolation Beds',
                count: capacity.isolationBeds,
                color: AppColors.accentColors[3],
                backgroundColor: bgColor,
              ),
            if (capacity.occupiedBeds.isNotEmpty)
              StatCard(
                label: 'Occupied Beds',
                count: capacity.occupiedBeds,
                color: AppColors.accentColors[4],
                backgroundColor: bgColor,
              ),
            if (capacity.doctors.isNotEmpty)
              StatCard(
                label: 'Doctors',
                count: capacity.doctors,
                color: AppColors.accentColors[6],
                backgroundColor: bgColor,
              ),
            if (capacity.nurses.isNotEmpty)
              StatCard(
                label: 'Nurses',
                count: capacity.nurses,
                color: AppColors.accentColors[7],
                backgroundColor: bgColor,
              ),
          ],
        ),
      ],
    );
  }
}
