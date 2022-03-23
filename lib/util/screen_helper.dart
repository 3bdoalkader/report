import 'dart:math';

import 'package:flutter/material.dart';

class ScreenHelper {
  static late double width;
  static late double height;

  ScreenHelper(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
  }

  static double fromWidth(double percent) {
    return width * percent / 100.0;
  }

  static double fromHeight(double percent) {
    return height * percent / 100.0;
  }

  static double getFontSize(double percent) {
    return sqrt(pow(width, 2) + pow(height, 2)) * percent / 100;
  }
}
