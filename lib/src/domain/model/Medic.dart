import 'dart:convert';

class Medic {
  String correo;
  String salud;
  double edad;
  double peso;
  double altura;
  Medic({
    this.correo,
    this.salud,
    this.edad,
    this.peso,
    this.altura,
  });

  Map<String, dynamic> toMap() {
    return {
      'correo': correo,
      'salud': salud,
      'edad': edad,
      'peso': peso,
      'altura': altura,
    };
  }

  factory Medic.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Medic(
      correo: map['correo'],
      salud: map['salud'],
      edad: map['edad'],
      peso: map['peso'],
      altura: map['altura'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Medic.fromJson(String source) => Medic.fromMap(json.decode(source));
}
