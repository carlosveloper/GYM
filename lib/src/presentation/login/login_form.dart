import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gimnasio/src/config/colors.dart';
import 'package:gimnasio/src/domain/Utils.dart';
import 'package:gimnasio/src/domain/responsive.dart';
import 'package:gimnasio/src/presentation/common/ImageWebMobile.dart';
import 'package:gimnasio/src/provider/LoginProvider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatelessWidget {
  final Alignment alignment;

  final VoidCallback onGoToResgister, onGoToForgotPassword;

  const LoginForm(
      {Key key,
      @required this.onGoToResgister,
      @required this.onGoToForgotPassword,
      this.alignment = Alignment.bottomCenter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final usuario = Provider.of<UserProvider>(context, listen: false);
    final login = context.watch<LoginProvider>();

    final Responsive responsive = Responsive.of(context);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xfDED4C7).withOpacity(0.8),
            Colors.white.withOpacity(0.9)
          ],
        ),

        borderRadius: BorderRadius.all(
            Radius.circular(10.0)), // set rounded corner radius
      ),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          /* SizedBox(
            height: responsive.ip(2),
          ), */
          Text(
            "Gym Belgica",
            style: TextStyle(
              color: AppColors.tituloGold,
              fontSize: 40,
              fontWeight: FontWeight.w600,
            ),
          ),
          /* SizedBox(
            height: responsive.ip(2),
          ), */
          inputEmail(login),
          /*  SizedBox(
            height: responsive.ip(2),
          ), */
          inputPassword(login),
          /*  InputTextLogin(
            blocStream: usuario.loginBloc.passwordStream,
            change: usuario.loginBloc.changePassword,
            iconPath: kIsWeb
                ? Global.ipServer + Global.storageImage + "key.svg"
                : 'assets/key.svg',
            placeholder: "Password",
          ), */
          Container(
            padding: EdgeInsets.only(right: 20),
            width: double.infinity,
            alignment: Alignment.centerRight,
            child: CupertinoButton(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Text(
                "Recupera la Contraseña",
                style: TextStyle(fontSize: 20, color: AppColors.tituloGold),
                // style: TextStyle(fontFamily: 'sans'),
              ),
              onPressed: onGoToForgotPassword,
            ),
          ),
          /*  SizedBox(
            height: responsive.ip(2),
          ), */
          _bottonLogin(login),
          /* SizedBox(
            height: responsive.ip(3.3),
          ), */
          SizedBox(
            height: responsive.ip(2),
          ),
          /*  SizedBox(
            height: responsive.ip(1),
          ), */
          /* SizedBox(
            height: responsive.ip(2),
          ), */
          Wrap(
            direction: Axis.horizontal,
            crossAxisAlignment: WrapCrossAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("No tienes una cuenta?",
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                      color: AppColors.buttonBlueColors, fontSize: 20)),
              CupertinoButton(
                child: Text(
                  "Registrate",
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                      // fontFamily: 'sans',
                      color: AppColors.tituloGold,
                      fontSize: 22

                      //   fontWeight: FontWeight.w600,
                      ),
                ),
                onPressed: onGoToResgister,
              )
            ],
          ),
          SizedBox(
            height: responsive.ip(2),
          ),
        ],
      ),
    );
  }

  Widget inputEmail(LoginProvider login) {
    return StreamBuilder(
        stream: login.loginBloc.emailStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          login.errorEmail(snapshot.hasError, snapshot.error.toString());
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(
                  color: snapshot.hasError
                      ? Colors.red.withOpacity(0.5)
                      : Color(0xffcccccc).withOpacity(0.5)),
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
            ),
            child: CupertinoTextField(
                placeholder: "Usuario o Correo",
                suffix: login.loginBloc.email != null && !snapshot.hasError
                    ? Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Icon(
                          Icons.check_circle,
                          color: Colors.green,
                        ),
                      )
                    : null,
                onChanged: login.loginBloc.changeEmail,
                placeholderStyle: TextStyle(

                    //fontFamily: 'sans',
                    color: Color(0xffcccccc)),
                padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                prefix: Container(
                  width: 40,
                  height: 30,
                  padding: EdgeInsets.all(2),
                  child: ImageWM(
                    iconPath: kIsWeb ? 'assets/email.png' : 'assets/email.svg',
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 0.5,
                        color: Color(0xffdddddd),
                      ),
                    ),
                  ),
                )),
          );
        });
  }

  Widget inputPassword(LoginProvider login) {
    return StreamBuilder(
        stream: login.loginBloc.passwordStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          login.errorPassword(snapshot.hasError, snapshot.error.toString());

          return Container(
            decoration: BoxDecoration(
              border: Border.all(
                  color: snapshot.hasError
                      ? Colors.red.withOpacity(0.5)
                      : Color(0xffcccccc).withOpacity(0.5)),
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
            ),
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 40,
            child: CupertinoTextField(
                obscureText: true,
                onChanged: login.loginBloc.changePassword,
                placeholder: "Contraseña",
                suffix: login.loginBloc.password != null && !snapshot.hasError
                    ? Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Icon(
                          Icons.check_circle,
                          color: Colors.green,
                        ),
                      )
                    : null,
                placeholderStyle: TextStyle(

                    //fontFamily: 'sans',
                    color: Color(0xffcccccc)),
                padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                prefix: Container(
                  width: 40,
                  height: 30,
                  padding: EdgeInsets.all(2),
                  child: ImageWM(
                    iconPath: kIsWeb ? 'assets/key.png' : 'assets/key.svg',
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 0.5,
                        color: Color(0xffdddddd),
                      ),
                    ),
                  ),
                )),
          );
        });
  }

  Widget _bottonLogin(LoginProvider login) {
    return StreamBuilder(
      stream: login.loginBloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          height: 45,
          margin: EdgeInsets.symmetric(horizontal: 30),
          width: double.infinity,
          child: RaisedButton(
            color: AppColors.buttonBlueColors,
            textColor: Colors.white,
            elevation: 5.0,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              //mainAxisSize: MainAxisSize.max,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Iniciar',
                    overflow: TextOverflow.fade,
                    style: GoogleFonts.merriweather(
                      textStyle: TextStyle(fontSize: 20.0),
                    )),
              ],
            ),
            onPressed: () async {
              if (snapshot.hasData) {
                login.getLogin();
              } else
                Utils.showInSnackBar(context, login.combinacionDeErroresForm());
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
          ),
        );
      },
    );
  }
}
