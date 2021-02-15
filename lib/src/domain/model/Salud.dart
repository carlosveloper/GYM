import 'dart:convert';

class Salud {
  String descripcion;
  String nombre;
  Salud({
    this.descripcion,
    this.nombre,
  });

  Map<String, dynamic> toMap() {
    return {
      'descripcion': descripcion,
      'nombre': nombre,
    };
  }

  factory Salud.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Salud(
      descripcion: map['descripcion'],
      nombre: map['nombre'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Salud.fromJson(String source) => Salud.fromMap(json.decode(source));
}
