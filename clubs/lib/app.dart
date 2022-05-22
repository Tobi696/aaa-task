import 'package:clubs/pages/not_found.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as $material;
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

List<Route> routes = [];
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
    return MaterialApp(
      title: "Clubs",
      onGenerateRoute: onGenerateRoute,
      onUnknownRoute: onUnknownRoute,
      color: primaryColor,
      initialRoute: '/',
      theme: ThemeData(primarySwatch: primaryMaterialColor),
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
      builder: (context) => const NotFound(),
    );

class Route {
  const Route(this.pattern, this.builder);

  final String pattern;
  final WidgetBuilder builder;
}
