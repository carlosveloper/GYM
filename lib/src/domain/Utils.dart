import 'package:flutter/material.dart';
import 'package:gimnasio/src/presentation/common/custom_dialog.dart';

class Utils {
  static showInSnackBar(context, mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(mensaje),
      duration: Duration(seconds: 5),
      /* action: SnackBarAction(
          label: 'ACTION',
          onPressed: () { },
        ), */
    ));
  }

  static void dialogGeneric(
      context, String title, String descriptions, Function onPressed) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => CustomDialog(
          title: title,
          descriptions: descriptions,
          textButton: "OK",
          img: "assets/icon_success.png",
          onPressed:
              onPressed /* () {
          Navigator.of(context).pop();
        }, */
          ),
    );
  }

/* 
  import 'package:intl/intl.dart';

    DateTime convertTimeStampToDateTime(int timeStamp) {
     var dateToTimeStamp = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
     return dateToTimeStamp;
   }

  String convertTimeStampToHumanDate(int timeStamp) {
    var dateToTimeStamp = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    return DateFormat('dd/MM/yyyy').format(dateToTimeStamp);
  }

   String convertTimeStampToHumanHour(int timeStamp) {
     var dateToTimeStamp = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
     return DateFormat('HH:mm').format(dateToTimeStamp);
   }

   int constructDateAndHourRdvToTimeStamp(DateTime dateTime, TimeOfDay time ) {
     final constructDateTimeRdv = dateTimeToTimeStamp(DateTime(dateTime.year, dateTime.month, dateTime.day, time.hour, time.minute)) ;
     return constructDateTimeRdv;
   } */

}
