import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gimnasio/src/data/datasource/api_repositoy_impl.dart';
import 'package:gimnasio/src/domain/Global.dart';
import 'package:gimnasio/src/domain/model/CardTag.dart';
import 'package:gimnasio/src/domain/model/Medic.dart';
import 'package:gimnasio/src/domain/model/Nutrition.dart';
import 'package:gimnasio/src/domain/model/Routine.dart';
import 'package:gimnasio/src/domain/model/User.dart';
import 'package:gimnasio/src/presentation/cardTagUser/card_tagUser.dart';
import 'package:gimnasio/src/presentation/gym/gym.dart';
import 'package:gimnasio/src/presentation/nutrition/nutrition.dart';
import 'package:gimnasio/src/presentation/profile/profile.dart';
import 'package:gimnasio/src/presentation/routine/routine.dart';
import 'package:gimnasio/src/provider/FCMPushNotificationProvider.dart';

class HomeProvider extends ApiRepositoryImpl with ChangeNotifier {
  var contextHome;
  int page = 0;
  final pushProvider = new PushNotificationProvider();

  Usuario user;
  Medic userMedic;

  List<Nutrition> alimentacion = [];
  List<Routine> routine = [];
  List<CardTag> tarjetasUsuarios = [];
  String codigoTag = "";

  List<Widget> listPage = [
    GymPage(),
    GymPage(),
    GymPage(),
    GymPage(),
    ProfilePage()
  ];

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  load(context) async {
    contextHome = context;
    String mail = FirebaseAuth.instance.currentUser.email;
    print("email" + mail);
    var responseProfile = await getProfile(mail);

    responseProfile.fold((l) => print("fail" + l.getMessageError()), (data) {
      this.user = data;
      Global.miPerfil = data;
      print("Traje el usuario");
      notifyListeners();
    });

    var responseProfileMedic = await getProfileMedic(mail);

    responseProfileMedic.fold((l) => print("fail" + l.getMessageError()),
        (data) {
      this.userMedic = data;
      Global.userMedic = userMedic;
      print("Traje datos medicos");
      notifyListeners();
    });

    if (this.user.rol == "ADMIN") {
      solicitudesAdmin();
    } else if (this.user.rol == "CLIENTE") {
      if (this.userMedic != null) {
        solicitudesCliente(userMedic.salud);
      }
      await obtenerTarjetasCliente();
    }
    iniciarNotificaciones();
    inicializoNotificacion();
  }

  iniciarNotificaciones() {
    pushProvider.initNotifications(admin: true);
    pushProvider.mensajes.listen((data) {
      showNotification("Gym", data['notification']['body']);
    });
  }

  void inicializoNotificacion() {
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = new IOSInitializationSettings();
    var initSetttings = new InitializationSettings(android: android, iOS: iOS);
    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async {}

  showNotification(String title, String body) async {
    var android = new AndroidNotificationDetails(
        'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
        priority: Priority.high, importance: Importance.max);
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platform,
      payload: body,
    );
  }

  solicitudesAdmin() async {
    var responseNutrition = await getAllNutrition();
    responseNutrition.fold((l) => print("fail" + l.getMessageError()), (data) {
      alimentacion = data;
      print("Traje la alimentación");
      print(data.length);
      llenarWidgets();
      notifyListeners();
    });

    var responseRoutine = await getAllRoutine();
    responseRoutine.fold((l) => print("fail" + l.getMessageError()), (data) {
      routine = data;
      print("Traje los Ejercicios");
      print(data.length);
      llenarWidgets();
      notifyListeners();
    });
  }

  solicitudesCliente(String tipo) async {
    var responseNutrition = await getSaludNutrition(tipo);
    responseNutrition.fold((l) => print("fail" + l.getMessageError()), (data) {
      alimentacion = data;
      print("Traje la alimentación");
      print(data.length);
      llenarWidgets();
      notifyListeners();
    });

    var responseRoutine = await getSaludRoutine(tipo);
    responseRoutine.fold((l) => print("fail" + l.getMessageError()), (data) {
      routine = data;
      print("Traje los Ejercicios");
      print(data.length);
      llenarWidgets();
      notifyListeners();
    });
  }

  obtenerTarjetasCliente() async {
    var responseCard = await getAllCardTag();
    responseCard.fold((l) => print("fail" + l.getMessageError()), (data) {
      tarjetasUsuarios = data;
      print("---tarjetas usuarios");
      print(tarjetasUsuarios.length);
      for (CardTag tar in tarjetasUsuarios) {
        if (tar.usuario == user.correo) {
          codigoTag = tar.codigoTag;
          notifyListeners();
        }
      }
      llenarWidgets();
      notifyListeners();
    });
  }

  changeSelect(i) {
    page = i;
    notifyListeners();
  }

  llenarWidgets() {
    listPage.clear();
    listPage.add(GymPage());
    listPage.add(NutritionPage(
      nutrition: alimentacion,
    ));
    listPage.add(CardTagUser(
      codigoTag: codigoTag,
    ));
    listPage.add(RoutinePage(
      routine: routine,
    ));
    listPage.add(ProfilePage());
  }

  @override
  void dispose() {
    super.dispose();
    pushProvider.dispose();
  }
}
