import 'package:flutter/material.dart';
import 'package:gimnasio/src/bloc/login_bloc.dart';
import 'package:gimnasio/src/config/colors.dart';
import 'package:gimnasio/src/data/datasource/api_repositoy_impl.dart';
import 'package:gimnasio/src/domain/Utils.dart';
import 'package:gimnasio/src/domain/dialogs.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginFormType {
  static final int login = 0;
  static final int register = 1;
  static final int forgotPassword = 2;
}

class LoginProvider extends ApiRepositoryImpl with ChangeNotifier {
  LoginBloc loginBloc = LoginBloc();
  LoginBloc recuperaBloc = LoginBloc();
  String mensajeErrorEmail = "";
  String mensajeErrorPassword = "";
  BuildContext contextLogin;

  @override
  void dispose() {
    loginBloc.dispose();
    recuperaBloc.dispose();
    super.dispose();
  }

  combinacionDeErroresForm() {
    return mensajeErrorEmail + "\n" + mensajeErrorPassword;
  }

  errorEmail(bool error, String mensaje) {
    mensajeErrorEmail = loginBloc.email != null
        ? mensaje == "null"
            ? ""
            : mensaje
        : "Email Invalido";
  }

  errorPassword(bool error, String mensaje) {
    mensajeErrorPassword = loginBloc.password != null
        ? mensaje == "null"
            ? ""
            : mensaje
        : "Password Invalido";
  }

  void loadData(BuildContext context) {
    contextLogin = context;
    print("inicio---->");
  }

  getLogin() async {
    ProgressDialog dialog = ProgressDialog(contextLogin);
    dialog.show();
    var responseLogin = await login(loginBloc.email, loginBloc.password);
    dialog.dismiss();

    responseLogin.fold(
        (l) => Utils.showInSnackBar(contextLogin, l.getMessageError()),
        (data) => dirigirRuta("/Home", arguments: data.user.email));
  }

  dirigirRuta(ruta, {Object arguments}) {
    Navigator.of(contextLogin).pushNamedAndRemoveUntil(
        ruta,
        (
          Route<dynamic> route,
        ) =>
            false,
        arguments: arguments);
  }

  void alertOlvide() {
    showDialog(
      context: contextLogin,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          child: Container(
              /*   decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.circular(10.0)), */
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
              child: Container(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 5,
                  ),
                  Text("Se enviara la recuperación a su Correo electronico",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(fontSize: 17.0),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  StreamBuilder(
                    stream: recuperaBloc.emailStream,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return TextField(
                        onChanged: recuperaBloc.changeEmail,
                        decoration: InputDecoration(
                          errorText: snapshot.error,
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                          icon: Icon(
                            Icons.email,
                          ),
                          hintText: 'Correo',
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)),
                            borderSide: BorderSide(width: 1),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  StreamBuilder(
                    stream: recuperaBloc.formValidCambio,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return Container(
                        //color: Colors.red,
                        height: 45,
                        margin: EdgeInsets.only(top: 5),
                        padding: EdgeInsets.symmetric(horizontal: 15),

                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),

                        child: RaisedButton(
                          // color: AppColors.colorAccent,
                          color: AppColors.primary,
                          textColor: Colors.white,
                          elevation: 5.0,
                          //padding: EdgeInsets.only(top: 1.0, bottom: 1.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Enviar',
                                  style: GoogleFonts.merriweather(
                                    textStyle: TextStyle(fontSize: 14.0),
                                  )),
                            ],
                          ),
                          onPressed: () async {
                            if (snapshot.hasData) {
                              var responseProfile =
                                  await recuperarContra(recuperaBloc.email);

                              responseProfile.fold((info) {
                                Navigator.pop(context);
                                Utils.showInSnackBar(
                                    context, info.getMessageError());
                              }, (data) {
                                Navigator.pop(context);
                                Utils.showInSnackBar(context,
                                    "Se envio el Correo para la Recuperación");
                              });
                            } else {
                              Utils.showInSnackBar(context,
                                  "Se requiere el Correo para la Recuperación");
                            }
                          },

                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0)),
                        ),
                      );
                    },
                  )
                ],
              ))),
        );
      },
    );
  }
}
