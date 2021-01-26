import 'package:flutter/material.dart';
import 'package:gimnasio/src/domain/model/Nutrition.dart';
import 'package:gimnasio/src/presentation/nutrition/widget/item_nutrition.dart';

class NutritionPage extends StatelessWidget {
  final List<Nutrition> nutrition;
  const NutritionPage({Key key, this.nutrition}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: nutrition.length > 0
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: nutrition.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      margin: EdgeInsets.only(bottom: 12),
                      child: ItemNutrition(nutrition[index]));
                  // itemNutrition(nutrition[index]));
                  //
                })
            : Container(
                child: Center(
                  child: Text("No existe recomendaciones"),
                ),
              ));
  }

  Widget itemNutrition(Nutrition item) {
    return Text(item.toJson());
  }
}
