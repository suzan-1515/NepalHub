import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';

import '../../styles/styles.dart';

class StatColumn extends StatelessWidget {
  final String label;
  final int count;
  final Color color;

  const StatColumn({
    @required this.label,
    @required this.count,
    @required this.color,
  })  : assert(label != null),
        assert(count != null),
        assert(color != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: AutoSizeText(
              label,
              textAlign: TextAlign.center,
              style: AppTextStyles.smallLight,
            ),
          ),
          const SizedBox(height: 8.0),
          Flexible(
            child: AutoSizeText(
              count.toString(),
              style: AppTextStyles.largeLight.copyWith(color: color),
            ),
          ),
        ],
      ),
    );
  }
}
