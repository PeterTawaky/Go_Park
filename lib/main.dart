import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_garage_final_project/app/go_park_app.dart';
import 'package:smart_garage_final_project/cached/cache_helper.dart';
import 'package:smart_garage_final_project/core/utils/device/device_utility.dart';
import 'package:smart_garage_final_project/firebase/firebase_auth_consumer.dart';
import 'package:smart_garage_final_project/observer/bloc_observer.dart';

void main() async {
  //TODO DI
  WidgetsFlutterBinding.ensureInitialized();
  // setupDI();
  Bloc.observer = MyBlocObserver();
  await CachedData.cacheInitialization(); //initialize cache
  DeviceUtility.firebaseInitialization();
  DeviceUtility.hideStatusBar();
  DeviceUtility.lockOrientation();
  runApp(SmartGarage());
}
