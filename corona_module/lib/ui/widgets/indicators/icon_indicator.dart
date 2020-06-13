import 'package:flutter/material.dart';

import '../../styles/styles.dart';


class IconIndicator extends StatelessWidget {
  final String label;
  final String imageUrl;

  const IconIndicator({
    @required this.label,
    @required this.imageUrl,
  })  : assert(imageUrl != null),
        assert(label != null);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              imageUrl,
              color: AppColors.dark,
              width: MediaQuery.of(context).size.width * 0.3,
            ),
            const SizedBox(height: 20.0),
            Text(
              label,
              textAlign: TextAlign.center,
              style: AppTextStyles.mediumDark.copyWith(
                color: Colors.white54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
