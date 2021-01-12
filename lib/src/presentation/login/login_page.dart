import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gimnasio/src/presentation/login/login_mobile.dart';
import 'package:gimnasio/src/presentation/login/login_web.dart';
import 'package:gimnasio/src/provider/LoginProvider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage._();
  static ChangeNotifierProvider init() => ChangeNotifierProvider<LoginProvider>(
        create: (_) => LoginProvider(),
        builder: (_, __) => LoginPage._(),
      );

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with AfterLayoutMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  }

  @override
  void afterFirstLayout(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.shortestSide >= 600;
    if (!isTablet) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final login = context.watch<LoginProvider>();
    login.loadData(context);

    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            decoration: new BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                  Color(0xffFCF3E8),
                  Color(0xff024A71),
                  Color(0xFF04526B)
                ],
                    stops: [
                  0.01,
                  0.5,
                  0.9
                ],
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter)),
            width: double.infinity,
            height: double.infinity,
            child: OrientationBuilder(
              builder: (_, Orientation orientation) {
                if (orientation == Orientation.portrait) {
                  return LoginPageMobile();
                } else if (orientation == Orientation.landscape &&
                    MediaQuery.of(context).size.width > 500) {
                  return LoginPageWeb();
                } else {
                  return LoginPageMobile();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
