import 'package:flutter/material.dart';

final class AppDimens {
  AppDimens._();

  // Layout
  static const webScreenWidth = 1170.0;

  // Tamanhos de fonte
  static const fontSizeExtraSmall = 10.0;
  static const fontSizeSmall = 12.0;
  static const fontSizeDefault = 14.0;
  static const fontSizeLarge = 16.0;
  static const fontSizeExtraLarge = 18.0;
  static const fontSizeOverLarge = 24.0;

  // Espaçamentos
  static const paddingExtraSmall = 5.0;
  static const paddingSmall = 10.0;
  static const paddingDefault = 15.0;
  static const paddingLarge = 20.0;
  static const paddingExtraLarge = 25.0;

  static const edgeInsetsScreen = EdgeInsets.all(paddingDefault);

  // Raios
  static const radiusSmall = 5.0;
  static const radiusDefault = 10.0;
  static const radiusLarge = 15.0;
  static const radiusExtraLarge = 20.0;

  static const borderRadiusSmall = BorderRadius.all(
    Radius.circular(radiusSmall),
  );
  static const borderRadiusDefault = BorderRadius.all(
    Radius.circular(radiusDefault),
  );
  static const borderRadiusLarge = BorderRadius.all(
    Radius.circular(radiusLarge),
  );
  static const borderRadiusExtraLarge = BorderRadius.all(
    Radius.circular(radiusExtraLarge),
  );

  // Componentes
  static const notificationImageSize = 70.0;

  // Limites
  static const messageInputLength = 250;
}
