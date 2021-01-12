import 'dart:async';

class Validators {
  final validarEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);

    if (regExp.hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError('Email no es correcto');
    }
  });

  final validarChat =
      StreamTransformer<String, String>.fromHandlers(handleData: (chat, sink) {
    if (chat.trim().length > 0) {
      sink.add(chat);
    } else {
      sink.addError('');
    }
  });

  /* static bool validaEmail(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);

    if (regExp.hasMatch(email)) {
      return true;
    } else {
      return false;
    }
  } */

  final validarDireccion = StreamTransformer<String, String>.fromHandlers(
      handleData: (direccion, sink) {
    if (direccion.length >= 5) {
      sink.add(direccion);
    } else {
      sink.addError('Asegurate que la dirección sea válida');
    }
  });

  final validarNombres = StreamTransformer<String, String>.fromHandlers(
      handleData: (nombre, sink) {
    Pattern pattern = r'^([a-zA-Z\s]{10,25})$';
    RegExp regExp = new RegExp(pattern);

    if (regExp.hasMatch(nombre)) {
      sink.add(nombre);
    } else {
      sink.addError('Nombres Completos');
    }
  });

  final validarApellidos = StreamTransformer<String, String>.fromHandlers(
      handleData: (apellidos, sink) {
    Pattern pattern = r'^([a-zA-Z\s]{10,25})$';
    RegExp regExp = new RegExp(pattern);

    if (regExp.hasMatch(apellidos)) {
      sink.add(apellidos);
    } else {
      sink.addError('Apellido Paterno y Materno');
    }
  });

  final validarTelefono = StreamTransformer<String, String>.fromHandlers(
      handleData: (telefono, sink) {
    if (telefono.length >= 8) {
      sink.add(telefono);
    } else {
      sink.addError('Asegurate que el telefono sea valido');
    }
  });

  final validarPassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length >= 8) {
      sink.add(password);
    } else {
      sink.addError('Más de 8 caracteres por favor');
    }
  });

  final validarCedula = StreamTransformer<String, String>.fromHandlers(
      handleData: (cedula, sink) {
    if (cedula.length == 10) {
      sink.add(cedula);
    } else {
      sink.addError('Debe tener 10 digitos');
    }
  });
}
