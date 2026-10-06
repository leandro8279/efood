import 'package:efood/ui/core/theme/theme.dart';
import 'package:flutter/material.dart';

final class AppTheme._() {
  static const _darkColorScheme = ColorScheme(
    brightness: Brightness.dark,

    // Cor de marca (a mesma do AppBar no tema claro)
    primary: AppColors.appBarHeader, // APPBAR_HEADER_COL0R
    onPrimary: AppColors.white, // COLOR_WHITE
    // Azul usado em categorias/carrinho
    secondary: AppColors.categoryHoverDark, // getCategoryHoverColor (dark)
    onSecondary: AppColors.white,

    tertiary: AppColors.chatAdminDark, // getChatAdminColor (dark)
    onTertiary: AppColors.white,

    error: Color(0xFFCF6679), // não existe no arquivo, valor padrão do Material dark
    onError: Color(0xFF000000),

    surface: AppColors.backgroundDark, // getBackgroundColor (dark)
    onSurface: AppColors.white, // getTextTitleColor (dark)
    onSurfaceVariant: AppColors.hintDark, // getHintColor (dark)

    surfaceContainerLowest: Color(0xFF2B2D2D), // um tom abaixo do surface
    surfaceContainerHigh: AppColors.footerDark, // getCartColor / getFooterColor (dark)

    outline: AppColors.greyDark, // getGreyColor (dark)
    outlineVariant: AppColors.searchBgDark, // getSearchBg (dark)
  );

  static final _textTheme = TextTheme(
    displayLarge: AppTextStyles.headline1(), // headline1
    displayMedium: AppTextStyles.headline2(), // headline2
    displaySmall: AppTextStyles.headline3(), // headline3
    headlineMedium: AppTextStyles.headline4(), // headline4
    headlineSmall: AppTextStyles.headline5(), // headline5
    titleLarge: AppTextStyles.headline6(), // headline6
    bodySmall: AppTextStyles.caption(), // caption
    titleMedium: AppTextStyles.subtitle1(), // subtitle1
    bodyLarge: AppTextStyles.bodyText1(), // bodyText1
    bodyMedium: AppTextStyles.bodyText2(), // bodyText2
  );

  static var dark = ThemeData(
    colorScheme: _darkColorScheme,
    primaryColor: AppColors.primaryDark,
    scaffoldBackgroundColor: AppColors.scaffoldDark,
    cardColor: AppColors.surfaceDark,
    hintColor: AppColors.hintOnDark,
    focusColor: AppColors.focus,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        textStyle: TextStyle(color: Colors.white),
      ),
    ),
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
        TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
        TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
      },
    ),
    textTheme: _textTheme,
  );
}
