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
}
