import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Welcome extends StatelessWidget {
  final aspectRatio;
  final orientacion;
  const Welcome(
      {Key key, @required this.aspectRatio, @required this.orientacion})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !orientacion ? imagenBienvenida() : imagenBienvenidaVertical();
  }

  Widget imagenBienvenida() {
    /////Horizontal
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: LayoutBuilder(
        builder: (_, contraints) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Lottie.asset(
              "assets/women.json",
              alignment: Alignment.center,
              fit: BoxFit.contain,
            ),
          );
        },
      ),
    );
  }

  Widget imagenBienvenidaVertical() {
    return LayoutBuilder(
      builder: (_, contraints) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.only(bottom: 15),
          child: Lottie.asset(
            "assets/women.json",
            alignment: Alignment.center,
            fit: BoxFit.fill,
          ),
        );
      },
    );
  }
}
