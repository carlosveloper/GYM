import 'package:flutter/material.dart';
import 'package:gimnasio/src/config/colors.dart';
import 'package:gimnasio/src/presentation/recargaTag/widgets/item_recargaCard.dart';
import 'package:gimnasio/src/provider/RecargaCardTagProvider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class RecargaTagPage extends StatelessWidget {
  RecargaTagPage._();

  static ChangeNotifierProvider init() =>
      ChangeNotifierProvider<RecargaCardTagProvider>(
        create: (_) => RecargaCardTagProvider(),
        builder: (_, __) => new RecargaTagPage._(),
      );
  RecargaCardTagProvider appTarjeta;

  @override
  Widget build(BuildContext context) {
    appTarjeta = context.watch<RecargaCardTagProvider>();

    if (appTarjeta.isInitialized == null || !appTarjeta.isInitialized) {
      // Only execute once
      appTarjeta.load(context);
      // appHome.cargarParametrosGenerales();
      appTarjeta.isInitialized =
          true; // Set this to true to prevent next execution using "if()" at this root block
    }

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
        body: Container(
          child: appTarjeta.tarjetas.length > 0
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: appTarjeta.tarjetas.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        margin: EdgeInsets.only(bottom: 12),
                        child: ItemRecargaCardTag(
                          miTarjeta: appTarjeta.tarjetas[index],
                        ));
                    // itemNutrition(nutrition[index]));
                    //
                  })
              : Container(
                  child: Center(
                    child: Text("No existe registro de planes o recargas"),
                  ),
                ),
        ));
  }
}
