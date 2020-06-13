import 'package:flutter/material.dart';

import '../../styles/styles.dart';
import 'fade_animator.dart';


class SearchBox extends StatelessWidget {
  final Function(String) onChanged;
  final String hintText;
  final EdgeInsets margin;
  final BorderRadiusGeometry borderRadius;

  const SearchBox({
    this.onChanged,
    this.hintText = 'Search',
    this.margin = const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return FadeAnimator(
      child: Container(
        height: 50.0,
        margin: margin,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: AppColors.dark,
          borderRadius: borderRadius ?? BorderRadius.circular(8.0),
        ),
        child: TextFormField(
          onChanged: onChanged,
          maxLines: 1,
          style: AppTextStyles.smallLight,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            prefixIcon: Icon(
              Icons.search,
              size: 20.0,
            ),
          ),
        ),
      ),
    );
  }
}
