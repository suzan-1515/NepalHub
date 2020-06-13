import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

import '../../../../core/models/hospital.dart';
import '../../../styles/styles.dart';
import '../../common/icon_row.dart';


class HospitalInfo extends StatelessWidget {
  final Hospital hospital;
  final Color color;

  const HospitalInfo({
    @required this.hospital,
    @required this.color,
  })  : assert(hospital != null),
        assert(color != null);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (hospital.address.isNotEmpty)
            IconRow(
              label: hospital.address.trim(),
              iconData: LineAwesomeIcons.map,
              labelStyle: AppTextStyles.smallLight,
              color: color,
            ),
          if (hospital.phone.isNotEmpty)
            IconRow(
              label: hospital.phone.trim(),
              iconData: LineAwesomeIcons.phone,
              labelStyle: AppTextStyles.smallLight,
              color: color,
            ),
          if (hospital.website.isNotEmpty)
            IconRow(
              label: hospital.website.trim(),
              iconData: LineAwesomeIcons.globe,
              labelStyle: AppTextStyles.smallLight,
              color: color,
            ),
          if (hospital.email.isNotEmpty)
            IconRow(
              label: hospital.email.trim(),
              iconData: LineAwesomeIcons.envelope,
              labelStyle: AppTextStyles.smallLight,
              color: color,
            ),
        ],
      ),
    );
  }
}
