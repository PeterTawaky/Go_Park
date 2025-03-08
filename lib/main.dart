import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_garage_final_project/authentication/local/sceen.dart';
import 'package:smart_garage_final_project/cached/cache_helper.dart';
import 'package:smart_garage_final_project/constants/colors_manager.dart';
import 'package:smart_garage_final_project/screens/splash_screen.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CachedData.cacheInitialization(); //initialize cache

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);  //hide the status bar
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);  //lock the orientation
  runApp(SmartGarage());
}

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
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Smart Garage',
          theme: ThemeData(scaffoldBackgroundColor: ColorsManager.black),
          home: SplashScreen(),
        );
      },
    );
  }
}
