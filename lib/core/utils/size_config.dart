import 'package:flutter/material.dart';

extension SizeExtension on BuildContext {
  Size get screenSize => MediaQuery.sizeOf(this);
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;

  double get blockWidth => screenWidth / 100; //1% of screen width
  double get blockHeight => screenHeight / 100; //1% of screen height

  bool get isMobile => screenWidth < 600;
  bool get isTablet => screenWidth >= 600 && screenWidth < 1024;
  bool get isDesktop => screenWidth >= 1024;
}
