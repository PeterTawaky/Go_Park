// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:smart_garage_final_project/core/utils/theme/colors_manager.dart';

class CustomCircleIcon extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color circleColor;
  final VoidCallback onTap;
  const CustomCircleIcon({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.onTap,
    this.circleColor =
        ColorsManager.authScreenGrey, //if not set by user put it white
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(shape: BoxShape.circle, color: circleColor),
      child: IconButton(icon: Icon(icon, color: iconColor), onPressed: onTap),
    );
  }
}
