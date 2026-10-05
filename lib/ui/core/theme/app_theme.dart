import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_dimens.dart';

final class AppTheme {
  AppTheme._();

  static const _fontFamily = 'Rubik';

  // Esquemas de cor
  static const _lightScheme = ColorScheme.light(
    primary: AppColors.appBarHeader,
    onPrimary: AppColors.white,
    secondary: AppColors.appBarHeader,
    onSecondary: AppColors.white,
    surface: AppColors.white,
    onSurface: AppColors.black,
    onSurfaceVariant: AppColors.hint,
    surfaceContainerLowest: AppColors.background,
    outline: AppColors.border,
  );

  static const _darkScheme = ColorScheme.dark(
    primary: AppColors.primaryDark,
    onPrimary: AppColors.white,
    secondary: AppColors.primaryDark,
    onSecondary: AppColors.white,
    surface: AppColors.surfaceDark,
    onSurface: AppColors.white,
    onSurfaceVariant: AppColors.hintOnDark,
    surfaceContainerLowest: AppColors.backgroundDark,
    outline: AppColors.nightRider,
  );

  // Tipografia (nomes novos do Material 3)
  static const _textTheme = TextTheme(
    displayLarge: TextStyle(
      fontWeight: FontWeight.w300,
      fontSize: AppDimens.fontSizeDefault,
    ), // headline1
    displayMedium: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: AppDimens.fontSizeDefault,
    ), // headline2
    displaySmall: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: AppDimens.fontSizeDefault,
    ), // headline3
    headlineMedium: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: AppDimens.fontSizeDefault,
    ), // headline4
    headlineSmall: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: AppDimens.fontSizeDefault,
    ), // headline5
    titleLarge: TextStyle(
      fontWeight: FontWeight.w800,
      fontSize: AppDimens.fontSizeDefault,
    ), // headline6
    bodySmall: TextStyle(
      fontWeight: FontWeight.w900,
      fontSize: AppDimens.fontSizeDefault,
    ), // caption
    titleMedium: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 15.0,
    ), // subtitle1
    bodyMedium: TextStyle(fontSize: AppDimens.fontSizeSmall), // bodyText2
    bodyLarge: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: AppDimens.fontSizeDefault,
    ), // bodyText1
  );

  static const _pageTransitions = PageTransitionsTheme(
    builders: {
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
      TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
      TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
    },
  );

  static ThemeData _buildTheme({
    required ColorScheme scheme,
    required Color scaffold,
    required Color card,
    required Color hint,
    required Color textButton,
  }) {
    return ThemeData(
      useMaterial3: true,
      fontFamily: _fontFamily,
      brightness: scheme.brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: scaffold,
      cardColor: card,
      hintColor: hint,
      focusColor: AppColors.focus,
      textTheme: _textTheme,
      pageTransitionsTheme: _pageTransitions,
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: textButton),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          disabledBackgroundColor: AppColors.border,
          disabledForegroundColor: AppColors.disable,
          shape: const RoundedRectangleBorder(
            borderRadius: AppDimens.borderRadiusDefault,
          ),
          elevation: 0,
        ),
      ),
    );
  }

  static final light = _buildTheme(
    scheme: _lightScheme,
    scaffold: AppColors.background,
    card: AppColors.white,
    hint: AppColors.hint,
    textButton: AppColors.black,
  );

  static final dark = _buildTheme(
    scheme: _darkScheme,
    scaffold: AppColors.scaffoldDark,
    card: AppColors.surfaceDark,
    hint: AppColors.hintOnDark,
    textButton: AppColors.white,
  );
}
