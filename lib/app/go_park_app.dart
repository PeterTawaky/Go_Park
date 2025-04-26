import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_garage_final_project/core/routes/router_generator.dart';
import 'package:smart_garage_final_project/core/utils/theme/app_theme_data.dart';

class SmartGarage extends StatelessWidget {
  const SmartGarage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(
        360,
        690,
      ), //the size of screen that designer work on it on figma
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Smart Garage',
          theme: AppThemeData.darkTheme,
          routerConfig: RouterGenerator.mainRouting,
          // SplashScreen(),
        );
      },
    );
  }
}
