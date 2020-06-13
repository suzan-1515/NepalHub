import 'package:flutter/material.dart';

import '../../styles/app_text_styles.dart';


class Label extends StatelessWidget {
  final String text;
  final Color color;

  const Label({
    @required this.text,
    @required this.color,
  })  : assert(text != null),
        assert(color != null);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        CircleAvatar(
          backgroundColor: color,
          radius: 4.0,
        ),
        const SizedBox(width: 8.0),
        Text(
          text,
          style: AppTextStyles.extraSmallLight,
        ),
      ],
    );
  }
}
