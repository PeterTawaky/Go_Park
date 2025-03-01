import 'dart:async';
import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:smart_garage_final_project/cached/cache_helper.dart';
import 'package:smart_garage_final_project/components/timer_display_component.dart';
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
  double _price = 0;

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
        _price =
            (timeInSecond * 0.0277777777777778) +
            (timeInMinutes * 1.66666666666667) +
            (timeInHours * 100);
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
                      padding: EdgeInsets.symmetric(vertical: 4.0.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hi, Tawaky!',
                            style: TextStyle(
                              color: ColorsManager.white,
                              fontSize: 28.sp,
                            ),
                          ),
                          // Spacer(),
                          Text(
                            'Where will we go today?',
                            style: TextStyle(
                              color: ColorsManager.grey,
                              fontSize: 14.sp,
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
          TimerDisplayComponent(
            timeInHours: timeInHours,
            timeInMinutes: timeInMinutes,
            timeInSecond: timeInSecond,
          ),
          SizedBox(height: 20.h),
          SizedBox(
            height: height * 0.3,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsetsDirectional.only(start: 20.w),
                    decoration: BoxDecoration(
                      color: ColorsManager.yellow,
                      borderRadius: BorderRadius.circular(32.r),
                    ),
                  ),
                ),
                SizedBox(width: 5.w),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsetsDirectional.only(end: 20.w),

                          alignment: Alignment.center,

                          decoration: BoxDecoration(
                            color: ColorsManager.lightBlack,
                            borderRadius: BorderRadius.circular(32.r),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 5,
                                  bottom: 5,
                                  top: 5,
                                ),
                                child: Container(
                                  height: double.infinity,
                                  width: width * 1.1 / 7,
                                  decoration: BoxDecoration(
                                    color: ColorsManager.white,
                                    borderRadius: BorderRadius.circular(32.r),
                                  ),
                                  child: Icon(Icons.attach_money, size: 35),
                                ),
                              ),

                              Padding(
                                padding: EdgeInsetsDirectional.only(
                                  top: 5.h,
                                  bottom: 15.h,
                                  start: 10.w,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'fees',
                                      style: TextStyle(
                                        color: ColorsManager.grey,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                    Text(
                                      '${_price.floor()}',
                                      style: TextStyle(
                                        color: ColorsManager.white,
                                        fontSize: 32.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Expanded(
                        child: Container(
                          margin: EdgeInsetsDirectional.only(end: 20.w),

                          alignment: Alignment.center,

                          decoration: BoxDecoration(
                            color: ColorsManager.white,
                            borderRadius: BorderRadius.circular(32.r),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Text(
          //   'Total Price: ${_price.floor()} EGP',
          //   style: TextStyle(color: ColorsManager.white, fontSize: 18.sp),
          // ),
          Spacer(),
          Container(
            width: width * 0.35,
            height: 5,
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: ColorsManager.grey,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }
}
