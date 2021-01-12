import 'package:flutter/material.dart';
import 'package:gimnasio/src/bloc/login_bloc.dart';
import 'package:gimnasio/src/data/datasource/api_repositoy_impl.dart';
import 'package:gimnasio/src/domain/Utils.dart';
import 'package:gimnasio/src/domain/dialogs.dart';

class LoginFormType {
  static final int login = 0;
  static final int register = 1;
  static final int forgotPassword = 2;
}

class LoginProvider extends ApiRepositoryImpl with ChangeNotifier {
  LoginBloc loginBloc = LoginBloc();
  String mensajeErrorEmail = "";
  String mensajeErrorPassword = "";
  BuildContext contextLogin;

  @override
  void dispose() {
    loginBloc.dispose();
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
}
