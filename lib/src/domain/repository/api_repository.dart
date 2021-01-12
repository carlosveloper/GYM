import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gimnasio/src/domain/exception/Failure.dart';
import 'package:gimnasio/src/domain/model/Nutrition.dart';
import 'package:gimnasio/src/domain/model/User.dart';

abstract class ApiRepositoryInterface {
  Future<Either<Failure, UserCredential>> login(String user, String password);

  Future<Either<Failure, bool>> registerUser(Usuario user);

  Future<Either<Failure, Usuario>> getProfile(String mail);

  Future<Either<Failure, List<Nutrition>>> getAllNutrition();
}
