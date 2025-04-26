import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_garage_final_project/core/utils/app_strings.dart';
import 'package:smart_garage_final_project/core/utils/theme/colors_manager.dart';
import 'package:smart_garage_final_project/core/utils/theme/fonts_manager.dart';

class SignOutWidget extends StatelessWidget {
  const SignOutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: ColorsManager.lightBlack,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppStrings.signOut,
            style: TextStyle(
              color: ColorsManager.white,
              fontSize: 20.sp,
              fontFamily: FontsManager.stinger,
            ),
          ),
          SizedBox(height: 28.h),
          CircularProgressIndicator(color: ColorsManager.authScreenPurple),
        ],
      ),
    );
  }
}
