import 'package:flutter/material.dart';

class AppColors {
  static final Color primary = Color(0xffFFF5D8);
  static final Color second = Color(0xff7B7C80);

  static final Color background = Color(0xffF4F5FA);
  static final Color buttonColor = Color(0xff23233C);
  static final Color blancoHueso = Color(0xffE1E5E5);

  //Tareas
  static final Color colorSoporte = Color(0xffF44336);
  static final Color colorInstalacion = Color(0xff4CAF50);
  static final Color colorRetiro = Color(0xffffc107);
  static final Color colorInterdepartamental = Color(0xff3f51b5);

  Color _mainColor = Color(0xff024A71);
  Color _mainDarkColor = Color(0xFF22B7CE);
  Color _secondColor = Color(0xFF04526B);

  Color _secondDarkColor = Color(0xFFE7F6F8);
  Color _accentColor = Color(0xFFADC4C8);
  Color _accentDarkColor = Color(0xFFADC4C8);

//metodos
  Color mainColor(double opacity) {
    return this._mainColor.withOpacity(opacity);
  }

  Color secondColor(double opacity) {
    return this._secondColor.withOpacity(opacity);
  }

  Color accentColor(double opacity) {
    return this._accentColor.withOpacity(opacity);
  }

  Color mainDarkColor(double opacity) {
    return this._mainDarkColor.withOpacity(opacity);
  }

  Color secondDarkColor(double opacity) {
    return this._secondDarkColor.withOpacity(opacity);
  }

  Color accentDarkColor(double opacity) {
    return this._accentDarkColor.withOpacity(opacity);
  }
}
