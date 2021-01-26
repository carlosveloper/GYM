import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gimnasio/src/config/colors.dart';
import 'package:gimnasio/src/domain/model/cardTag.dart';
import 'package:gimnasio/src/presentation/cardTag/widgets/item_card.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class CardTagPage extends StatelessWidget {
  CardTagPage({Key key}) : super(key: key);

  List<CardTag> _tarjetas = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Align(
            alignment: Alignment.center,
            child: Text("Mis Tarjetas",
                style: GoogleFonts.raleway(
                    color: AppColors.blancoHueso,
                    fontSize: 22,
                    fontWeight: FontWeight.bold)),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection("tarjetas").snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData)
                return Center(
                    child: new Text("No existe registro de ninguna Tarjeta "));
              else {
                var list = snapshot.data.docs;
                _tarjetas.clear();
                for (var doc in list) {
                  print(doc.data);
                  CardTag tarjeta = CardTag.fromMap(doc.data());
                  if (tarjeta.usuario.isEmpty)
                    tarjeta.isOcupado = false;
                  else
                    tarjeta.isOcupado = true;
                  _tarjetas.add(tarjeta);
                }

                return ListView.builder(
                    itemCount: _tarjetas.length,
                    itemBuilder: (context, i) {
                      return ItemCardTag(
                        miTarjeta: _tarjetas[i],
                      );
                    });
              }
            }));
  }
}
