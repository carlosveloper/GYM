import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// Generated by https://quicktype.io

class Usuario {
  String nombres;
  String apellidos;
  String direccion;
  String celular;
  String cedula;
  String correo;
  String estado;
  String rol;
  String foto;
  DateTime fechaCreacion;
  Usuario({
    this.nombres,
    this.apellidos,
    this.direccion,
    this.celular,
    this.cedula,
    this.correo,
    this.estado,
    this.rol,
    this.foto,
    this.fechaCreacion,
  });

  Map<String, dynamic> toMap() {
    return {
      'nombres': nombres,
      'apellidos': apellidos,
      'direccion': direccion,
      'celular': celular,
      'cedula': cedula,
      'correo': correo,
      'estado': estado,
      'rol': rol,
      'foto': foto,
      'fechaCreacion': fechaCreacion?.millisecondsSinceEpoch,
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Usuario(
      nombres: map['nombres'],
      apellidos: map['apellidos'],
      direccion: map['direccion'],
      celular: map['celular'],
      cedula: map['cedula'],
      correo: map['correo'],
      estado: map['estado'],
      rol: map['rol'],
      foto: map['foto'],
      fechaCreacion: dateTimeFromTimestamp(map['fechaCreacion']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Usuario.fromJson(String source) =>
      Usuario.fromMap(json.decode(source));

  @override
  String toString() {
    return '$nombres'.toLowerCase() +
        ' $apellidos'.toLowerCase() +
        ' $cedula'.toLowerCase() +
        ' $correo'.toLowerCase();
  }
}

DateTime dateTimeFromTimestamp(dynamic val) {
  Timestamp timestamp;
  if (val is Timestamp) {
    timestamp = val;
  } else if (val is Map) {
    timestamp = Timestamp(val['_seconds'], val['_nanoseconds']);
  }
  if (timestamp != null) {
    return timestamp.toDate();
  } else {
    print('Unable to parse Timestamp from $val');
    return null;
  }
}
