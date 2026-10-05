import 'package:flutter/material.dart';

final class AppColors {
  AppColors._();

  // Base
  static const black = Color(0xFF000000);
  static const white = Color(0xFFFFFFFF);
  static const nero = Color(0xFF1F1F1F);
  static const oxfordBlue = Color(0xFF282F39);
  static const gainsboro = Color(0xFFE8E8E8);
  static const nightRider = Color(0xFF303030);
  static const greyBunker = Color(0xFF25282B);
  static const greyChateau = Color(0xFFA0A4A8);

  // Cinzas
  static const grey = Color(0xFFA0A4A8);
  static const gray = Color(0xFF6E6E6E);
  static const hint = Color(0xFF52575C);
  static const arrow = Color(0xFF515755);
  static const disable = Color(0xFF979797);
  static const menu = Color(0xFF454545);
  static const footerBodyText = Color(0xFF454545);

  // Fundos
  static const background = Color(0xFFF4F7FC);
  static const searchBg = Color(0xFFF4F7FC);

  // Marca
  static const appBarHeader = Color(0xFFFC6A57);
  static const footer = Color(0xFFFFDDD9);

  // Bordas e sombras
  static const border = Color(0xFFDCDCDC);
  static const cardShadow = Color(0xFFA7A7A7);

  // Pares claro / escuro (antes dependiam do ThemeProvider)
  static const greyLight = Color(0xFFA0A4A8);
  static const greyDark = Color(0xFF6F7275);

  static const grayLight = Color(0xFF6E6E6E);
  static const grayDarkTheme = Color(0xFF919191);

  static const searchBgLight = Color(0xFFF4F7FC);
  static const searchBgDark = Color(0xFF585A5C);

  static const backgroundLight = Color(0xFFF4F7FC);
  static const backgroundDark = Color(0xFF343636);

  static const hintLight = Color(0xFF52575C);
  static const hintDark = Color(0xFF98A1AB);

  static const greyBunkerLight = Color(0xFF25282B);
  static const greyBunkerDark = Color(0xFFE4E8EC);

  static const cartTitleLight = Color(0xFF000743);
  static const cartTitleDark = Color(0xFF61699B);

  static const cartLight = Color(0xFFFFFFFF);
  static const cartDark = Color(0xFF494949);

  static const categoryHoverLight = Color(0xFFC5DCFA);
  static const categoryHoverDark = Color(0xFF6490EE);

  static const homeSearchBarLight = Color(0xFFE4EAEF);
  static const homeSearchBarDark = Color(0xFFB2B8BD);

  static const textTitleLight = Color(0xFF000000);
  static const textTitleDark = Color(0xFFFFFFFF);

  static const profileMenuHeaderLight = footer;
  static const profileMenuHeaderDark = Color(
    0x80FFDDD9,
  ); // footer com 50% de opacidade

  static const footerLight = Color(0xFFFFDDD9);
  static const footerDark = Color(0xFF494949);

  static const chatAdminLight = Color(0xFFFFDDD9);
  static const chatAdminDark = Color(0xFFA1916C);

  // Swatch
  static const Map<int, Color> swatch = {
    50: Color(0x10192D6B),
    100: Color(0x20192D6B),
    200: Color(0x30192D6B),
    300: Color(0x40192D6B),
    400: Color(0x50192D6B),
    500: Color(0x60192D6B),
    600: Color(0x70192D6B),
    700: Color(0x80192D6B),
    800: Color(0x90192D6B),
    900: Color(0xFF192D6B),
  };

  static const primaryDark = Color(0xFFBA4F41);
  static const scaffoldDark = Color(0xFF2C2C2C);
  static const surfaceDark = Color(0xFF252525);
  static const hintOnDark = Color(0xFFE7F6F8);
  static const focus = Color(0xFFADC4C8);
}
