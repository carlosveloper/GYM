import 'package:flutter/material.dart';
import 'package:gimnasio/src/config/colors.dart';
import 'package:gimnasio/src/domain/model/cardTag.dart';
import 'package:gimnasio/src/presentation/common/avatar_assets.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemCardTag extends StatelessWidget {
  final CardTag miTarjeta;
  const ItemCardTag({Key key, @required this.miTarjeta}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      width: double.infinity,
      height: 250,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    "Tarjeta de Membresía",
                    style: GoogleFonts.raleway(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MyAvatarAssets(
                        size: 100,
                        url: "assets/logo.png",
                      ),
                      Text(
                        "Gym Belgica",
                        style: GoogleFonts.raleway(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              color: AppColors.buttonBlueColors,
              height: 30,
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    "Codigo: ",
                    style: GoogleFonts.raleway(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${miTarjeta.codigoTag}",
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                    ),
                  ),
                  Spacer(),
                  Text(
                    miTarjeta.isOcupado ? "OCUPADO" : "ACTIVO",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: miTarjeta.isOcupado
                          ? AppColors.tituloGold
                          : Colors.green,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
