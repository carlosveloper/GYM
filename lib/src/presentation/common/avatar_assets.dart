import 'package:flutter/material.dart';

class MyAvatarAssets extends StatelessWidget {
  final double size;
  final String url;

  const MyAvatarAssets({Key key, this.size, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: size,
        height: size,
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  url,
                ))));
  }
}
