import 'package:flutter/material.dart';

class ResponsiveHelper._() {
  static bool isTab(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    if (size < 1300 && size >= 650) {
      return true;
    }

    return false;
  }
}
