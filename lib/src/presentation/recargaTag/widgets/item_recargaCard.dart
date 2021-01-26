import 'package:flutter/material.dart';
import 'package:gimnasio/src/config/colors.dart';
import 'package:gimnasio/src/domain/model/RecargaTag.dart';
import 'package:gimnasio/src/presentation/common/avatar_assets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ItemRecargaCardTag extends StatelessWidget {
  final RecargaTag miTarjeta;
  const ItemRecargaCardTag({Key key, @required this.miTarjeta})
      : super(key: key);

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
                  Column(
                    children: [
                      Text(
                        "Tarjeta de Membresía",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.raleway(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      if (miTarjeta.plan) ...[
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              convertTimeStampToHumanDate(
                                  miTarjeta.fechaInicio.seconds),
                              style: GoogleFonts.raleway(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              " - " +
                                  convertTimeStampToHumanDate(
                                      miTarjeta.fechaFin.seconds),
                              style: GoogleFonts.raleway(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ],
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
              color: miTarjeta.plan
                  ? AppColors.tituloGold
                  : AppColors.buttonBlueColors,
              height: 35,
              width: double.infinity,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "Saldo: \$" + miTarjeta.valor.toString(),
                    style: GoogleFonts.roboto(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.blancoHueso),
                  ),
                ),
              ),
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
                    miTarjeta.plan ? "PLAN    " : "NORMAL",
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: miTarjeta.plan
                            ? AppColors.tituloGold
                            : AppColors.primary),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String convertTimeStampToHumanDate(int timeStamp) {
    var dateToTimeStamp = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    return DateFormat('dd/MM/yyyy').format(dateToTimeStamp);
  }
}
