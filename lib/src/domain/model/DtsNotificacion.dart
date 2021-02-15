import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DtsNotificacion {
  String mensaje;
  String codigoTag;
  DtsNotificacion({
    this.mensaje,
    this.codigoTag,
  });

  Map<String, dynamic> toMap() {
    return {
      'fecha': FontAwesomeIcons.chartPie,
      'mensaje': mensaje,
      'codigoTag': codigoTag,
    };
  }

  factory DtsNotificacion.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return DtsNotificacion(
      mensaje: map['mensaje'],
      codigoTag: map['codigoTag'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DtsNotificacion.fromJson(String source) =>
      DtsNotificacion.fromMap(json.decode(source));
}
