import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gimnasio/src/domain/exception/Failure.dart';
import 'package:gimnasio/src/domain/model/CardTag.dart';
import 'package:gimnasio/src/domain/model/HistorialTag.dart';
import 'package:gimnasio/src/domain/model/Medic.dart';
import 'package:gimnasio/src/domain/model/Nutrition.dart';
import 'package:gimnasio/src/domain/model/Peso.dart';
import 'package:gimnasio/src/domain/model/RecargaTag.dart';
import 'package:gimnasio/src/domain/model/Routine.dart';
import 'package:gimnasio/src/domain/model/Salud.dart';
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
  Future<Either<Failure, bool>> registerCredentials(Usuario user) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: user.correo, password: user.correo);

      return Right(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return Left(ServerFailure(message: e.code));
    } catch (e) {
      print(e);
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
  Future<Either<Failure, String>> uploadImageProfile(
      File imageToUpload, String title) async {
    try {
      var imageFileName =
          title + DateTime.now().millisecondsSinceEpoch.toString();
      Reference reference = FirebaseStorage.instance.ref();
      await reference
          .child("perfiles/usuarios/" + imageFileName)
          .putFile(imageToUpload);

      String downloadURL = await FirebaseStorage.instance
          .ref("perfiles/usuarios/" + imageFileName)
          .getDownloadURL();
      return Right(downloadURL);
    } on FirebaseException catch (e) {
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

  @override
  Future<Either<Failure, List<CardTag>>> getAllCardTag() async {
    List<CardTag> tarjetas = [];
    try {
      QuerySnapshot value =
          await FirebaseFirestore.instance.collection("tarjetas").get();
      for (QueryDocumentSnapshot val in value.docs) {
        tarjetas.add(CardTag.fromMap(val.data()));
      }
      return Right(tarjetas);
    } on FirebaseAuthException catch (e) {
      print("falle---" + e.code);
      return Left(ServerFailure(message: e.code));
    }
  }

  @override
  Future<Either<Failure, List<RecargaTag>>> getAllRecargasCardTag() async {
    List<RecargaTag> tarjetas = [];
    try {
      QuerySnapshot value =
          await FirebaseFirestore.instance.collection("recargotarjeta").get();
      for (QueryDocumentSnapshot val in value.docs) {
        tarjetas.add(RecargaTag.fromMap(val.data()));
      }
      return Right(tarjetas);
    } on FirebaseAuthException catch (e) {
      print("falle---" + e.code);
      return Left(ServerFailure(message: e.code));
    }
  }

  @override
  Future<Either<Failure, List<Usuario>>> getAllUsers() async {
    List<Usuario> usuarios = [];
    try {
      QuerySnapshot value =
          await FirebaseFirestore.instance.collection("usuarios").get();
      for (QueryDocumentSnapshot val in value.docs) {
        usuarios.add(Usuario.fromMap(val.data()));
      }
      return Right(usuarios);
    } on FirebaseAuthException catch (e) {
      print("falle---" + e.code);
      return Left(ServerFailure(message: e.code));
    }
  }

  @override
  Future<Either<Failure, bool>> updateUserCardTag(
      String idDocumento, String correo, String estado) async {
    try {
      FirebaseFirestore.instance
          .collection("tarjetas")
          .doc(idDocumento)
          .update({'usuario': correo, 'estado': estado});
      return Right(true);
    } on FirebaseAuthException catch (e) {
      print("falle---" + e.code);
      return Left(ServerFailure(message: e.code));
    }
  }

  @override
  Future<Either<Failure, bool>> registerRecargasCardTag(String codTag) async {
    try {
      RecargaTag nuevo = RecargaTag(
          codigoTag: codTag,
          plan: false,
          valor: 0.0,
          fechaInicio: Timestamp.now(),
          fechaFin: Timestamp.now());

      await FirebaseFirestore.instance
          .collection("recargotarjeta")
          .doc(codTag)
          .set(nuevo.toMap());
      print("registrado!");
      return Right(true);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(message: e.code));
    }
  }

  @override
  Future<Either<Failure, bool>> updateRecargaTag(RecargaTag recarga) async {
    try {
      await FirebaseFirestore.instance
          .collection("recargotarjeta")
          .doc(recarga.codigoTag)
          .update(recarga.toMap());

      FirebaseFirestore.instance
          .collection("planesActivado")
          .doc()
          .set(recarga.toMap());

      return Right(true);
    } on FirebaseAuthException catch (e) {
      print("falle---" + e.code);
      return Left(ServerFailure(message: e.code));
    }
  }

  @override
  Future<Either<Failure, List<HistorialTag>>> getAllHistorialTag() async {
    List<HistorialTag> historial = [];
    try {
      QuerySnapshot value =
          await FirebaseFirestore.instance.collection("historial").get();
      for (QueryDocumentSnapshot val in value.docs) {
        historial.add(HistorialTag.fromMap(val.data()));
      }
      return Right(historial);
    } on FirebaseAuthException catch (e) {
      print("falle---" + e.code);
      return Left(ServerFailure(message: e.code));
    }
  }

  @override
  Future<Either<Failure, List<Salud>>> getAllSalud() async {
    List<Salud> salud = [];
    try {
      QuerySnapshot value =
          await FirebaseFirestore.instance.collection("salud").get();
      for (QueryDocumentSnapshot val in value.docs) {
        salud.add(Salud.fromMap(val.data()));
      }
      return Right(salud);
    } on FirebaseAuthException catch (e) {
      print("falle---" + e.code);
      return Left(ServerFailure(message: e.code));
    }
  }

  @override
  Future<Either<Failure, List<Peso>>> getAllPeso() async {
    List<Peso> pesos = [];
    try {
      QuerySnapshot value =
          await FirebaseFirestore.instance.collection("peso").get();
      for (QueryDocumentSnapshot val in value.docs) {
        pesos.add(Peso.fromMap(val.data()));
      }
      return Right(pesos);
    } on FirebaseAuthException catch (e) {
      print("falle---" + e.code);
      return Left(ServerFailure(message: e.code));
    }
  }

  @override
  Future<Either<Failure, bool>> registerMedic(Medic user) async {
    try {
      await FirebaseFirestore.instance
          .collection("medic")
          .doc(user.correo)
          .set(user.toMap());
      print("registrado!");
      return Right(true);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(message: e.code));
    }
  }

  @override
  Future<Either<Failure, Medic>> getProfileMedic(String mail) async {
    print("consulto");
    Medic user;
    try {
      DocumentSnapshot value =
          await FirebaseFirestore.instance.collection("medic").doc(mail).get();
      if (value.exists) {
        user = Medic.fromMap(value.data());
        if (user != null) {
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

  @override
  Future<Either<Failure, List<Nutrition>>> getSaludNutrition(
      String tipo) async {
    List<Nutrition> alimentacion = [];
    try {
      QuerySnapshot value = await FirebaseFirestore.instance
          .collection("alimentacion")
          .where("salud", isEqualTo: tipo)
          .get();
      for (QueryDocumentSnapshot val in value.docs) {
        alimentacion.add(Nutrition.fromMap(val.data()));
      }
      return Right(alimentacion);
    } on FirebaseAuthException catch (e) {
      print("falle---" + e.code);
      return Left(ServerFailure(message: e.code));
    }
  }

  @override
  Future<Either<Failure, List<Routine>>> getSaludRoutine(String tipo) async {
    List<Routine> routine = [];
    try {
      QuerySnapshot value = await FirebaseFirestore.instance
          .collection("ejercicios")
          .where("salud", isEqualTo: tipo)
          .get();
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
