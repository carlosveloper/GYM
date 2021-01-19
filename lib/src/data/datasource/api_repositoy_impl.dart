import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:gimnasio/src/domain/exception/Failure.dart';
import 'package:gimnasio/src/domain/model/Nutrition.dart';
import 'package:gimnasio/src/domain/model/Routine.dart';
import 'package:gimnasio/src/domain/model/User.dart';
import 'package:gimnasio/src/domain/repository/api_repository.dart';

class ApiRepositoryImpl implements ApiRepositoryInterface {
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

  @override
  Future<Either<Failure, bool>> registerUser(Usuario user) async {
    try {
      await FirebaseFirestore.instance
          .collection("usuarios")
          .doc(user.correo)
          .set(user.toMap());
      print("registrado!");
      return Right(true);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(message: e.code));
    }
  }

  @override
  Future<Either<Failure, Usuario>> getProfile(String mail) async {
    print("consulto");
    Usuario user;

    try {
      DocumentSnapshot value = await FirebaseFirestore.instance
          .collection("usuarios")
          .doc(mail)
          .get();
      if (value.exists) {
        user = Usuario.fromMap(value.data());
        await updateToken(mail);
        if (user != null && user.nombres != null) {
          return Right(user);
        }
        return Left(ServerFailure(message: "falla inesperada"));
      } else {
        return Left(ServerFailure(message: "user no found"));
      }
    } on FirebaseAuthException catch (e) {
      print("falle---" + e.code);

      return Left(ServerFailure(message: e.code));
    }
  }

  updateToken(String correo) async {
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    await _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.getToken().then((token) {
      print('===== FCM Token =====');
      print(token);
      registrarToken(correo, token);
    });
  }

  static registrarToken(String correo, String tokensito) {
    FirebaseFirestore.instance
        .collection("usuarios")
        .doc(correo)
        .update({'token': tokensito}).then((_) {
      print("Token Actualizado");
    });
  }

  @override
  Future<Either<Failure, List<Nutrition>>> getAllNutrition() async {
    List<Nutrition> alimentacion = [];
    try {
      QuerySnapshot value =
          await FirebaseFirestore.instance.collection("alimentacion").get();
      for (QueryDocumentSnapshot val in value.docs) {
        alimentacion.add(Nutrition.fromMap(val.data()));
      }
      return Right(alimentacion);
    } on FirebaseAuthException catch (e) {
      print("falle---" + e.code);
      return Left(ServerFailure(message: e.code));
    }
  }

  static Future<void> checkUserExist(String userId) async {
    var startfulldate = Timestamp.fromDate(DateTime.now());
    print(startfulldate);
    DateTime _now = DateTime.now();

    DateTime _starte = DateTime(2021, 01, 01, 0, 0);
    DateTime _endte = DateTime(2021, 01, 11, 23, 59, 59);

    DateTime inicio = DateTime(2021, 01, 10, 0, 0);
    DateTime fin = DateTime(2021, 01, 11, 08, 00, 00);

    final firestoreInstance = FirebaseFirestore.instance;
    await firestoreInstance
        .collection("usuarios")
        .where("fechaCreacion", isGreaterThanOrEqualTo: inicio)
        .where("fechaCreacion", isLessThanOrEqualTo: fin)
        // .where("fechaCreacion", isLessThanOrEqualTo: _end)
        .get()
        .then((value) {
      if (value.docs != null && value.docs.length > 0) {
        for (QueryDocumentSnapshot val in value.docs) {
          print(val.data());
        }

        print("Existe el usuario---->");
      } else {
        print("No Existe el usuario---->");

        // return false;
      }

      print(value.docs.length);
    });

    print("reviso---->");
  }

  @override
  Future<Either<Failure, List<Routine>>> getAllRoutine() async {
    List<Routine> routine = [];
    try {
      QuerySnapshot value =
          await FirebaseFirestore.instance.collection("ejercicios").get();
      for (QueryDocumentSnapshot val in value.docs) {
        routine.add(Routine.fromMap(val.data()));
      }
      return Right(routine);
    } on FirebaseAuthException catch (e) {
      print("falle---" + e.code);
      return Left(ServerFailure(message: e.code));
    }
  }
}
