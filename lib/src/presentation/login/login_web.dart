import 'package:flutter/material.dart';
import 'package:gimnasio/src/domain/responsive.dart';
import 'package:gimnasio/src/presentation/login/login_form.dart';
import 'package:gimnasio/src/presentation/login/widgets/welcome.dart';

class LoginPageWeb extends StatefulWidget {
  @override
  _LoginPageWebState createState() => _LoginPageWebState();
}

class _LoginPageWebState extends State<LoginPageWeb> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Row(
      children: <Widget>[
        Expanded(
          flex: 6,
          child: Container(
            padding: EdgeInsets.only(left: 20),
            height: responsive.height,
            child: Center(
              child: Welcome(
                aspectRatio: 16 / 11,
                orientacion: false,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: SingleChildScrollView(
            child: Container(
              height: responsive.height,
              child: LoginForm(
                  onGoToForgotPassword: () {},
                  onGoToResgister: () {},
                  alignment: Alignment.center),
            ),
          ),
        )
      ],
    );
  }
}
