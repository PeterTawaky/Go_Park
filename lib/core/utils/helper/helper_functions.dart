import 'package:flutter/material.dart';
import 'package:smart_garage_final_project/core/utils/theme/colors_manager.dart';

class HelperFunctions {
  static void showSnackBar({
    required String msg,
    required BuildContext context,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: const Duration(seconds: 5),
        backgroundColor: ColorsManager.authScreenGrey,
      ),
    );
  }
}
