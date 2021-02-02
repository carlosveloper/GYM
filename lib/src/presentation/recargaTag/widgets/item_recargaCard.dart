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
import 'package:searchable_dropdown/searchable_dropdown.dart';

class ItemRecargaCardTag extends StatefulWidget {
  final RecargaTag miTarjeta;
  const ItemRecargaCardTag({Key key, @required this.miTarjeta})
      : super(key: key);

  @override
  _ItemRecargaCardTagState createState() => _ItemRecargaCardTagState();
}

class _ItemRecargaCardTagState extends State<ItemRecargaCardTag> {
  List<String> plan = ["Recarga", "Plan"];
  String itemSeleccionado;
  String nuevoValor;
  bool cancelar = false;
  @override
  Widget build(BuildContext context) {
    RecargaCardTagProvider appCardTag = context.watch<RecargaCardTagProvider>();

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
                  GestureDetector(
                    onTap: () {
                      showDialogPresentar(context, appCardTag);
                    },
                    child: Column(
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

  Future<void> showDialogPresentar(
      context, RecargaCardTagProvider appCardTag) async {
    Usuario user =
        appCardTag.buscarUsuarioPorCodTag(widget.miTarjeta.codigoTag);
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
                ItemUsuario(
                  user: user,
                ),
                SizedBox(
                  width: 5,
                ),
                /*   Row(
                  children: [
                    Expanded(
                      child: Material(
                        child: SearchableDropdown(
                          hint: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'Seleccione el tipo de Activación',
                              textAlign: TextAlign.center,
                            ),
                          ),
                          items: plan.map((item) {
                            return new DropdownMenuItem<String>(
                              child: Container(
                                width: double.infinity,
                                child: Text(
                                  item,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              value: item,
                            );
                          }).toList(),
                          isExpanded: true,
                          value: itemSeleccionado,
                          isCaseSensitiveSearch: true,
                          searchHint: new Text(
                            'Seleccione el tipo de Recarga',
                            style: new TextStyle(fontSize: 20),
                          ),
                          onChanged: (value) {
                            setState(() {
                              itemSeleccionado = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                if (itemSeleccionado != null &&
                    itemSeleccionado == "Recarga") ...{
                  editValue(),
                }, */
                editValue(),
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
                              borderRadius: new BorderRadius.circular(10.0)),
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
                              borderRadius: new BorderRadius.circular(10.0)),
                          onPressed: () {
                            appCardTag.recargar(nuevoValor, widget.miTarjeta);
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
}
