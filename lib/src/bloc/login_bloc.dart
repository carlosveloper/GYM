import 'package:gimnasio/src/domain/Validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  // Recuperar los datos del Stream
  Stream<String> get emailStream =>
      _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validarPassword);

  Stream<bool> get formValidStream =>
      CombineLatestStream.combine2(emailStream, passwordStream, (e, p) => true);
  //  CombineLatestStream.combineLatest2(emailStream, passwordStream, (e, p) => true );

  // Insertar valores al Stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  // Obtener el último valor ingresado a los streams
  String get email => _emailController.value;
  String get password => _passwordController.value;

  Stream<bool> get formValidCambio => CombineLatestStream.combine2(
      _emailController, _emailController, (e, p) => true);

  dispose() {
    _emailController?.close();
    _passwordController?.close();
  }
}
