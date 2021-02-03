import 'package:flutter/material.dart';
import 'package:gimnasio/src/config/colors.dart';
import 'package:gimnasio/src/domain/model/HistorialTag.dart';
import 'package:gimnasio/src/domain/model/User.dart';
import 'package:gimnasio/src/presentation/common/avatar.dart';
import 'package:gimnasio/src/presentation/common/avatar_assets.dart';
import 'package:gimnasio/src/provider/CardTagProvider.dart';
import 'package:gimnasio/src/provider/HistorialTagProvider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ItemCardHistorialTag extends StatefulWidget {
  final HistorialTag miTarjeta;
  const ItemCardHistorialTag({Key key, @required this.miTarjeta})
      : super(key: key);

  @override
  _ItemCardHistorialTagState createState() => _ItemCardHistorialTagState();
}

class _ItemCardHistorialTagState extends State<ItemCardHistorialTag> {
  Usuario selectedValue;
  bool _isInitialized; //This is the key

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    HistorialTagProvider appCardTag = context.watch<HistorialTagProvider>();

    if (this._isInitialized == null || !this._isInitialized) {
      // Only execute once
      // appHome.cargarParametrosGenerales();
      Future.delayed(const Duration(milliseconds: 1000), () {
        selectedValue = appCardTag.buscarUsuario(widget.miTarjeta.codigoTag);
        if (selectedValue != null) {
          this._isInitialized = true;
        }
        if (mounted) {
          setState(() {});
        }
      });
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      width: double.infinity,
      height: 230,
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.miTarjeta.tipo,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            DateFormat('dd/MM/yyyy hh:mm:ss')
                                .format(widget.miTarjeta.fecha.toDate()),
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: AppColors.buttonBlueColors,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () async {},
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (selectedValue != null) ...[
                          MyAvatar(
                            size: 80,
                            url: selectedValue.foto,
                          ),
                          Text(
                            selectedValue.nombres,
                            style: GoogleFonts.raleway(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ]
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              color: widget.miTarjeta.plan
                  ? AppColors.tituloGold
                  : AppColors.buttonBlueColors,
              height: 35,
              width: double.infinity,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "Precio: \$" + widget.miTarjeta.valor.toString(),
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
                    "${widget.miTarjeta.codigoTag}",
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
/* 
  
  Future<void> showDialogPresentar(
      context, String idTag, CardTagProvider appCardTag) async {
    Usuario user = appCardTag.buscarUsuario(widget.miTarjeta.usuario);
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Center(
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              ),
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Text(
                  "Tarjeta Asignada ",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    decoration: TextDecoration.none,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                ItemUsuario(user: user),
                SizedBox(
                  width: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    if (widget.miTarjeta.estado != "INACTIVO") ...{
                      Expanded(
                        child: FlatButton(
                            color: Colors.red,
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0)),
                            onPressed: () {
                              appCardTag.inactivarTarjeta(
                                  widget.miTarjeta.idDocumento,
                                  selectedValue.correo,
                                  context);
                            },
                            child: Text(
                              "Inactivar",
                              style: TextStyle(
                                fontSize: 18,
                                decoration: TextDecoration.none,
                                color: Colors.white,
                              ),
                            )),
                      ),
                    },
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: FlatButton(
                          color: Colors.green,
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0)),
                          onPressed: () {
                            appCardTag.reasignarTarjeta(
                                widget.miTarjeta.idDocumento, context);
                          },
                          child: Text(
                            "Reasignar",
                            style: TextStyle(
                              fontSize: 18,
                              decoration: TextDecoration.none,
                              color: Colors.white,
                            ),
                          )),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                  ],
                ),
              ])),
        );
      },
    );
  } */
}
