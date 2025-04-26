import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_garage_final_project/core/utils/theme/colors_manager.dart';
import 'package:smart_garage_final_project/core/utils/theme/fonts_manager.dart';

class TextStyles {
  static TextStyle font25BoldWhite = TextStyle(
    color: ColorsManager.white,
    fontSize: 25.sp,
    fontWeight: FontWeight.bold,
    fontFamily: FontsManager.poppins,
  );
  static TextStyle font14BoldWhite = TextStyle(
    color: ColorsManager.white,
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
    fontFamily: FontsManager.poppins,
  );
  static TextStyle font14regularWhite = TextStyle(
    color: ColorsManager.authScreenGrey,
    fontSize: 14.sp,
    // fontWeight: FontWeight.w500,
    fontFamily: FontsManager.poppins,
  );
  static TextStyle font12regularGrey = TextStyle(
    color: ColorsManager.authScreenGrey,
    fontSize: 12.sp,
    // fontWeight: FontWeight.w500,
    fontFamily: FontsManager.poppins,
  );
  static TextStyle font12regularPurple = TextStyle(
    color: ColorsManager.authScreenPurple,
    fontSize: 12.sp,
    // fontWeight: FontWeight.w500,
    fontFamily: FontsManager.poppins,
  );
}
