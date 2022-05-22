import 'package:clubs/pages/club_page.dart';
import 'package:clubs/pages/clubs_page.dart';
import 'package:clubs/pages/not_found_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as $material;
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

const primaryColor = Color(0xFF01C13B);
final primaryMaterialColor = MaterialColor(0xFF01C13B, {
  50: primaryColor.withOpacity(0.1),
  100: primaryColor.withOpacity(0.2),
  200: primaryColor.withOpacity(0.3),
  300: primaryColor.withOpacity(0.4),
  400: primaryColor.withOpacity(0.5),
  500: primaryColor.withOpacity(0.6),
  600: primaryColor.withOpacity(0.7),
  700: primaryColor.withOpacity(0.8),
  800: primaryColor.withOpacity(0.9),
  900: primaryColor,
});

class ClubsApp extends StatelessWidget {
  const ClubsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return I18n(
      initialLocale: const Locale("de", "DE"),
      child: MaterialApp(
        title: "Clubs",
        onGenerateRoute: onGenerateRoute,
        onUnknownRoute: onUnknownRoute,
        color: primaryColor,
        initialRoute: '/',
        theme: ThemeData(
          primarySwatch: primaryMaterialColor,
          colorScheme: ThemeData.fallback().colorScheme.copyWith(
                primary: primaryColor,
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
