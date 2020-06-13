import 'package:flutter/material.dart';

import 'icon_indicator.dart';


class EmptyIcon extends StatelessWidget {
  const EmptyIcon();

  @override
  Widget build(BuildContext context) {
    return IconIndicator(
      label: 'Nothing here...',
      imageUrl: 'assets/images/empty.png',
    );
  }
}
