import 'dart:convert';

import 'package:gimnasio/src/domain/model/HistorialTag.dart';

class AgrupacionHistorial {
  HistorialTag entrada;
  HistorialTag salida;
  AgrupacionHistorial({
    this.entrada,
    this.salida,
  });

  Map<String, dynamic> toMap() {
    return {
      'entrada': entrada?.toMap(),
      'salida': salida?.toMap(),
    };
  }

  factory AgrupacionHistorial.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return AgrupacionHistorial(
      entrada: HistorialTag.fromMap(map['entrada']),
      salida: HistorialTag.fromMap(map['salida']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AgrupacionHistorial.fromJson(String source) =>
      AgrupacionHistorial.fromMap(json.decode(source));
}

/* 
 _agrupacionHistorial.clear();

                List<String> tags = [];
                //Filtro los tags
                for (HistorialTag tar in _tarjetasHistorial) {
                  bool encontre = false;
                  for (String lst in tags) {
                    if (lst == tar.codigoTag) {
                      encontre = true;
                    }
                  }
                  if (!encontre) {
                    tags.add(tar.codigoTag);
                  }
                }

                //Agrupo los tags
                _tarjetasHistorialCliente.clear();
                for (String misTags in tags) {
                  for (HistorialTag tar in _tarjetasHistorial) {
                    if (misTags == tar.codigoTag) {
                      print("coincidencia" + misTags);
                      bool encontre = false;
                      for (List<HistorialTag> cliente
                          in _tarjetasHistorialCliente) {
                        if (cliente[0].codigoTag == misTags) {
                          encontre = true;
                          var index =
                              _tarjetasHistorialCliente.indexOf(cliente);
                          _tarjetasHistorialCliente[index].add(tar);
                        }
                      }

                      if (!encontre) {
                        _tarjetasHistorialCliente.add([tar]);
                      }
                    }
                  }
                }

                print("------llllll---");
                print(_tarjetasHistorialCliente[0].length);

/* for (List<HistorialTag> cliente in _tarjetasHistorialCliente) {
                  if (cliente.length % 2 == 0) {
                    for (int i = 0; i < cliente.length; i + 2) {
                      _agrupacionHistorial.add(AgrupacionHistorial(
                          entrada: cliente[i  1], salida: cliente[i]));
                    }
                  } else {}
/* 
                  if(cliente.lç)
                  _agrupacionHistorial.add(
                      AgrupacionHistorial(entrada: entrada, salida: salida)); */
                } */

                for (HistorialTag tar in _tarjetasHistorial) {
                  HistorialTag entrada;
                  HistorialTag salida;

                  if (tar.tipo == "ENTRADA") {
                    entrada = tar;
                    for (HistorialTag tar2 in _tarjetasHistorial) {
                      if (tar2.tipo == "SALIDA" &&
                          tar.codigoTag == tar2.codigoTag) {
                        salida = tar2;
                        // _tarjetasHistorial.remove(salida);
                      }
                    }
                    _agrupacionHistorial.add(
                        AgrupacionHistorial(entrada: entrada, salida: salida));
                  } else if (tar.tipo == "SALIDA") {
                    salida = tar;
                    for (HistorialTag tar2 in _tarjetasHistorial) {
                      if (tar2.tipo == "ENTRADA" &&
                          tar.codigoTag == tar2.codigoTag) {
                        entrada = tar2;
                        // _tarjetasHistorial.remove(entrada);
                      }
                    }
                    _agrupacionHistorial.add(
                        AgrupacionHistorial(entrada: entrada, salida: salida));
                  }
                }
                /* for (int i = 0; i < _tarjetasHistorial.length; i++) {
                  if (i <= _agrupacionHistorial.length) {
                    _agrupacionHistorial[i].salida =
                        _tarjetasHistorialSalidas[i];
                  }

                  if (i <= _agrupacionHistorial.length) {
                    _agrupacionHistorial[i].salida =
                        _tarjetasHistorialSalidas[i];
                  }
                }

                for (int i = 0; i < _tarjetasHistorialSalidas.length; i++) {
                  if (i <= _agrupacionHistorial.length) {
                    _agrupacionHistorial[i].salida =
                        _tarjetasHistorialSalidas[i];
                  }
                } */ */
