import 'dart:convert';

class Routine {
  String dia;
  String ejercicio;
  String foto;
  String recomendacion;
  String salud;
  Routine({
    this.dia,
    this.ejercicio,
    this.foto,
    this.recomendacion,
    this.salud,
  });

  Map<String, dynamic> toMap() {
    return {
      'dia': dia,
      'ejercicio': ejercicio,
      'foto': foto,
      'recomendacion': recomendacion,
      'salud': salud,
    };
  }

  factory Routine.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Routine(
      dia: map['dia'],
      ejercicio: map['ejercicio'],
      foto: map['foto'],
      recomendacion: map['recomendacion'],
      salud: map['salud'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Routine.fromJson(String source) =>
      Routine.fromMap(json.decode(source));
}
