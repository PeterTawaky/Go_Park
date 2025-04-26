import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_garage_final_project/core/utils/theme/colors_manager.dart';

class CustomizedCheckbox extends StatefulWidget {
  bool isChecked;
  CustomizedCheckbox({super.key, required this.isChecked});

  @override
  State<CustomizedCheckbox> createState() => _CustomizedCheckboxState();
}

class _CustomizedCheckboxState extends State<CustomizedCheckbox> {

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.4,
      child: Checkbox(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
        activeColor: ColorsManager.authScreenPurple,
        checkColor: ColorsManager.white,
        value: widget.isChecked,
        onChanged: (value) {
          setState(() {
            widget.isChecked = value!;
          });
        },
      ),
    );
  }
}
