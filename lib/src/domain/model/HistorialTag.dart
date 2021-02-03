import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class HistorialTag {
  String codigoTag;
  Timestamp fecha;
  bool plan;
  String tipo;
  dynamic valor;
  HistorialTag({
    this.codigoTag,
    this.fecha,
    this.plan,
    this.tipo,
    this.valor,
  });

  Map<String, dynamic> toMap() {
    return {
      'codigoTag': codigoTag,
      'fecha': fecha,
      'plan': plan,
      'tipo': tipo,
      'valor': valor,
    };
  }

  factory HistorialTag.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return HistorialTag(
      codigoTag: map['codigoTag'],
      fecha: map['fecha'],
      plan: map['plan'],
      tipo: map['tipo'],
      valor: map['valor'],
    );
  }

  String toJson() => json.encode(toMap());

  factory HistorialTag.fromJson(String source) =>
      HistorialTag.fromMap(json.decode(source));
}
