import 'package:clubs_preset/app.dart';
import 'package:clubs_preset/app_config.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(
    ClubsApp(
      appConfig: AppConfig(
        baseUrl: "https://public.allaboutapps.at/hiring",
        primaryColor: const Color(0xFFD83931),
      ),
    ),
  );
}
