import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gimnasio/src/data/datasource/api_repositoy_impl.dart';
import 'package:gimnasio/src/domain/model/Nutrition.dart';
import 'package:gimnasio/src/domain/model/User.dart';
import 'package:gimnasio/src/presentation/gym/gym.dart';
import 'package:gimnasio/src/presentation/nutrition/nutrition.dart';

class HomeProvider extends ApiRepositoryImpl with ChangeNotifier {
  var contextHome;
  int page = 0;

  Usuario user;

  List<Nutrition> alimentacion = [];
  List<Widget> listPage = [GymPage(), GymPage(), GymPage(), GymPage()];

  load(context) async {
    contextHome = context;
    String mail = FirebaseAuth.instance.currentUser.email;
    print("email" + mail);
    var responseProfile = await getProfile(mail);

    responseProfile.fold((l) => print("fail" + l.getMessageError()), (data) {
      this.user = data;
      print("Traje el usuario");
      notifyListeners();
    });

    var responseNutrition = await getAllNutrition();
    responseNutrition.fold((l) => print("fail" + l.getMessageError()), (data) {
      alimentacion = data;

      print("Traje la alimentación");
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
    listPage.add(GymPage());
    listPage.add(GymPage());
  }
}
