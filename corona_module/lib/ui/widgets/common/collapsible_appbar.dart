import 'package:flutter/material.dart';

import '../../styles/app_colors.dart';
import '../../styles/app_text_styles.dart';


class CollapsibleAppBar extends StatelessWidget {
  final String title;
  final String imageUrl;
  final double elevation;

  const CollapsibleAppBar({
    @required this.title,
    @required this.imageUrl,
    this.elevation = 8.0,
  })  : assert(title != null),
        assert(imageUrl != null);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.background,
      pinned: true,
      centerTitle: true,
      elevation: elevation,
      expandedHeight: 140.0,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        titlePadding: const EdgeInsets.all(16.0),
        centerTitle: true,
        title: Text(
          title,
          style: AppTextStyles.extraLargeLight,
        ),
        background: Padding(
          padding: const EdgeInsets.only(left: 60.0, right: 60.0, top: 20.0),
          child: Image.asset(
            imageUrl,
            color: AppColors.dark,
            alignment: Alignment.centerRight,
            package: 'corona_module',
          ),
        ),
      ),
    );
  }
}
