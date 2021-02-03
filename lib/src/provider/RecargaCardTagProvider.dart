import 'package:flutter/material.dart';
import 'package:gimnasio/src/data/datasource/api_repositoy_impl.dart';
import 'package:gimnasio/src/domain/model/CardTag.dart';
import 'package:gimnasio/src/domain/model/RecargaTag.dart';
import 'package:gimnasio/src/domain/model/User.dart';

class RecargaCardTagProvider extends ApiRepositoryImpl with ChangeNotifier {
  List<RecargaTag> tarjetas = [];
  List<Usuario> misUsuarios = [];
  List<CardTag> tarjetasUsuarios = [];

  load() async {
    //  Text(timeago.format(DateTime.tryParse(timestamp.toDate().toString())).toString());

    var responseCard = await getAllCardTag();
    responseCard.fold((l) => print("fail" + l.getMessageError()), (data) {
      tarjetasUsuarios = data;
    });

    var responseRecargas = await getAllRecargasCardTag();
    responseRecargas.fold((l) => print("fail" + l.getMessageError()), (data) {
      tarjetas = data;
      print("Traje las recargas");
    });

    var responseUsers = await getAllUsers();
    responseUsers.fold((l) => print("fail" + l.getMessageError()), (data) {
      this.misUsuarios = data;
    });
  }

  Usuario buscarUsuarioPorCodTag(String codigoTag) {
    CardTag nuevo =
        tarjetasUsuarios.firstWhere((cod) => cod.codigoTag == codigoTag);

    return misUsuarios.firstWhere((user) => user.correo == nuevo.usuario);
  }

  CardTag buscarCardTag(String codigoTag) {
    return tarjetasUsuarios.firstWhere((cod) => cod.codigoTag == codigoTag);
  }

  recargar(String valor, RecargaTag recargaTag, var context) async {
    Navigator.of(context).pop();
    /* ProgressDialog dialog = ProgressDialog(context);
    dialog.show();
          dialog.dismiss(); */

    var recarga = double.parse(valor);
    recargaTag.valor = recarga + recargaTag.valor;
    var responseUpdate = await updateRecargaTag(recargaTag);
    responseUpdate.fold(
        (l) => print("fail" + l.getMessageError()), (data) async {});
  }
}
