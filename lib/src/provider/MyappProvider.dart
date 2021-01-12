import 'package:flutter/material.dart';
import 'package:gimnasio/src/data/datasource/api_repositoy_impl.dart';

class MyAppProvider extends ApiRepositoryImpl with ChangeNotifier {
  final navigatorKey = GlobalKey<NavigatorState>();

  loadData() async {
    /* Usuario user = Usuario(
        nombres: "Desa",
        apellidos: "Desarrollo",
        cedula: "099999999",
        celular: "08888888",
        correo: "desarrollo@gmail.com",
        direccion: "desa",
        estado: "ACTIVO",
        foto: "https://bucket3.glanacion.com/anexos/fotos/67/3256867.jpg",
        rol: "ADMIN",
        fecha: DateTime.now(),
        fechaCreacion: FieldValue.serverTimestamp());

    var responseVehiculo = await registerUser(user);
    responseVehiculo.fold((l) => null, (r) => null); */
  }

  dirigirRuta(ruta) {
    final context = navigatorKey.currentState.overlay.context;
    //  Navigator.pushReplacementNamed(context, ruta);
    // Navigator.of(context).pushReplacement(ruta);
    Navigator.of(context)
        .pushNamedAndRemoveUntil(ruta, (Route<dynamic> route) => false);
  }
}
