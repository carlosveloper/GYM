import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gimnasio/src/data/datasource/api_repositoy_impl.dart';
import 'package:gimnasio/src/domain/Global.dart';
import 'package:gimnasio/src/domain/model/Nutrition.dart';
import 'package:gimnasio/src/domain/model/Routine.dart';
import 'package:gimnasio/src/domain/model/User.dart';
import 'package:gimnasio/src/presentation/gym/gym.dart';
import 'package:gimnasio/src/presentation/nutrition/nutrition.dart';
import 'package:gimnasio/src/presentation/profile/profile.dart';
import 'package:gimnasio/src/presentation/routine/routine.dart';

class HomeProvider extends ApiRepositoryImpl with ChangeNotifier {
  var contextHome;
  int page = 0;

  Usuario user;

  List<Nutrition> alimentacion = [];
  List<Routine> routine = [];

  List<Widget> listPage = [
    GymPage(),
    GymPage(),
    GymPage(),
    GymPage(),
    ProfilePage()
  ];

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

    solicitudesAdmin();
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

    listPage.add(GymPage());
    listPage.add(RoutinePage(
      routine: routine,
    ));
    listPage.add(ProfilePage());
  }
}
