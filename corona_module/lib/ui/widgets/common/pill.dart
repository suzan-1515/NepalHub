import 'package:flutter/material.dart';

import '../../styles/styles.dart';


class Pill extends StatelessWidget {
  const Pill();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6.0),
      height: 5.0,
      width: 32.0,
      decoration: BoxDecoration(
        color: AppColors.light.withOpacity(0.4),
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
  }
}
