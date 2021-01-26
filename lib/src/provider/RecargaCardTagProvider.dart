import 'package:flutter/material.dart';
import 'package:gimnasio/src/data/datasource/api_repositoy_impl.dart';
import 'package:gimnasio/src/domain/model/RecargaTag.dart';

class RecargaCardTagProvider extends ApiRepositoryImpl with ChangeNotifier {
  List<RecargaTag> tarjetas = [];
  var contextRecarga;

  bool isInitialized = false;

  load(context) async {
    contextRecarga = context;
    //  Text(timeago.format(DateTime.tryParse(timestamp.toDate().toString())).toString());

    var responseNutrition = await getAllRecargasCardTag();
    responseNutrition.fold((l) => print("fail" + l.getMessageError()), (data) {
      tarjetas = data;
      print("Traje las recargas");
      notifyListeners();
    });
  }
}
