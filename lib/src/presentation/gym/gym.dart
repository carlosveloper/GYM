import 'package:flutter/material.dart';
import 'package:gimnasio/src/presentation/gym/card_presentation.dart';

class GymPage extends StatelessWidget {
  const GymPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              "Bienvenido",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 27),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: ImageCardWithInternal(
              duration: "",
              title: "Gym Belgica",
              image:
                  "https://gimnasiotaurus.com/wp-content/uploads/2019/07/FACHADA-TAURUS-JOYA-min.jpg",
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25),
            child: Text(
                "En Gym Belgica pensamos en ti y queremos darte siempre lo mejor de lo mejor. Adquiere tu membresía de 6 o 12 meses y recibe gratis tu tarjeta VIP , recibe las mejores asesorias de nuestros instructores , usa la app y revisa las recomendaciones , por tu seguridad del distanciamiento social podras observar si hay disponibles cupos para que puedas asistir a tus entrenamientos.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                )),
          ),
          Expanded(
            child: Container(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Align(alignment: Alignment.center, child: masHorario()),
                      SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.location_on),
                            SizedBox(
                              width: 5.0,
                            ),
                            Expanded(
                              child: Text(
                                'Cbo. Alfonso Lamina Chiguano y 1° pasaje 24',
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      datos(Icons.people, "Limite de Personas en el Local 1/10")
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget masHorario() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      color: Colors.white,
      child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Icon(Icons.watch),
        SizedBox(
          width: 5.0,
        ),
        Text(
          "Lunes - viernes 7:00 am a 21:30 pm",
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        SizedBox(
          width: 8,
        ),
        Text(
          "ABIERTO AHORA",
          style: TextStyle(color: Colors.green, fontSize: 16),
        )
      ]),
    );
  }

  Widget datos(icon, text) {
    return Align(
      alignment: Alignment.center,
      child: Row(
        children: <Widget>[
          Icon(icon),
          SizedBox(
            width: 5.0,
          ),
          Expanded(
            child: Text(
              '$text',
              overflow: TextOverflow.clip,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
    );
  }
}
