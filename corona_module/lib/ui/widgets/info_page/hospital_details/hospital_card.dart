import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

import '../../../../core/models/hospital.dart';
import '../../../../core/services/launcher_service.dart';
import '../../../styles/styles.dart';
import '../../common/fade_animator.dart';
import '../../common/icon_row.dart';
import '../../common/tag.dart';
import 'hospital_details.dart';


class HospitalCard extends StatelessWidget {
  final Color color;
  final Hospital hospital;

  const HospitalCard({
    @required this.hospital,
    this.color = AppColors.dark,
  }) : assert(hospital != null);

  @override
  Widget build(BuildContext context) {
    return FadeAnimator(
      child: Builder(
        builder: (context) => GestureDetector(
          onTap: () => _openBottomSheet(context),
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: AppColors.dark,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                IconRow(
                  label: hospital.name,
                  iconData: LineAwesomeIcons.hospital_o,
                  labelStyle: AppTextStyles.mediumLight,
                  color: color,
                ),
                IconRow(
                  label: hospital.address.isEmpty ? 'N/A' : hospital.address,
                  iconData: LineAwesomeIcons.map,
                  labelStyle: AppTextStyles.smallLight,
                  color: color,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: IconRow(
                        label: hospital.phone.isEmpty ? 'N/A' : hospital.phone,
                        iconData: LineAwesomeIcons.phone,
                        labelStyle: AppTextStyles.smallLight,
                        color: color,
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    if (hospital.phone.isNotEmpty)
                      Tag(
                        label: 'Call',
                        color: color,
                        iconData: LineAwesomeIcons.phone,
                        onPressed: () async {
                          await context
                              .repository<LauncherService>()
                              .launchPhone(context, hospital.phone);
                        },
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openBottomSheet(BuildContext context) {
    // Forces the keyboard(in search field) to close after card is tapped.
    FocusScope.of(context).unfocus();
    showModalBottomSheet(
      context: context,
      enableDrag: true,
      isScrollControlled: true,
      useRootNavigator: true,
      clipBehavior: Clip.antiAlias,
      elevation: 12.0,
      backgroundColor: AppColors.dark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          child: HospitalDetails(
            hospital: hospital,
            color: color,
          ),
        );
      },
    );
  }
}
