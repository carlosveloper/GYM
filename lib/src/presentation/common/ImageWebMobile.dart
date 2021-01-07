import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gimnasio/src/config/colors.dart';

class ImageWM extends StatelessWidget {
  final iconPath;
  const ImageWM({@required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? Image.asset(
            this.iconPath,
            color: AppColors.buttonBlueColors,
          )
        : SvgPicture.asset(
            this.iconPath,
            color: AppColors.buttonBlueColors,
          );
  }
}
