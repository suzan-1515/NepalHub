import 'package:flutter/material.dart';

import 'icon_indicator.dart';


class FinishedIcon extends StatelessWidget {
  const FinishedIcon();

  @override
  Widget build(BuildContext context) {
    return IconIndicator(
      label: "That's it for now.",
      imageUrl: 'lib/assets/images/finished.png',
    );
  }
}
