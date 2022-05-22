import 'package:clubs_preset/app_config.dart';
import 'package:clubs_preset/pages/club_page.dart';
import 'package:clubs_preset/pages/clubs_page.dart';
import 'package:clubs_preset/pages/not_found_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as $material;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:i18n_extension/i18n_widget.dart';

List<Route> routes = [
  Route(
    '/',
    (context) => const ClubsPage(),
  ),
  Route(
    '/clubs/[0-9a-z\\-]+',
    (context) => ClubPage(
      clubId: ModalRoute.of(context)!.settings.name!.split("/")[2],
    ),
  ),
];

class ClubsApp extends StatefulWidget {
  final AppConfig appConfig;

  const ClubsApp({
    Key? key,
    required this.appConfig,
  }) : super(key: key);

  @override
  State<ClubsApp> createState() => _ClubsAppState();
}

class _ClubsAppState extends State<ClubsApp> {
  @override
  void initState() {
    super.initState();
    AppConfig.instance = AppConfig.instance.copyWith(widget.appConfig);
  }

  @override
  Widget build(BuildContext context) {
    return I18n(
      initialLocale: const Locale("de", "DE"),
      child: MaterialApp(
        title: "Clubs",
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale("de", "DE"),
          // Locale("en", "US"),
          // Locale("pl", "PL")
        ],
        onGenerateRoute: onGenerateRoute,
        onUnknownRoute: onUnknownRoute,
        color: AppConfig.instance.primaryColor,
        initialRoute: '/',
        theme: ThemeData(
          primarySwatch: AppConfig.instance.color,
          colorScheme: ThemeData.fallback().colorScheme.copyWith(
                primary: AppConfig.instance.primaryColor,
                onPrimary: Colors.white,
              ),
        ),
      ),
    );
  }
}

$material.Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  Route? foundRoute;
  for (final route in routes) {
    final regExpPattern = RegExp(r'^' + route.pattern + r'$');
    if (regExpPattern.hasMatch(settings.name!)) {
      foundRoute = route;
      break;
    }
  }
  if (foundRoute == null) return null;
  Widget Function(BuildContext) builder = foundRoute.builder;
  return MaterialPageRoute<void>(
    builder: builder,
    settings: settings,
  );
}

$material.Route<dynamic>? onUnknownRoute(RouteSettings settings) =>
    MaterialPageRoute(
      builder: (context) => const NotFoundPage(),
    );

class Route {
  const Route(this.pattern, this.builder);

  final String pattern;
  final WidgetBuilder builder;
}
