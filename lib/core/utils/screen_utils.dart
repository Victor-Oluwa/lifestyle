import 'dart:developer';

import 'package:flutter/material.dart';

class ScreenUtils {
  static late double _screenWidth;
  static late double _screenHeight;

  static void init(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
    log('Screen dimenssion registered');
  }

  static double get screenWidth => _screenWidth;
  static double get screenHeight => _screenHeight;

  static double w(double percent) {
    return _screenWidth * percent;
  }

  static double h(double percent) {
    return _screenHeight * percent;
  }
}
