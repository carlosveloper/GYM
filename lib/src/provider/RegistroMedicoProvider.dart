import 'package:flutter/material.dart';
import 'package:gimnasio/src/data/datasource/api_repositoy_impl.dart';
import 'package:gimnasio/src/domain/Utils.dart';
import 'package:gimnasio/src/domain/dialogs.dart';
import 'package:gimnasio/src/domain/model/Medic.dart';
import 'package:gimnasio/src/domain/model/Peso.dart';
import 'package:gimnasio/src/domain/model/Salud.dart';
import 'package:gimnasio/src/domain/model/User.dart';

class RegistroMedicoProvider extends ApiRepositoryImpl with ChangeNotifier {
  var contextRegister;
  List<Usuario> misUsuarios = [];
  List<Salud> datosSalud = [];
  List<Peso> datosPesos = [];
  double pesoCliente, edadCliente;
  double estaturaCliente;

  Peso seleccionadoPeso;
  Usuario selectUser;
  load(context) async {
    print("carge register medico");
    contextRegister = context;
    var responseUsers = await getAllUsers();
    responseUsers.fold((l) => print("fail" + l.getMessageError()), (data) {
      this.misUsuarios = data;
      notifyListeners();
    });

    var responseSalud = await getAllSalud();
    responseSalud.fold((l) => print("fail" + l.getMessageError()), (data) {
      this.datosSalud = data;
      notifyListeners();
    });

    var responsePesos = await getAllPeso();
    responsePesos.fold((l) => print("fail" + l.getMessageError()), (data) {
      this.datosPesos = data;
      notifyListeners();
    });
  }

  void selectUserMedic(Usuario user) {
    print("cambio al user");
    selectUser = user;
    notifyListeners();
  }

  void pesoElegido(String peso) {
    if (peso.isNotEmpty) {
      double miPeso = double.parse(peso);
      pesoCliente = miPeso;
      datosIMC();
    } else {
      seleccionadoPeso = null;
    }

    notifyListeners();
  }

  void estaturaElegida(String estatura) {
    if (estatura.isNotEmpty) {
      double miEstatura = double.parse(estatura);
      estaturaCliente = miEstatura;
      datosIMC();
    } else {
      seleccionadoPeso = null;
    }
    notifyListeners();
  }

  void edadElegida(String edad) {
    if (edad.isNotEmpty) {
      double miEdad = double.parse(edad);
      edadCliente = miEdad;
      datosIMC();
    } else {
      seleccionadoPeso = null;
    }
    notifyListeners();
  }

  void datosIMC() {
    if (pesoCliente != null &&
        estaturaCliente != null &&
        edadCliente != null &&
        pesoCliente > 0.0 &&
        estaturaCliente > 0.0 &&
        edadCliente > 0.0) {
      double imc = pesoCliente / (estaturaCliente * estaturaCliente);
      for (Peso pes in datosPesos) {
        if (imc >= pes.minimo && imc <= pes.maximo) {
          seleccionadoPeso = pes;
        }
      }
    } else {
      seleccionadoPeso = null;
    }
  }

  Future<void> register(String salud) async {
    FocusScope.of(contextRegister).requestFocus(FocusNode());

    ProgressDialog dialog = ProgressDialog(contextRegister);
    dialog.show();
    Medic user = Medic(
      salud: salud,
      altura: estaturaCliente,
      correo: selectUser.correo,
      edad: edadCliente,
      peso: pesoCliente,
    );

    var responseRegisterUser = await registerMedic(user);
    responseRegisterUser.fold(
        (l) => Utils.showInSnackBar(contextRegister, l.getMessageError()), (r) {
      Navigator.of(contextRegister).pop();
      Utils.dialogGeneric(
          contextRegister,
          "Registrado",
          "Los datos  medicos para " +
              selectUser.correo +
              " fueron regisrtrado con exito", () {
        Navigator.of(contextRegister).pop();
        Navigator.of(contextRegister).pop();
      });
    });
  }
}
