import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

import '../../../../core/services/launcher_service.dart';
import '../../../styles/styles.dart';
import '../../common/fade_animator.dart';
import '../../common/icon_row.dart';
import '../../common/tag.dart';


class ContactCard extends StatelessWidget {
  final String name;
  final String number;
  final Color color;

  const ContactCard({
    @required this.name,
    @required this.number,
    @required this.color,
  })  : assert(name != null),
        assert(number != null),
        assert(color != null);

  @override
  Widget build(BuildContext context) {
    return FadeAnimator(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: AppColors.background.withOpacity(0.25),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'CONTACT',
              style: AppTextStyles.mediumLight,
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: IconRow(
                    label: name,
                    iconData: Icons.account_circle,
                    labelStyle: AppTextStyles.smallLight,
                  ),
                ),
                const SizedBox(width: 10.0),
                Tag(
                  label: number,
                  color: color,
                  iconData: LineAwesomeIcons.phone,
                  onPressed: () async {
                    await context.repository<LauncherService>().launchPhone(context, number);
                  },
                ),
                const SizedBox(width: 10.0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
