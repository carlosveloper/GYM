import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gimnasio/src/domain/exception/Failure.dart';

abstract class ApiRepositoryInterface {
  Future<Either<Failure, UserCredential>> login(String user, String password);
}
