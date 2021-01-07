import 'package:flutter/material.dart';

class MyAppProvider with ChangeNotifier {
  final navigatorKey = GlobalKey<NavigatorState>();

  loadData() async {}

  dirigirRuta(ruta) {
    final context = navigatorKey.currentState.overlay.context;
    //  Navigator.pushReplacementNamed(context, ruta);
    // Navigator.of(context).pushReplacement(ruta);
    Navigator.of(context)
        .pushNamedAndRemoveUntil(ruta, (Route<dynamic> route) => false);
  }
}
