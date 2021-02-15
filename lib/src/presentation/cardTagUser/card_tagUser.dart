import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gimnasio/src/domain/Global.dart';
import 'package:gimnasio/src/domain/model/HistorialTag.dart';
import 'package:gimnasio/src/domain/model/RecargaTag.dart';
import 'package:gimnasio/src/presentation/cardTagUser/widgets/item_card.dart';
import 'package:gimnasio/src/presentation/cardTagUser/widgets/item_recargaCard.dart';

class CardTagUser extends StatelessWidget {
  final String codigoTag;
  const CardTagUser({Key key, @required this.codigoTag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("-------");
    print(codigoTag);
    return Scaffold(
        body: Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("recargotarjeta")
                  .where("codigoTag", isEqualTo: codigoTag)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData)
                  return Center(
                      child:
                          new Text("No existe registro de ninguna Tarjeta "));
                else {
                  var list = snapshot.data.docs;
                  List<RecargaTag> _tarjetas = [];

                  _tarjetas.clear();
                  for (var doc in list) {
                    print(doc.data);
                    RecargaTag tarjeta = RecargaTag.fromMap(doc.data());
                    _tarjetas.add(tarjeta);
                  }
                  return Container(
                    height: 300,
                    child: ListView.builder(
                        itemCount: _tarjetas.length,
                        itemBuilder: (context, i) {
                          return ItemRecargaCardTagUser(
                            miTarjeta: _tarjetas[i],
                          );
                        }),
                  );
                }
              }),
          Divider(),
          Text(
            "Historial de mis registros",
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          Divider(),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("historial")
                  .where("codigoTag", isEqualTo: codigoTag)
                  .orderBy("fecha", descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData)
                  return Center(
                      child:
                          new Text("No existe registro de ninguna Tarjeta "));
                else {
                  var list = snapshot.data.docs;
                  List<HistorialTag> _tarjetas = [];

                  _tarjetas.clear();
                  for (var doc in list) {
                    print(doc.data);
                    HistorialTag tarjeta = HistorialTag.fromMap(doc.data());
                    _tarjetas.add(tarjeta);
                  }
                  return Expanded(
                    child: ListView.builder(
                        itemCount: _tarjetas.length,
                        itemBuilder: (context, i) {
                          return ItemCardHistorialTagUser(
                            miTarjeta: _tarjetas[i],
                            selectedValue: Global.miPerfil,
                          );
                        }),
                  );
                }
              })
        ],
      ),
    ));
  }
}
