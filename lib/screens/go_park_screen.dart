import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_garage_final_project/constants/app_assets.dart';

import 'package:smart_garage_final_project/constants/colors_manager.dart';
import 'package:smart_garage_final_project/components/slide_action_button.dart';
import 'package:smart_garage_final_project/constants/fonts_manager.dart';

class GoParkingScreen extends StatelessWidget {
  const GoParkingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.imagesCarCover),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsetsDirectional.symmetric(
              horizontal: 8.w,
              vertical: 8.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(top: 20.h),
                    child: Text(
                      'GoPark',
                      style: TextStyle(
                        color: ColorsManager.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: FontsManager.stinger,
                        fontSize: 28.sp,
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 16.w),
                  child: Text.rich(
                    TextSpan(
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w900,
                      ),
                      children: [
                        TextSpan(
                          text: 'MAKE YOUR',
                          style: TextStyle(color: ColorsManager.white),
                        ),
                        TextSpan(
                          text: '\nPARKING ',
                          style: TextStyle(color: ColorsManager.sky),
                        ),
                        TextSpan(
                          text: 'SMART \nAND EASY.',
                          style: TextStyle(color: ColorsManager.white),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                SlideActionButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
