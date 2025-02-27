import 'dart:async';
import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:smart_garage_final_project/cached/cache_helper.dart';
import 'package:smart_garage_final_project/constants/app_assets.dart';
import 'package:smart_garage_final_project/constants/colors_manager.dart';
import 'package:smart_garage_final_project/constants/keys_manager.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? imgFile;
  late int timeInSecond;
  late int timeInMinutes;
  late int timeInHours;

  _getImageFromGallery() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      setState(() {
        imgFile = File(pickedImage.path);
      });
      CachedData.setData(
        key: KeysManager.profilePhoto,
        value: pickedImage.path,
      );
    }
  }

  _getImageFromCamera() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (pickedImage != null) {
      setState(() {
        imgFile = File(pickedImage.path);
      });
      CachedData.setData(
        key: KeysManager.profilePhoto,
        value: pickedImage.path,
      );
    }
  }

  _startCount() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (timeInSecond == 59) {
          timeInSecond = 0;
          timeInMinutes++;
          CachedData.setData(
            key: KeysManager.timeInMinutes,
            value: timeInMinutes,
          );
        }
        if (timeInMinutes == 59) {
          timeInMinutes = 0;
          timeInHours++;
          CachedData.setData(key: KeysManager.timeInHours, value: timeInHours);
        }
        CachedData.setData(
          key: KeysManager.timeInSeconds,
          value: timeInSecond++,
        );
      });
    });
  }

  @override
  void initState() {
    if (CachedData.getData(key: KeysManager.profilePhoto) != null) {
      imgFile = File(CachedData.getData(key: KeysManager.profilePhoto));
    }
    timeInSecond = CachedData.getData(key: KeysManager.timeInSeconds) ?? 0;
    timeInMinutes = CachedData.getData(key: KeysManager.timeInMinutes) ?? 0;
    timeInHours = CachedData.getData(key: KeysManager.timeInHours) ?? 0;
    _startCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(20.h),

            height: 80.h,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hi, Tawaky!',
                            style: TextStyle(
                              color: ColorsManager.white,
                              fontSize: 30,
                            ),
                          ),
                          // Spacer(),
                          Text(
                            'Where will we go today?',
                            style: TextStyle(
                              color: ColorsManager.grey,
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Builder(
                      builder: (context) {
                        return GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,

                              builder: (context) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: ColorsManager.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  height: 150.h,
                                  child: Column(
                                    children: [
                                      Container(
                                        width: width * 0.35,
                                        height: 5.h,
                                        margin: EdgeInsets.only(top: 10),
                                        decoration: BoxDecoration(
                                          color: ColorsManager.grey,
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                      ),

                                      ListTile(
                                        title: Text('Camera'),
                                        onTap: () {
                                          _getImageFromCamera();
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        title: Text('Gallery'),
                                        onTap: () {
                                          _getImageFromGallery();
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: ClipOval(
                            child: ConditionalBuilder(
                              condition: imgFile != null,
                              builder:
                                  (context) => Image.file(
                                    imgFile!,
                                    width: 70.w,
                                    height: 80.h,
                                    fit: BoxFit.cover,
                                  ),
                              fallback:
                                  (context) => Image.asset(
                                    Assets
                                        .imagesNnnRemovebgPreview, // Change to your image path
                                    width: 70.w, // Adjust size
                                    height: 80.h,
                                    fit:
                                        BoxFit
                                            .cover, // Ensures the image fills the oval
                                  ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsetsDirectional.symmetric(horizontal: 10.w),
            width: width,
            height: width * 0.5,
            decoration: BoxDecoration(
              color: ColorsManager.darkBlue,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Timer',
                      style: TextStyle(
                        color: ColorsManager.grey,
                        fontSize: 20.sp,
                      ),
                    ),
                    Text(
                      '$timeInHours:$timeInMinutes:$timeInSecond',
                      style: TextStyle(
                        color: ColorsManager.white,
                        fontSize: 34.sp,
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  width: 150.w,
                  height: 150.h,
                  decoration: BoxDecoration(
                    color: ColorsManager.black,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Center(
                    child: CircularPercentIndicator(
                      radius: 60.0,
                      lineWidth: 15.0,
                      percent: timeInMinutes / 60,
                      // center: Text(
                      //   _calculateBmi().toStringAsFixed(2),
                      //   style: TextStyle(
                      //     fontWeight: FontWeight.bold,
                      //     fontSize: 60,
                      //     color: AppColors.blue,
                      //   ),
                      // ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Color(0XFF0BDCF7),
                      backgroundColor: ColorsManager.darkBlue,
                    ),
                  ),
                  // child: Text(
                  //   '$timeInHours:$timeInMinutes:$timeInSecond',
                  //   style: TextStyle(color: ColorsManager.white, fontSize: 64.sp),
                  // ),
                ),
              ],
            ),
          ),
          // Container(
          //   alignment: Alignment.center,
          //   margin: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
          //   width: width,
          //   height: 200.h,
          //   decoration: BoxDecoration(
          //     color: ColorsManager.sky,
          //     borderRadius: BorderRadius.circular(20),
          //   ),
          //   child: Text(
          //     '$timeInHours:$timeInMinutes:$timeInSecond',
          //     style: TextStyle(color: ColorsManager.white, fontSize: 64.sp),
          //   ),
          // ),
          // SizedBox(height: 20.h),
          // ElevatedButton(onPressed: _startCount, child: Text('Start Counting')),
        ],
      ),
    );
  }
}
