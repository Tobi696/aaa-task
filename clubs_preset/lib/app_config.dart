import 'package:flutter/material.dart';

class AppConfig {
  static AppConfig instance = AppConfig();

  String? baseUrl;
  Color? primaryColor;

  MaterialColor get color {
    return MaterialColor(primaryColor!.value, {
      50: primaryColor!.withOpacity(0.1),
      100: primaryColor!.withOpacity(0.2),
      200: primaryColor!.withOpacity(0.3),
      300: primaryColor!.withOpacity(0.4),
      400: primaryColor!.withOpacity(0.5),
      500: primaryColor!.withOpacity(0.6),
      600: primaryColor!.withOpacity(0.7),
      700: primaryColor!.withOpacity(0.8),
      800: primaryColor!.withOpacity(0.9),
      900: primaryColor!,
    });
  }

  AppConfig({
    this.baseUrl,
    this.primaryColor,
  });

  AppConfig copyWith(AppConfig other) {
    return AppConfig(
      baseUrl: other.baseUrl ?? baseUrl,
      primaryColor: other.primaryColor ?? primaryColor,
    );
  }
}
