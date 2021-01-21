import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gimnasio/src/bloc/register_datos_bloc.dart';
import 'package:gimnasio/src/config/colors.dart';
import 'package:gimnasio/src/domain/Utils.dart';
import 'package:gimnasio/src/provider/RegistroUserProvider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class RegistroUser extends StatefulWidget {
  RegistroUser._();

  static ChangeNotifierProvider init() =>
      ChangeNotifierProvider<RegistroUserProvider>(
        create: (_) => RegistroUserProvider(),
        builder: (_, __) => new RegistroUser._(),
      );

  @override
  _RegistroUserState createState() => _RegistroUserState();
}

class _RegistroUserState extends State<RegistroUser> {
  File imagenPerfil;
  RegisterBloc bloc = RegisterBloc();
  Country _selected = Country.EC;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  RegistroUserProvider appUser = null;

  @override
  void initState() {
    super.initState();

    bloc.changecodigoPais(_selected);
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    appUser = context.watch<RegistroUserProvider>();
    appUser.load(context);
    return Scaffold(
      backgroundColor: AppColors.primary,
      key: _scaffoldKey,
      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
          child: Text("Registro Datos Usuario",
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
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: InkWell(
                            onTap: () async {
                              print('Click Profile Pic');

                              _showChoiceDialog(context);
                              // Navigator.of(context).pop();
                            },
                            child: Container(
                              height: double.infinity,
                              margin: EdgeInsets.only(bottom: 15),
                              child: Center(
                                child: imagenPerfil == null
                                    ? Container(
                                        width: 125.0,
                                        height: 125.0,
                                        decoration: new BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: new DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                  "https://thumbs.dreamstime.com/b/hombre-con-pesas-de-gimnasia-gr%C3%A1fico-del-avatar-de-la-historieta-73242601.jpg",
                                                ))))
                                    : Container(
                                        width: 125.0,
                                        height: 125.0,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image:
                                                    FileImage(imagenPerfil)))),
                              ),
                            ),
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
                                      _email(),
                                      _inputNombres(),
                                      _inputApellidos(),
                                      _inputCedula(),
                                      _telefono(),
                                      _inputDireccion(),
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

  Widget _email() {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return TextFormField(
          onChanged: bloc.changeEmail,
          keyboardType: TextInputType.emailAddress,
          autofocus: false,
          decoration: InputDecoration(
            errorText: snapshot.error,
            hintText: 'Email',
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
            prefixIcon: Icon(Icons.email, color: AppColors.primary),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              borderSide: BorderSide(color: AppColors.primary, width: 1),
            ),
          ),
        );
      },
    );
  }

  Widget _inputNombres() {
    return StreamBuilder(
      stream: bloc.nombresStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          child: TextFormField(
            onChanged: bloc.changeNombres,
            keyboardType: TextInputType.emailAddress,
            autofocus: false,
            decoration: InputDecoration(
              errorText: snapshot.error,
              hintText: "Nombres",
              contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
              prefixIcon: Icon(Icons.person, color: AppColors.primary),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                borderSide: BorderSide(color: AppColors.primary, width: 1),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _inputApellidos() {
    return StreamBuilder(
      stream: bloc.apellidosStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          child: TextFormField(
            onChanged: bloc.changeApellidos,
            keyboardType: TextInputType.emailAddress,
            autofocus: false,
            decoration: InputDecoration(
              errorText: snapshot.error,
              hintText: "Apellidos",
              contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
              prefixIcon: Icon(FontAwesomeIcons.peopleArrows,
                  size: 20, color: AppColors.primary),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                borderSide: BorderSide(color: AppColors.primary, width: 1),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _inputCedula() {
    return StreamBuilder(
      stream: bloc.cedulaStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          child: TextFormField(
            onChanged: bloc.changeCedula,
            keyboardType: TextInputType.phone,
            autofocus: false,
            decoration: InputDecoration(
              errorText: snapshot.error,
              hintText: "Cédula",
              contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
              prefixIcon: Icon(FontAwesomeIcons.addressCard,
                  size: 20, color: AppColors.primary),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                borderSide: BorderSide(color: AppColors.primary, width: 1),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _telefono() {
    return StreamBuilder(
      stream: bloc.telefonoStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          child: TextFormField(
            onChanged: bloc.changeTelefono,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.phone,
            autofocus: false,
            decoration: InputDecoration(
              errorText: snapshot.error,
              hintText: "Telefono",
              contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
              prefixIcon: Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: CountryPicker(
                  dense: false,
                  showFlag: true, //displays flag, true by default
                  showDialingCode:
                      true, //displays dialing code, false by default
                  showName: false, //displays country name, true by default
                  showCurrency: false, //eg. 'British pound'
                  showCurrencyISO: false,
                  onChanged: (Country country) {
                    print(country.name);
                    print(country.dialingCode);
                    bloc.changecodigoPais(country);
                    setState(() {
                      _selected = country;
                    });
                  },
                  selectedCountry: _selected,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                borderSide: BorderSide(color: AppColors.primary, width: 1),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _inputDireccion() {
    return StreamBuilder(
      stream: bloc.direccionStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          child: TextFormField(
            onChanged: bloc.changeDireccion,
            keyboardType: TextInputType.streetAddress,
            autofocus: false,
            decoration: InputDecoration(
              errorText: snapshot.error,
              hintText: "Direccion",
              contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
              prefixIcon:
                  Icon(Icons.location_searching, color: AppColors.primary),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                borderSide: BorderSide(color: AppColors.primary, width: 1),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _bottonSiguiente() {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          //color: Colors.red,
          height: 45,
          margin: EdgeInsets.only(top: 5),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: RaisedButton(
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
              if (snapshot.hasData && imagenPerfil != null) {
                appUser.register(bloc, imagenPerfil);
              } else {
                Utils.showInSnackBar(
                    context, "Todos los Campos son Requeridos");
              }
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
          ),
        );
      },
    );
  }

  _openGallery(BuildContext context) async {
    final picker = ImagePicker();

    var picture = await picker.getImage(source: ImageSource.gallery);
    if (picture != null) {
      this.setState(() {
        imagenPerfil = File(picture.path);
      });
    }

    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    final picker = ImagePicker();

    var picture = await picker.getImage(source: ImageSource.camera);
    if (picture != null) {
      this.setState(() {
        imagenPerfil = File(picture.path);
      });
    }

    Navigator.of(context).pop();
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Seleccione"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Galeria"),
                    onTap: () {
                      _openGallery(context);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                    child: Text("Camara"),
                    onTap: () {
                      _openCamera(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }
}
