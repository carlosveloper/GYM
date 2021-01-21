import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gimnasio/src/config/colors.dart';

const double padding = 10;

class CustomDialog extends StatefulWidget {
  final String title, descriptions, textButton, img;
  final Function onPressed;

  const CustomDialog(
      {Key key,
      @required this.title,
      @required this.descriptions,
      @required this.textButton,
      @required this.img,
      @required this.onPressed})
      : super(key: key);

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return contentBox(context);
  }

  contentBox(context) {
    var ancho = MediaQuery.of(context).size.width;
    var margenOrizontal = ancho >= 550 ? 90.0 : 20.0;
    var avatarRadius = ancho >= 550 ? 35.0 : 30.0;

    return Center(
      child: Container(
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  left: padding,
                  top: avatarRadius + padding,
                  right: padding,
                  bottom: padding),
              margin: EdgeInsets.only(
                  top: avatarRadius,
                  left: margenOrizontal,
                  right: margenOrizontal),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(padding),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black,
                        offset: Offset(0, 10),
                        blurRadius: 10),
                  ]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.none,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    widget.descriptions,
                    style: TextStyle(
                      fontSize: 14,
                      decoration: TextDecoration.none,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: FlatButton(
                        color: Colors.green,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                        onPressed: widget.onPressed,
                        child: Text(
                          widget.textButton,
                          style: TextStyle(
                            fontSize: 18,
                            decoration: TextDecoration.none,
                            color: Colors.white,
                          ),
                        )),
                  ),
                ],
              ),
            ),
            Positioned(
              left: padding,
              right: padding,
              child: CircleAvatar(
                backgroundColor: AppColors.primary,
                radius: avatarRadius,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: avatarRadius - 1,
                  //  backgroundImage: AssetImage(widget.img),

                  child: ClipRRect(
                      borderRadius:
                          BorderRadius.all(Radius.circular(avatarRadius)),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Image.asset(
                          widget.img,
                          fit: BoxFit.cover,
                        ),
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
