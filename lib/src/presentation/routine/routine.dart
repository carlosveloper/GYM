import 'package:flutter/material.dart';
import 'package:gimnasio/src/config/colors.dart';
import 'package:gimnasio/src/domain/model/Nutrition.dart';
import 'package:gimnasio/src/domain/model/Routine.dart';

class RoutinePage extends StatelessWidget {
  final List<Routine> routine;
  const RoutinePage({Key key, this.routine}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: routine.length > 0
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: routine.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      margin: EdgeInsets.only(bottom: 12),
                      child: RoutineItem(routine[index]));
                  // itemNutrition(nutrition[index]));
                  //
                })
            : Container(
                child: Center(
                  child: Text("No existe recomendaciones por el momento"),
                ),
              ));
  }

  Widget itemNutrition(Nutrition item) {
    return Text(item.toJson());
  }
}

class RoutineItem extends StatelessWidget {
  final Routine item;
  const RoutineItem(this.item);
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
                          item.ejercicio,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          item.salud,
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
