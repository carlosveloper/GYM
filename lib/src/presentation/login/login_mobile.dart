import 'package:flutter/material.dart';
import 'package:gimnasio/src/domain/responsive.dart';
import 'package:gimnasio/src/presentation/login/login_form.dart';
import 'package:gimnasio/src/presentation/login/widgets/welcome.dart';

class LoginPageMobile extends StatefulWidget {
  @override
  _LoginPageMobileState createState() => _LoginPageMobileState();
}

class _LoginPageMobileState extends State<LoginPageMobile> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return SingleChildScrollView(
      child: Container(
        height: responsive.height,
        child: /* FormLogin() */
            Column(
          children: <Widget>[
            Expanded(
              flex: 6,
              child: Container(
                // margin: EdgeInsets.symmetric(horizontal: kIsWeb ? 25 : 0),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: LoginForm(
                    onGoToForgotPassword: () {},
                    onGoToResgister: () {},
                    alignment: Alignment.center),
              ),
            ),
            Expanded(
              flex: 4,
              child: Welcome(
                orientacion: true,
                aspectRatio: 1 / 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
