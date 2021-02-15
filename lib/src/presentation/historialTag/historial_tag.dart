import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gimnasio/src/config/colors.dart';
import 'package:gimnasio/src/domain/model/HistorialTag.dart';
import 'package:gimnasio/src/domain/model/cardTag.dart';
import 'package:gimnasio/src/presentation/cardTag/widgets/item_card.dart';
import 'package:gimnasio/src/presentation/historialTag/widgets/item_card.dart';
import 'package:gimnasio/src/provider/CardTagProvider.dart';
import 'package:gimnasio/src/provider/HistorialTagProvider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class HistorialTagPage extends StatelessWidget {
  HistorialTagPage._();

  static ChangeNotifierProvider init() =>
      ChangeNotifierProvider<HistorialTagProvider>(
        create: (_) => HistorialTagProvider()..load(),
        builder: (_, __) => new HistorialTagPage._(),
      );

  List<HistorialTag> _tarjetas = [];
  @override
  Widget build(BuildContext context) {
    context.watch<HistorialTagProvider>();

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
            stream: FirebaseFirestore.instance
                .collection("historial")
                .orderBy("fecha", descending: true)
                .snapshots(),
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
                  HistorialTag tarjeta = HistorialTag.fromMap(doc.data());
                  _tarjetas.add(tarjeta);
                }

                return ListView.builder(
                    itemCount: _tarjetas.length,
                    itemBuilder: (context, i) {
                      return ItemCardHistorialTag(
                        miTarjeta: _tarjetas[i],
                      );
                    });
              }
            }));
  }
}
