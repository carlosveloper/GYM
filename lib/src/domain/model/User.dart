import 'dart:convert';

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

  Usuario({
    this.nombres,
    this.apellidos,
    this.direccion,
    this.celular,
    this.cedula,
    this.correo,
    this.estado,
    this.rol,
  });

  Map<String, dynamic> toMap() {
    return {
      'nombres': nombres,
      'apellidos': apellidos,
      'direccion': direccion,
      'celular': celular,
      'cedula': cedula,
      'correo': correo,
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
    );
  }

  String toJson() => json.encode(toMap());

  factory Usuario.fromJson(String source) =>
      Usuario.fromMap(json.decode(source));
}
