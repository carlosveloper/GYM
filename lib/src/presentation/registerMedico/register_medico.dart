import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gimnasio/src/bloc/register_datos_bloc.dart';
import 'package:gimnasio/src/config/colors.dart';
import 'package:gimnasio/src/domain/Formato.dart';
import 'package:gimnasio/src/domain/Utils.dart';
import 'package:gimnasio/src/domain/model/Salud.dart';
import 'package:gimnasio/src/domain/model/User.dart';
import 'package:gimnasio/src/presentation/common/item_usuario.dart';
import 'package:gimnasio/src/provider/RegistroMedicoProvider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class RegistroMedico extends StatefulWidget {
  RegistroMedico._();

  static ChangeNotifierProvider init() =>
      ChangeNotifierProvider<RegistroMedicoProvider>(
        create: (_) => RegistroMedicoProvider(),
        builder: (_, __) => new RegistroMedico._(),
      );

  @override
  _RegistroMedicoState createState() => _RegistroMedicoState();
}

class _RegistroMedicoState extends State<RegistroMedico> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  RegistroMedicoProvider appUserMedic;
  bool _isInitialized; //This is the key
  String salud = "";
  String rangoEdad;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    appUserMedic = context.watch<RegistroMedicoProvider>();
    if (this._isInitialized == null || !this._isInitialized) {
      // Only execute once
      appUserMedic.load(context);
      // appHome.cargarParametrosGenerales();
      this._isInitialized =
          true; // Set this to true to prevent next execution using "if()" at this root block
    }
    return Scaffold(
      backgroundColor: AppColors.primary,
      key: _scaffoldKey,
      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
          child: Text("Registro Medico Usuario",
              style: GoogleFonts.raleway(
                  color: AppColors.blancoHueso,
                  fontSize: 22,
                  fontWeight: FontWeight.bold)),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Container(
                        width: double.infinity,
                        color: AppColors.primary,
                        child: Material(
                          child: SearchableDropdown(
                            hint: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                'Seleccione el Usuario a quien  va asignar',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            items: appUserMedic.misUsuarios.map((item) {
                              return new DropdownMenuItem<Usuario>(
                                child: ItemUsuario(
                                  user: item,
                                ),
                                value: item,
                              );
                            }).toList(),
                            isExpanded: true,
                            value: appUserMedic.selectUser,
                            dialogBox: true,
                            isCaseSensitiveSearch: true,
                            searchHint: new Text(
                              'Seleccione el usuario ',
                              style: new TextStyle(fontSize: 20),
                            ),
                            onChanged: (Usuario value) {
                              print(value);
                              appUserMedic.selectUserMedic(value);
                            },
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Container(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Positioned(
                    top: MediaQuery.of(context).size.height * 0.18,
                    left: 0,
                    right: 0,
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: MediaQuery.of(context).size.width - 50,
                        child: Card(
                          //  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.60,
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.55,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      _datosSalud(),
                                      _inputEdad(),
                                      _inputPeso(),
                                      _inputEstatura(),
                                      _inputTipo(),
                                      _bottonSiguiente(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _datosSalud() {
    return appUserMedic.datosSalud.length > 0
        ? DropdownButtonHideUnderline(
            child: DropdownButton(
              isExpanded: true,
              hint: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Selecciona el tipo de Salud"),
              ),
              items: appUserMedic.datosSalud.map((Salud dropDownStringItem) {
                return DropdownMenuItem<String>(
                  value: dropDownStringItem.nombre,
                  child: Center(
                    child: Container(
                        child: Text(
                      dropDownStringItem.nombre,
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                    )),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  salud = value;
                });
              },
              value: salud.isNotEmpty ? salud : null,
            ),
          )
        : Container();
  }

  Widget _inputTipo() {
    return Text(appUserMedic.seleccionadoPeso != null
        ? appUserMedic.seleccionadoPeso.descripcion
        : "Debe agregar la Edad , el Peso y la Estatura del Cliente");
  }

  Widget _inputEstatura() {
    return Container(
      child: TextFormField(
        onChanged: (value) {
          appUserMedic.estaturaElegida(value);
        },
        keyboardType: TextInputType.number,
        inputFormatters: [DecimalTextInputFormatter(decimalRange: 2)],
        autofocus: false,
        decoration: InputDecoration(
          hintText: "Estatura",
          contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
          prefixIcon: Icon(FontAwesomeIcons.userAlt,
              size: 20, color: AppColors.primary),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            borderSide: BorderSide(color: AppColors.primary, width: 1),
          ),
        ),
      ),
    );
  }

  Widget _inputPeso() {
    return Container(
      child: TextFormField(
        onChanged: (value) {
          appUserMedic.pesoElegido(value);
        },
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        inputFormatters: <TextInputFormatter>[
          DecimalTextInputFormatter(decimalRange: 2)
        ],
        autofocus: false,
        decoration: InputDecoration(
          hintText: "Peso",
          contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
          prefixIcon:
              Icon(FontAwesomeIcons.weight, size: 20, color: AppColors.primary),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            borderSide: BorderSide(color: AppColors.primary, width: 1),
          ),
        ),
      ),
    );
  }

  Widget _inputEdad() {
    return Container(
      child: TextFormField(
        onChanged: (value) {
          try {
            if (int.parse(value) >= 18 && int.parse(value) <= 64) {
              rangoEdad = null;
              appUserMedic.edadElegida(value);
            } else {
              setState(() {
                rangoEdad = "El rango de edad es minimo de 18 a 64 años";
              });
            }
          } catch (e) {}
        },
        keyboardType: TextInputType.numberWithOptions(decimal: false),
        autofocus: false,
        decoration: InputDecoration(
          hintText: "Edad",
          errorText: rangoEdad,
          contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
          prefixIcon:
              Icon(FontAwesomeIcons.userFriends, color: AppColors.primary),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            borderSide: BorderSide(color: AppColors.primary, width: 1),
          ),
        ),
      ),
    );
  }

  Widget _bottonSiguiente() {
    return RaisedButton(
      color: AppColors.primary,
      textColor: Colors.white,
      elevation: 5.0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Registro',
              style: GoogleFonts.merriweather(
                textStyle: TextStyle(fontSize: 14.0),
              )),
        ],
      ),
      onPressed: () {
        if (appUserMedic.pesoCliente != null &&
            (salud != null && salud.isNotEmpty) &&
            appUserMedic.selectUser != null) {
          appUserMedic.register(salud);
        } else {
          Utils.showInSnackBar(context, "Todos los Campos son Requeridos");
        }
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    );
  }
}

class CustomRangeTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text == '')
      return TextEditingValue();
    else if (int.parse(newValue.text) < 1)
      return TextEditingValue().copyWith(text: '1');

    return int.parse(newValue.text) > 20
        ? TextEditingValue().copyWith(text: '20')
        : newValue;
  }
}
