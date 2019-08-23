import 'package:flutter/widgets.dart';
import 'package:flutter_auth_base/flutter_auth_base.dart';
import 'package:ezsale/pages/home_page.dart';

Map<String, WidgetBuilder> buildRoutes(AuthService authService) {
  var routes = new Map<String, WidgetBuilder>();

  routes['/home'] = (BuildContext context) => new HomePage();

  return routes;
}

RouteFactory buildGenerator() {
  return null;
}
