import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:gimnasio/src/config/colors.dart';
import 'package:gimnasio/src/domain/model/HistorialTag.dart';
import 'package:google_fonts/google_fonts.dart';

class IngresosPage extends StatelessWidget {
  const IngresosPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Align(
            alignment: Alignment.center,
            child: Text("Mis Ingresos",
                style: GoogleFonts.raleway(
                    color: AppColors.blancoHueso,
                    fontSize: 22,
                    fontWeight: FontWeight.bold)),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("historial")
                .where("tipo", isEqualTo: "ENTRADA")
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData)
                return Center(
                    child: new Text("No existe registro de ninguna Tarjeta "));
              else {
                var list = snapshot.data.docs;
                List<HistorialTag> _tarjetas = [];
                _tarjetas.clear();
                double valor = 0.0;
                double planesActuales = 0.0;
                for (var doc in list) {
                  print(doc.data);
                  HistorialTag tarjeta = HistorialTag.fromMap(doc.data());
                  valor += double.parse(tarjeta.valor.toString());
                  if (tarjeta.plan) {
                    planesActuales += 1.0;
                  }
                  _tarjetas.add(tarjeta);
                }
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                          height: MediaQuery.of(context).size.height * 0.70,
                          width: MediaQuery.of(context).size.width * 0.80,
                          child: FlareActor("assets/cash.flr",
                              alignment: Alignment.center,
                              fit: BoxFit.fill,
                              animation: "cobro")),
                      Text(
                        "El valor ganado  hasta la actualidad es ",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "\$" + valor.toString(),
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                    ],
                  ),
                );
              }
            }));
  }
}
