import 'package:gimnasio/src/domain/Validators.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc with Validators {
  final _nombresController = BehaviorSubject<String>();
  final _apellidosController = BehaviorSubject<String>();
  final _codigoPaisController = BehaviorSubject<Country>();
  final _telefonoController = BehaviorSubject<String>();
  final _cedulaController = BehaviorSubject<String>();
  final _direccionController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();

  // Recuperar los datos del Stream

  Stream<String> get emailStream =>
      _emailController.stream.transform(validarEmail);

  Stream<String> get nombresStream =>
      _nombresController.stream.transform(validarNombres);
  Stream<String> get apellidosStream =>
      _apellidosController.stream.transform(validarApellidos);

  Stream<String> get telefonoStream =>
      _telefonoController.stream.transform(validarTelefono);

  Stream<String> get cedulaStream => _cedulaController.transform(validarCedula);

  Stream<Country> get codigoPaisStream => _codigoPaisController.stream;

  Stream<String> get direccionStream =>
      _direccionController.stream.transform(validarDireccion);

  Stream<bool> get formValidStream => CombineLatestStream.combine5(
      nombresStream,
      apellidosStream,
      telefonoStream,
      cedulaStream,
      direccionStream,
      (n, a, t, c, d) => true);

  //  CombineLatestStream.combineLatest2(emailStream, passwordStream, (e, p) => true );

  // Insertar valores al Stream
  Function(String) get changeEmail => _emailController.sink.add;

  Function(String) get changeNombres => _nombresController.sink.add;
  Function(String) get changeApellidos => _apellidosController.sink.add;
  Function(Country) get changecodigoPais => _codigoPaisController.sink.add;
  Function(String) get changeTelefono => _telefonoController.sink.add;
  Function(String) get changeCedula => _cedulaController.sink.add;
  Function(String) get changeDireccion => _direccionController.sink.add;

  // Obtener el último valor ingresado a los streams
  String get email => _emailController.value;
  String get nombres => _nombresController.value;
  String get apellidos => _apellidosController.value;
  Country get codigoPais => _codigoPaisController.value;
  String get telefono => _telefonoController.value;
  String get cedula => _cedulaController.value;
  String get direccion => _direccionController.value;

  String get telefonoConcodigo {
    if (_telefonoController.value.substring(0, 1) == "0") {
      return _codigoPaisController.value.copyWith().dialingCode.toString() +
          _telefonoController.value.substring(1);
    }
    return _codigoPaisController.value.copyWith().dialingCode.toString() +
        _telefonoController.value;
  }

  dispose() {
    _emailController?.close();
    _nombresController?.close();
    _apellidosController?.close();
    _codigoPaisController?.close();
    _telefonoController?.close();
    _cedulaController?.close();
    _direccionController?.close();
  }
}
