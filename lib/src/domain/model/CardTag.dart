import 'dart:convert';

class CardTag {
  String codigoTag;
  String descripcion;
  String estado;
  String usuario;
  bool isOcupado;

  CardTag({
    this.codigoTag,
    this.descripcion,
    this.estado,
    this.usuario,
    this.isOcupado = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'codigoTag': codigoTag,
      'descripcion': descripcion,
      'estado': estado,
      'usuario': usuario,
    };
  }

  factory CardTag.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CardTag(
      codigoTag: map['codigoTag'],
      descripcion: map['descripcion'],
      estado: map['estado'],
      usuario: map['usuario'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CardTag.fromJson(String source) =>
      CardTag.fromMap(json.decode(source));
}
