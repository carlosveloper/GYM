import 'package:gimnasio/src/presentation/splash/splash.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    print("ruta --->");
    print(settings.name);

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashPage());

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('Pagina No Encontrada Posiblemente este en Desarrollo'),
        ),
      );
    });
  }
}
