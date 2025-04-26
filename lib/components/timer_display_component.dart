import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:smart_garage_final_project/core/utils/theme/colors_manager.dart';

class TimerDisplayComponent extends StatelessWidget {
  const TimerDisplayComponent({
    super.key,
    required this.timeInHours,
    required this.timeInMinutes,
    required this.timeInSecond,
  });

  final int timeInHours;
  final int timeInMinutes;
  final int timeInSecond;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      alignment: Alignment.center,
      margin: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
      width: width,
      height: width * 0.4,
      decoration: BoxDecoration(
        color: ColorsManager.black,
        borderRadius: BorderRadius.circular(32.r),
        boxShadow: [
          BoxShadow(
            // تغميق
            color: Color(0XFF23262A),
            offset: Offset(10, 10),
            blurRadius: 15,
            spreadRadius: 1,
          ),
          BoxShadow(
            //تفتيح
            color: Color(0XFF35393F),
            offset: Offset(-10, -10),
            blurRadius: 15,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(top: 35.h, start: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Timer',
                  style: TextStyle(color: ColorsManager.grey, fontSize: 18.sp),
                ),
                Text(
                  '$timeInHours:$timeInMinutes:$timeInSecond',
                  style: TextStyle(color: ColorsManager.white, fontSize: 34.sp),
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            margin: EdgeInsetsDirectional.only(end: 10.w),
            alignment: Alignment.center,
            width: 150.w,
            height: 130.h,
            decoration: BoxDecoration(
              color: ColorsManager.darkBlue,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: CircularPercentIndicator(
                radius: 65.0.r,
                lineWidth: 16.0.r,
                percent: timeInMinutes / 60,
                center: Container(
                  width: 70.w,
                  height: 70.w,
                  decoration: BoxDecoration(
                    color: ColorsManager.black,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Icon(Icons.bolt, color: ColorsManager.white, size: 38),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Color(0XFF0BDCF7),
                backgroundColor: ColorsManager.blackBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
