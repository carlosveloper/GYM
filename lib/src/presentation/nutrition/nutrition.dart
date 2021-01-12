import 'package:flutter/material.dart';
import 'package:gimnasio/src/config/colors.dart';
import 'package:gimnasio/src/domain/model/Nutrition.dart';

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
                      child: NutritionItem(nutrition[index]));
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

class NutritionItem extends StatelessWidget {
  final Nutrition item;
  const NutritionItem(this.item);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Card(
          elevation: 6,
          shadowColor: Colors.black54,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: Colors.white,
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.30,
                padding: const EdgeInsets.all(10.0),
                child: Image.network(item.foto),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          item.salud,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          item.tipo,
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 14, color: AppColors.tituloCafe),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                    Text(
                      recomodarText(item.recomendacion),
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String recomodarText(String recomendacion) {
    String result = recomendacion.replaceAll("-", "\n -");
    return result;
  }
}
