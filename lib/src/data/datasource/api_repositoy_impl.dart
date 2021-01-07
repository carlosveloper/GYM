import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gimnasio/src/domain/exception/Failure.dart';
import 'package:gimnasio/src/domain/exception/auth_exception.dart';
import 'package:gimnasio/src/domain/repository/api_repository.dart';

class ApiRepositoryImpl extends ApiRepositoryInterface {
  @override
  Future<Either<Failure, UserCredential>> login(
      String user, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: "$user", password: "$password");
      return Right(userCredential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return Left(ServerFailure(message: e.code));
    }
  }
}
