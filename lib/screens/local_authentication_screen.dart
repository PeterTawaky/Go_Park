import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';
import 'package:smart_garage_final_project/core/routes/app_routes.dart';
import 'package:smart_garage_final_project/core/utils/theme/colors_manager.dart';
import 'package:smart_garage_final_project/core/utils/theme/fonts_manager.dart';
import 'package:smart_garage_final_project/firebase/firebase_auth_consumer.dart';
import 'package:smart_garage_final_project/screens/go_park_screen.dart';

class LocalAuthenticationScreen extends StatefulWidget {
  const LocalAuthenticationScreen({super.key});

  @override
  State<LocalAuthenticationScreen> createState() =>
      _LocalAuthenticationScreenState();
}

class _LocalAuthenticationScreenState extends State<LocalAuthenticationScreen> {
  final LocalAuthentication auth = LocalAuthentication();

  Future<bool?> _activeFingerPrintAuth() async {
    try {
      final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;

      if (canAuthenticateWithBiometrics) {
        bool didAuth = false;

        while (!didAuth) {
          didAuth = await auth.authenticate(
            localizedReason: 'Please authenticate Tawaky',
            options: AuthenticationOptions(
              biometricOnly: true, // Use fingerprint only
              stickyAuth: true, // Prevent authentication dismissal
            ),
          );
        }

        return didAuth;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  _ensureUserValidity() async {
    final bool? userIsValid = await _activeFingerPrintAuth();
    if (userIsValid != null && userIsValid) {
      if (FirebaseAuthConsumer.isUserAuthorized()) {
        context.pushReplacementNamed(AppRoutes.goParkScreen);
      } else {
        context.pushReplacementNamed(AppRoutes.loginScreen);
      }
    }
  }

  @override
  void initState() {
    _ensureUserValidity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: 100,
          alignment: Alignment.center,
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
    );
  }
}
