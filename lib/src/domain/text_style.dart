import 'package:flutter/material.dart';

class Style {
  static final baseTextStyle = const TextStyle(fontFamily: 'Poppins');
  static final smallTextStyle = commonTextStyle.copyWith(
    fontSize: 20.0,
  );
  static final commonTextStyle = baseTextStyle.copyWith(
      color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w600);

  static final titleTextStyle = baseTextStyle.copyWith(
      color: Colors.white, fontSize: 2.0, fontWeight: FontWeight.w600);

  static final headerTextStyle = baseTextStyle.copyWith(
      color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w400);
}
