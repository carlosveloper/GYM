import 'package:flutter/material.dart';

class Utils {
  static showInSnackBar(context, mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(mensaje),
      duration: Duration(seconds: 5),
      /* action: SnackBarAction(
          label: 'ACTION',
          onPressed: () { },
        ), */
    ));
  }
}
