import 'package:flutter/material.dart';

import '../../../../core/models/hospital.dart';
import '../../../styles/styles.dart';
import 'action_row.dart';
import 'capacity_card.dart';
import 'contact_card.dart';
import 'hospital_info.dart';


class HospitalDetails extends StatelessWidget {
  final Hospital hospital;
  final Color color;

  const HospitalDetails({
    @required this.hospital,
    @required this.color,
  })  : assert(hospital != null),
        assert(color != null);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: <Widget>[
        Text(
          hospital.name,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: AppTextStyles.largeLight,
        ),
        Divider(
          height: 16.0,
          color: AppColors.light.withOpacity(0.2),
        ),
        HospitalInfo(
          hospital: hospital,
          color: color,
        ),
        const SizedBox(height: 16.0),
        ActionRow(
          hospital: hospital,
          color: color,
        ),
        const SizedBox(height: 16.0),
        if (hospital.contactPerson.isNotEmpty)
          ContactCard(
            name: hospital.contactPerson,
            number: hospital.contactPersonNumber,
            color: color,
          ),
        if (!hospital.capacity.isEmpty)
          CapacityCard(
            capacity: hospital.capacity,
          ),
      ],
    );
  }
}
