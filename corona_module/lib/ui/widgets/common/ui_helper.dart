import 'package:flutter/material.dart';

import '../../styles/styles.dart';


class UiHelper {
  static void showMessage(BuildContext context, String msg) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: AppTextStyles.mediumLight,
        ),
        backgroundColor: AppColors.primary,
        duration: const Duration(milliseconds: 600),
      ),
    );
  }
}
