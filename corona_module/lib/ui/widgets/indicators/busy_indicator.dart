import 'package:flutter/material.dart';

import 'package:loading_indicator/loading_indicator.dart';

import '../../styles/styles.dart';

class BusyIndicator extends StatelessWidget {
  const BusyIndicator();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: SizedBox(
          width: 44.0,
          height: 44.0,
          child: LoadingIndicator(
            indicatorType: Indicator.orbit,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}
