import 'package:flutter/material.dart';

import 'icon_indicator.dart';


class ErrorIcon extends StatelessWidget {
  final String message;

  const ErrorIcon({
    this.message = 'An error has occured!',
  });

  @override
  Widget build(BuildContext context) {
    return IconIndicator(
      label: message,
      imageUrl: 'lib/assets/images/error.png',
    );
  }
}
