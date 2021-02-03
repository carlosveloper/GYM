import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gimnasio/src/domain/exception/Failure.dart';
import 'package:gimnasio/src/domain/model/CardTag.dart';
import 'package:gimnasio/src/domain/model/HistorialTag.dart';
import 'package:gimnasio/src/domain/model/Nutrition.dart';
import 'package:gimnasio/src/domain/model/RecargaTag.dart';
import 'package:gimnasio/src/domain/model/Routine.dart';
import 'package:gimnasio/src/domain/model/User.dart';

abstract class ApiRepositoryInterface {
  Future<Either<Failure, UserCredential>> login(String user, String password);

  Future<Either<Failure, bool>> registerCredentials(Usuario user);

  Future<Either<Failure, bool>> registerUser(Usuario user);

  Future<Either<Failure, Usuario>> getProfile(String mail);

  Future<Either<Failure, List<Nutrition>>> getAllNutrition();

  Future<Either<Failure, List<Routine>>> getAllRoutine();

  Future<Either<Failure, String>> uploadImageProfile(File image, String title);

  Future<Either<Failure, List<CardTag>>> getAllCardTag();

  Future<Either<Failure, List<RecargaTag>>> getAllRecargasCardTag();

  Future<Either<Failure, List<Usuario>>> getAllUsers();

  Future<Either<Failure, bool>> updateUserCardTag(
      String idDocument, String correo, String estado);

  Future<Either<Failure, bool>> registerRecargasCardTag(String codTag);

  Future<Either<Failure, bool>> updateRecargaTag(RecargaTag recarga);

  Future<Either<Failure, List<HistorialTag>>> getAllHistorialTag();
}
