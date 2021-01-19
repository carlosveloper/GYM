import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gimnasio/src/bloc/register_datos_bloc.dart';
import 'package:gimnasio/src/data/datasource/api_repositoy_impl.dart';
import 'package:gimnasio/src/domain/model/User.dart';

class RegistroUserProvider extends ApiRepositoryImpl with ChangeNotifier {
  load() {}

  register(RegisterBloc bloc, File imagenPerfil) {
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

    print("datos");
    print(user.toJson());
  }
}
