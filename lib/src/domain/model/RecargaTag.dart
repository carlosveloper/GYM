import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class RecargaTag {
  String codigoTag;
  bool plan;
  dynamic valor;
  Timestamp fechaInicio;
  Timestamp fechaFin;
  RecargaTag({
    this.codigoTag,
    this.plan,
    this.valor,
    this.fechaInicio,
    this.fechaFin,
  });

  Map<String, dynamic> toMap() {
    return {
      'codigoTag': codigoTag,
      'plan': plan,
      'valor': valor,
      'fechaInicio': fechaInicio,
      'fechaFin': fechaFin,
    };
  }

  factory RecargaTag.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return RecargaTag(
      codigoTag: map['codigoTag'],
      plan: map['plan'],
      valor: map['valor'],
      fechaInicio: map['fechaInicio'],
      fechaFin: map['fechaFin'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RecargaTag.fromJson(String source) =>
      RecargaTag.fromMap(json.decode(source));
}
