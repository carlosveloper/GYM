import 'dart:convert';

class Peso {
  String descripcion;
  dynamic maximo;
  dynamic minimo;
  String riesgo;
  Peso({
    this.descripcion,
    this.maximo,
    this.minimo,
    this.riesgo,
  });

  Map<String, dynamic> toMap() {
    return {
      'descripcion': descripcion,
      'maximo': maximo,
      'minimo': minimo,
      'riesgo': riesgo,
    };
  }

  factory Peso.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Peso(
      descripcion: map['descripcion'],
      maximo: map['maximo'],
      minimo: map['minimo'],
      riesgo: map['riesgo'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Peso.fromJson(String source) => Peso.fromMap(json.decode(source));
}
