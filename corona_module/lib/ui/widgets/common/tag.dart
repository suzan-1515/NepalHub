import 'package:flutter/material.dart';


import '../../styles/styles.dart';
import 'scale_animator.dart';

class Tag extends StatelessWidget {
  final String label;
  final IconData iconData;
  final Color color;
  final VoidCallback onPressed;

  const Tag({
    this.label,
    this.iconData = Icons.arrow_forward,
    this.color = AppColors.primary,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ScaleAnimator(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: color.withOpacity(0.8),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (label != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    label,
                    style: AppTextStyles.extraSmallLight,
                  ),
                ),
              if (iconData != null)
                Icon(
                  iconData,
                  size: 14.0,
                  color: AppColors.light.withOpacity(0.6),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
