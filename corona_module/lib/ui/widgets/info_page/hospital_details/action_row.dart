import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/hospital.dart';
import '../../../../core/services/launcher_service.dart';
import '../../common/tag.dart';


class ActionRow extends StatelessWidget {
  final Hospital hospital;
  final Color color;

  const ActionRow({
    @required this.hospital,
    @required this.color,
  })  : assert(hospital != null),
        assert(color != null);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (hospital.phone.isNotEmpty)
          Tag(
            label: 'Call',
            color: color,
            onPressed: () async {
              await context
                  .repository<LauncherService>()
                  .launchPhone(context, hospital.phone);
            },
          ),
        const SizedBox(width: 10.0),
        if (hospital.website.isNotEmpty)
          Tag(
            label: 'Website',
            color: color,
            onPressed: () async {
              await context
                  .repository<LauncherService>()
                  .launchWebsite(context, hospital.website);
            },
          ),
        const SizedBox(width: 10.0),
        if (hospital.email.isNotEmpty)
          Tag(
            label: 'Email',
            color: color,
            onPressed: () async {
              await context
                  .repository<LauncherService>()
                  .launchEmail(context, hospital.email);
            },
          ),
      ],
    );
  }
}
