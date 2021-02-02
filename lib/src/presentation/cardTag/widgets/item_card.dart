import 'package:flutter/material.dart';
import 'package:gimnasio/src/config/colors.dart';
import 'package:gimnasio/src/domain/model/User.dart';
import 'package:gimnasio/src/domain/model/cardTag.dart';
import 'package:gimnasio/src/presentation/common/avatar.dart';
import 'package:gimnasio/src/presentation/common/avatar_assets.dart';
import 'package:gimnasio/src/presentation/common/item_usuario.dart';
import 'package:gimnasio/src/provider/CardTagProvider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:provider/provider.dart';

class ItemCardTag extends StatefulWidget {
  final CardTag miTarjeta;
  const ItemCardTag({Key key, @required this.miTarjeta}) : super(key: key);

  @override
  _ItemCardTagState createState() => _ItemCardTagState();
}

class _ItemCardTagState extends State<ItemCardTag> {
  Usuario selectedValue;

  @override
  Widget build(BuildContext context) {
    CardTagProvider appCardTag = context.watch<CardTagProvider>();

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
                  GestureDetector(
                    onTap: () async {
                      if (widget.miTarjeta.isOcupado) {
                        showDialogPresentar(
                            context, widget.miTarjeta.codigoTag, appCardTag);
                      } else {
                        showDialogAsignarTarjeta(
                            context, widget.miTarjeta.codigoTag, appCardTag);
                      }
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
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              color: widget.miTarjeta.estado == "INACTIVO"
                  ? Colors.red
                  : AppColors.buttonBlueColors,
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
                    "${widget.miTarjeta.codigoTag}",
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                    ),
                  ),
                  Spacer(),
                  Text(
                    widget.miTarjeta.estado,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: widget.miTarjeta.estado == "INACTIVO"
                          ? Colors.red
                          : widget.miTarjeta.isOcupado
                              ? Colors.green
                              : AppColors.tituloGold,
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

  void showDialogAsignarTarjeta(
      context, String idTag, CardTagProvider appCardTag) {
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
                  "Asignar Tarjeta",
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
                Text(
                  "COD: " + idTag,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    decoration: TextDecoration.none,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Material(
                        child: SearchableDropdown(
                          hint: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'Seleccione el Usuario a quien  va asignar',
                              textAlign: TextAlign.center,
                            ),
                          ),
                          items: appCardTag.misUsuarios.map((item) {
                            return new DropdownMenuItem<Usuario>(
                              child: ItemUsuario(
                                user: item,
                              ),
                              value: item,
                            );
                          }).toList(),
                          isExpanded: true,
                          value: selectedValue,
                          isCaseSensitiveSearch: true,
                          searchHint: new Text(
                            'Seleccione la Placa ',
                            style: new TextStyle(fontSize: 20),
                          ),
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value;
                              print(selectedValue);
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
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
                    Expanded(
                      child: FlatButton(
                          color: Colors.red,
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0)),
                          onPressed: () {
                            Navigator.of(context).pop();
                            setState(() {
                              selectedValue = null;
                            });
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
                    if (selectedValue != null) ...{
                      Expanded(
                        child: FlatButton(
                            color: Colors.green,
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0)),
                            onPressed: () {
                              appCardTag.asignarUsuario(
                                  widget.miTarjeta.idDocumento,
                                  selectedValue.correo,
                                  widget.miTarjeta.codigoTag,
                                  context);
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
                    },
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
  }
}
