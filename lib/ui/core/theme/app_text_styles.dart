import 'package:efood/ui/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final class AppTextStyles._() {
  static TextStyle get rubikRegular {
    return GoogleFonts.rubik(fontSize: AppDimens.fontSizeDefault, fontWeight: FontWeight.w400);
  }

  static TextStyle get rubikMedium {
    return GoogleFonts.rubik(fontSize: AppDimens.fontSizeDefault, fontWeight: FontWeight.w500);
  }

  static TextStyle get rubikBold {
    return GoogleFonts.rubik(fontSize: AppDimens.fontSizeDefault, fontWeight: FontWeight.w700);
  }

  static TextStyle get poppinsRegular {
    return GoogleFonts.poppins(fontSize: AppDimens.fontSizeDefault, fontWeight: FontWeight.w400);
  }

  static TextStyle get robotoRegular {
    return GoogleFonts.roboto(fontSize: AppDimens.fontSizeDefault, fontWeight: FontWeight.w400);
  }

  static TextStyle headline1({Color? color}) {
    return GoogleFonts.rubik(fontWeight: FontWeight.w300, fontSize: AppDimens.fontSizeDefault, color: color);
  }

  static TextStyle headline2({Color? color, double? fontSize = AppDimens.fontSizeDefault}) {
    return GoogleFonts.rubik(fontWeight: FontWeight.w400, fontSize: fontSize, color: color);
  }

  static TextStyle headline3({Color? color, double? fontSize = AppDimens.fontSizeDefault}) {
    return GoogleFonts.rubik(fontWeight: FontWeight.w500, fontSize: fontSize, color: color);
  }

  static TextStyle headline4({Color? color}) {
    return GoogleFonts.rubik(fontWeight: FontWeight.w600, fontSize: AppDimens.fontSizeDefault, color: color);
  }

  static TextStyle headline5({Color? color}) {
    return GoogleFonts.rubik(fontWeight: FontWeight.w700, fontSize: AppDimens.fontSizeDefault, color: color);
  }

  static TextStyle headline6({Color? color}) {
    return GoogleFonts.rubik(fontWeight: FontWeight.w800, fontSize: AppDimens.fontSizeDefault, color: color);
  }

  static TextStyle caption({Color? color}) {
    return GoogleFonts.rubik(fontWeight: FontWeight.w900, fontSize: AppDimens.fontSizeDefault, color: color);
  }

  static TextStyle subtitle1({Color? color}) {
    return GoogleFonts.rubik(fontWeight: FontWeight.w500, fontSize: 15.0, color: color);
  }

  static TextStyle bodyText1({Color? color}) {
    return GoogleFonts.rubik(fontSize: 14.0, fontWeight: FontWeight.w600, color: color);
  }

  static TextStyle bodyText2({Color? color}) {
    return GoogleFonts.rubik(fontSize: 12.0, color: color);
  }
}
