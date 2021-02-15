import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gimnasio/src/config/colors.dart';
import 'package:gimnasio/src/domain/Formato.dart';
import 'package:gimnasio/src/domain/model/RecargaTag.dart';
import 'package:gimnasio/src/domain/model/User.dart';
import 'package:gimnasio/src/presentation/common/avatar_assets.dart';
import 'package:gimnasio/src/presentation/common/item_usuario.dart';
import 'package:gimnasio/src/provider/RecargaCardTagProvider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ItemRecargaCardTagUser extends StatefulWidget {
  final RecargaTag miTarjeta;
  const ItemRecargaCardTagUser({Key key, @required this.miTarjeta})
      : super(key: key);

  @override
  _ItemRecargaCardTagUserState createState() => _ItemRecargaCardTagUserState();
}

class _ItemRecargaCardTagUserState extends State<ItemRecargaCardTagUser> {
  List<String> plan = ["Recarga", "Plan"];
  String itemSeleccionado;
  String nuevoValor;
  String fechaInicio = "Fecha Inicio";
  String fechaFin = "Fecha Fin";
  bool cancelar = false;
  DateTime inicio, fin;

  @override
  void initState() {
    super.initState();

    if (widget.miTarjeta.plan) {
      inicio = widget.miTarjeta.fechaInicio.toDate();
      fin = widget.miTarjeta.fechaFin.toDate();
      String formattedDate = DateFormat('dd/MM/yyyy').format(inicio);

      fechaInicio = formattedDate.toString();
      formattedDate = DateFormat('dd/MM/yyyy').format(fin);
      fechaFin = formattedDate.toString();
    }
  }

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
                      if (widget.miTarjeta.plan) ...[
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              convertTimeStampToHumanDate(
                                  widget.miTarjeta.fechaInicio.seconds),
                              style: GoogleFonts.raleway(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              " - " +
                                  convertTimeStampToHumanDate(
                                      widget.miTarjeta.fechaFin.seconds),
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
                    "Saldo: \$" + widget.miTarjeta.valor.toString(),
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
                  Spacer(),
                  Text(
                    widget.miTarjeta.plan ? "PLAN    " : "NORMAL",
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: widget.miTarjeta.plan
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

  Future<void> showDialogPresentar(context, RecargaCardTagProvider appCardTag,
      {bool plan = false}) async {
    Usuario user =
        appCardTag.buscarUsuarioPorCodTag(widget.miTarjeta.codigoTag);
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Center(
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                  ),
                  child:
                      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
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
                    ItemUsuario(
                      user: user,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    if (!plan) ...{
                      editValue(),
                    },
                    if (plan) ...{
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: FlatButton(
                                  color: AppColors.tituloGris,
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(10.0)),
                                  onPressed: () async {
                                    inicio = await calendar();

                                    if (inicio != null) {
                                      setState(() {
                                        String formattedDate =
                                            DateFormat('dd/MM/yyyy')
                                                .format(inicio);
                                        fechaInicio = formattedDate.toString();
                                      });
                                    }
                                  },
                                  child: Text(
                                    fechaInicio,
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
                            Expanded(
                              child: FlatButton(
                                  color: AppColors.tituloGris,
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(10.0)),
                                  onPressed: () async {
                                    fin = await calendar();
                                    if (fin != null) {
                                      setState(() {
                                        String formattedDate =
                                            DateFormat('dd/MM/yyyy')
                                                .format(fin);
                                        fechaFin = formattedDate.toString();
                                      });
                                    }
                                  },
                                  child: Text(
                                    fechaFin,
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
                      ),
                    },
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: FlatButton(
                              color: Colors.red,
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(10.0)),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "Cancelar",
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
                        Expanded(
                          child: FlatButton(
                              color: Colors.green,
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(10.0)),
                              onPressed: () {
                                if (plan) {
                                  RecargaTag nuevo = widget.miTarjeta;
                                  if (inicio != null) {
                                    nuevo.fechaInicio =
                                        Timestamp.fromDate(inicio);
                                  }
                                  if (fin != null) {
                                    nuevo.fechaFin = Timestamp.fromDate(fin);
                                  }
                                  nuevo.plan = true;
                                  appCardTag.recargar(
                                      "0.0", widget.miTarjeta, context);
                                } else {
                                  appCardTag.recargar(
                                      nuevoValor, widget.miTarjeta, context);
                                }
                              },
                              child: Text(
                                "Confirmar",
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
      },
    );
  }

  Widget editValue() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Material(
        child: TextField(
          decoration: new InputDecoration(labelText: "Valor de Recarga"),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          //  : TextInputType.number,
          inputFormatters: [DecimalTextInputFormatter(decimalRange: 2)],
          onChanged: (n) {
            nuevoValor = n;
            if (n.length > 0) {
              setState(() {
                cancelar = true;
              });
            } else {
              setState(() {
                cancelar = false;
              });
            }
          },
        ),
      ),
    );
  }

  Future<DateTime> calendar() async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 356)),
      builder: (context, child) {
        return Center(child: child);

        /* Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Container(
                  height: 450,
                  width: 700,
                  child: child,
                ),
              ),
            ],
          ),
        ); */
      },
    );

    return picked;
  }
}
