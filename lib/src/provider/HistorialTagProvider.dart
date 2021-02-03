import 'package:flutter/material.dart';
import 'package:gimnasio/src/data/datasource/api_repositoy_impl.dart';
import 'package:gimnasio/src/domain/model/CardTag.dart';
import 'package:gimnasio/src/domain/model/HistorialTag.dart';
import 'package:gimnasio/src/domain/model/User.dart';

class HistorialTagProvider extends ApiRepositoryImpl with ChangeNotifier {
  List<HistorialTag> miHistorial = [];
  List<Usuario> misUsuarios = [];
  List<CardTag> tarjetasUsuarios = [];

  load() async {
    var responseHistorial = await getAllHistorialTag();
    responseHistorial.fold((l) => print("fail" + l.getMessageError()), (data) {
      this.miHistorial = data;
    });

    var responseCard = await getAllCardTag();
    responseCard.fold((l) => print("fail" + l.getMessageError()), (data) {
      tarjetasUsuarios = data;
    });

    var responseUsers = await getAllUsers();
    responseUsers.fold((l) => print("fail" + l.getMessageError()), (data) {
      this.misUsuarios = data;
    });
  }

  Usuario buscarUsuario(String codigoTag) {
    Usuario user;
    CardTag nuevo;
    if (tarjetasUsuarios != null && tarjetasUsuarios.length > 0) {
      nuevo = tarjetasUsuarios.firstWhere((cod) => cod.codigoTag == codigoTag);
    }

    if (misUsuarios != null && misUsuarios.length > 0) {
      user = misUsuarios.firstWhere((user) => user.correo == nuevo.usuario);
    }

    return user;
  }
}
