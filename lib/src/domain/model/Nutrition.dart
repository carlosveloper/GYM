import 'dart:convert';

class Nutrition {
  String recomendacion;
  String foto;
  String salud;
  String tipo;
  Nutrition({
    this.recomendacion,
    this.foto,
    this.salud,
    this.tipo,
  });

  Map<String, dynamic> toMap() {
    return {
      'recomendacion': recomendacion,
      'foto': foto,
      'salud': salud,
      'tipo': tipo,
    };
  }

  factory Nutrition.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Nutrition(
      recomendacion: map['recomendacion'],
      foto: map['foto'],
      salud: map['salud'],
      tipo: map['tipo'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Nutrition.fromJson(String source) =>
      Nutrition.fromMap(json.decode(source));
}
