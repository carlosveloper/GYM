import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gimnasio/src/bloc/register_datos_bloc.dart';
import 'package:gimnasio/src/data/datasource/api_repositoy_impl.dart';
import 'package:gimnasio/src/domain/Utils.dart';
import 'package:gimnasio/src/domain/dialogs.dart';
import 'package:gimnasio/src/domain/model/User.dart';

class RegistroUserProvider extends ApiRepositoryImpl with ChangeNotifier {
  var contextRegister;
  load(context) {
    print("carge register");

    contextRegister = context;
  }

  register(RegisterBloc bloc, File imagenPerfil) async {
    print("click register");
    FocusScope.of(contextRegister).requestFocus(FocusNode());

    ProgressDialog dialog = ProgressDialog(contextRegister);
    dialog.show();

    Usuario user = Usuario(
        nombres: bloc.nombres,
        apellidos: bloc.apellidos,
        cedula: bloc.cedula,
        celular: bloc.telefono,
        correo: bloc.email,
        estado: "ACTIVO",
        direccion: bloc.direccion,
        foto: "",
        rol: "CLIENTE",
        fechaCreacion: DateTime.now());

    var responseCreateCredentials = await registerCredentials(user);
    responseCreateCredentials.fold((l) {
      dialog.dismiss();
      Utils.showInSnackBar(contextRegister, l.getMessageError());
    }, (data) async {
      var responseUploadImage =
          await uploadImageProfile(imagenPerfil, user.correo);
      responseUploadImage.fold((l) {
        completeRegister(user);
      }, (urlFoto) async {
        user.foto = urlFoto;
        completeRegister(user);
      });
    });
  }

  Future<void> completeRegister(Usuario user) async {
    var responseRegisterUser = await registerUser(user);

    responseRegisterUser.fold(
        (l) => Utils.showInSnackBar(contextRegister, l.getMessageError()), (r) {
      Navigator.of(contextRegister).pop();
      Utils.dialogGeneric(
          contextRegister, "Registrado", "El usuario fue Creado con exito", () {
        Navigator.of(contextRegister).pop();
        Navigator.of(contextRegister).pop();
      });
    });
  }
}
