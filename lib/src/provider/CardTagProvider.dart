import 'package:flutter/material.dart';
import 'package:gimnasio/src/data/datasource/api_repositoy_impl.dart';
import 'package:gimnasio/src/domain/dialogs.dart';
import 'package:gimnasio/src/domain/model/Progreso.dart';
import 'package:gimnasio/src/domain/model/User.dart';

class CardTagProvider extends ApiRepositoryImpl with ChangeNotifier {
  List<Usuario> misUsuarios = [];

  load() async {
    var responseUsers = await getAllUsers();
    responseUsers.fold((l) => print("fail" + l.getMessageError()), (data) {
      this.misUsuarios = data;
    });
  }

  asignarUsuario(String id, String correo, String codTag, var context) async {
    Navigator.of(context).pop();
    ProgressDialog dialog = ProgressDialog(context);
    dialog.show();
    var responseUpdate = await updateUserCardTag(id, correo, "ASIGNADO");
    responseUpdate.fold((l) => print("fail" + l.getMessageError()),
        (data) async {
      await load();
      registerRecargasCardTag(codTag);
    });
    dialog.dismiss();
  }

  inactivarTarjeta(String id, String correo, var context) async {
    Navigator.of(context).pop();
    ProgressDialog dialog = ProgressDialog(context);
    dialog.show();
    var responseUpdate = await updateUserCardTag(id, correo, "INACTIVO");
    responseUpdate.fold((l) => print("fail" + l.getMessageError()),
        (data) async {
      await load();
    });
    dialog.dismiss();
  }

  reasignarTarjeta(String id, var context) async {
    Navigator.of(context).pop();
    ProgressDialog dialog = ProgressDialog(context);
    dialog.show();
    var responseUpdate = await updateUserCardTag(id, "", "ACTIVO");
    responseUpdate.fold((l) => print("fail" + l.getMessageError()),
        (data) async {
      await load();
    });
    dialog.dismiss();
  }

  Usuario buscarUsuario(String correo) {
    return misUsuarios.firstWhere((user) => user.correo == correo);
  }
}
