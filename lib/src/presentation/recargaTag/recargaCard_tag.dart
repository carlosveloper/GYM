import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gimnasio/src/config/colors.dart';
import 'package:gimnasio/src/domain/model/RecargaTag.dart';
import 'package:gimnasio/src/presentation/recargaTag/widgets/item_recargaCard.dart';
import 'package:gimnasio/src/provider/RecargaCardTagProvider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class RecargaTagPage extends StatelessWidget {
  RecargaTagPage._();

  static ChangeNotifierProvider init() =>
      ChangeNotifierProvider<RecargaCardTagProvider>(
        create: (_) => RecargaCardTagProvider()..load(),
        builder: (_, __) => new RecargaTagPage._(),
      );
  RecargaCardTagProvider appTarjeta;

  List<RecargaTag> _tarjetas = [];

  @override
  Widget build(BuildContext context) {
    appTarjeta = context.watch<RecargaCardTagProvider>();

    return Scaffold(
        appBar: AppBar(
          title: Align(
            alignment: Alignment.center,
            child: Text("Planes y Recargas",
                style: GoogleFonts.raleway(
                    color: AppColors.blancoHueso,
                    fontSize: 22,
                    fontWeight: FontWeight.bold)),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("recargotarjeta")
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
                  RecargaTag tarjeta = RecargaTag.fromMap(doc.data());
                  _tarjetas.add(tarjeta);
                }
                return ListView.builder(
                    itemCount: _tarjetas.length,
                    itemBuilder: (context, i) {
                      return ItemRecargaCardTag(
                        miTarjeta: _tarjetas[i],
                      );
                    });
              }
            }));
  }
}
