import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_garage_final_project/core/routes/app_routes.dart';
import 'package:smart_garage_final_project/logic/cubits/authentication_cubit/authentication_cubit.dart';
import 'package:smart_garage_final_project/login_screen.dart';
import 'package:smart_garage_final_project/screens/create_account_screen.dart';
import 'package:smart_garage_final_project/screens/go_park_screen.dart';
import 'package:smart_garage_final_project/screens/local_authentication_screen.dart';
import 'package:smart_garage_final_project/screens/profile_screen.dart';
import 'package:smart_garage_final_project/screens/splash_screen.dart';

class RouterGenerator {
  static GoRouter mainRouting = GoRouter(
    initialLocation: AppRoutes.splashScreen,

    errorBuilder: (context, state) {
      return Scaffold(body: Center(child: Text('No Router for this app')));
    },
    routes: [
      GoRoute(
        name: AppRoutes.loginScreen,
        path: AppRoutes.loginScreen,
        builder:
            (context, state) => BlocProvider<AuthenticationCubit>(
              create: (context) => AuthenticationCubit(),
              child: LoginScreen(),
            ),
      ),
      GoRoute(
        name: AppRoutes.createAccountScreen,
        path: AppRoutes.createAccountScreen,
        builder: (context, state) {
          return BlocProvider<AuthenticationCubit>(
            create: (context) => AuthenticationCubit(),
            child: CreateAccountScreen(),
          );
        },
      ),
      GoRoute(
        name: AppRoutes.splashScreen,
        path: AppRoutes.splashScreen,
        builder: (context, state) => SplashScreen(),
      ),
      GoRoute(
        name: AppRoutes.goParkScreen,
        path: AppRoutes.goParkScreen,
        builder:
            (context, state) => BlocProvider<AuthenticationCubit>(
              create: (context) => AuthenticationCubit(),
              child: GoParkingScreen(),
            ),
      ),
      GoRoute(
        name: AppRoutes.profileScreen,
        path: AppRoutes.profileScreen,
        builder: (context, state) => ProfileScreen(),
      ),
      GoRoute(
        name: AppRoutes.localAuthenticationScreen,
        path: AppRoutes.localAuthenticationScreen,
        builder: (context, state) => LocalAuthenticationScreen(),
      ),
    ],
  );
}
