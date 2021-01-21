import 'package:gimnasio/src/presentation/home/home.dart';
import 'package:gimnasio/src/presentation/login/login_page.dart';
import 'package:gimnasio/src/presentation/registerUser/register_user.dart';
import 'package:gimnasio/src/presentation/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:gimnasio/src/presentation/users/users.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    print("ruta --->");
    print(settings.name);

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashPage());
      case '/Login':
        return MaterialPageRoute(builder: (_) => LoginPage.init());
      case '/Home':
        return MaterialPageRoute(builder: (_) => HomePage.init());
      case '/RegistroUser':
        return MaterialPageRoute(builder: (_) => RegistroUser.init());
      case '/Users':
        return MaterialPageRoute(builder: (_) => UsersPage());

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
