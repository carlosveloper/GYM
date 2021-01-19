/* import 'package:flutter/material.dart';
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
              "Gym Belgica",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: ImageCardWithInternal(
              duration: "",
              title: "",
              image: "assets/local.jpeg",
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
 */

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gimnasio/src/config/ui_icons.dart';

class GymPage extends StatefulWidget {
  GymPageState createState() => GymPageState();
}

class GymPageState extends State<GymPage> {
  Widget build(BuildContext cx) {
    return new Scaffold(
      appBar: null,
      body: new ListView(
        children: <Widget>[
          new Column(
            children: <Widget>[
              Container(
                height: 250.0,
                color: Colors.red,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            height: 250.0,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage('assets/local.jpeg'))),
                          ),
                        )
                      ],
                    ),
                    Positioned(
                      bottom: -45.0,
                      child: Container(
                        height: 150.0,
                        width: 150.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  'https://www.bodybuilding.com/fun/images/2015/train-like-dwayne-the-rock-johnson-2b.jpg'),
                            ),
                            border:
                                Border.all(color: Colors.white, width: 6.0)),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                height: 85.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Gym Belgica',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 28.0),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Icon(
                      Icons.check_circle,
                      color: Colors.blueAccent,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 12.0,
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Text(
                    "En Gym Belgica pensamos en ti y queremos darte siempre lo mejor de lo mejor. Adquiere tu membresía de 6 o 12 meses y recibe gratis tu tarjeta VIP , recibe las mejores asesorias de nuestros instructores , usa la app y revisa las recomendaciones , por tu seguridad del distanciamiento social podras observar si hay disponibles cupos para que puedas asistir a tus entrenamientos.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 14.0),
                  )),
              SizedBox(
                height: 10.0,
              ),
              Container(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10.0,
                    ),
                    Wrap(
                      children: <Widget>[
                        Text(
                          "ABIERTO AHORA",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.work),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'Horarios:',
                          style: TextStyle(fontSize: 15.0),
                        ),
                        Text(
                          " Lunes - viernes 7:00 am a 21:30 pm -Sabados 9:00 am -16:00pm",
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.location_on),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'Ubicados:',
                          style: TextStyle(fontSize: 15.0),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'Cbo. Alfonso Lamina Chiguano y 1° pasaje 24',
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.userAlt,
                          size: 20,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'Capacidad:',
                          style: TextStyle(fontSize: 15.0),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          '40 personas - por distanciamiento social actualmente 10',
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      height: 10.0,
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    Container(
                        child: Text(
                      'Fotos',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    SizedBox(
                      height: 2.5,
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 150,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          'https://www.hola.com/imagenes/estar-bien/20190820147383/gimnasio-portatil-handy-gym-gt/0-709-410/handy-gym-t.jpg'),
                                      fit: BoxFit.fill,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                  ),
                                )),
                                SizedBox(
                                  width: 2.0,
                                ),
                                Expanded(
                                    child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          'https://www.fundeu.es/wp-content/uploads/2020/03/gimnasio_gym_efespthirteen565662.jpg'),
                                      fit: BoxFit.fill,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                  ),
                                )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Container(
                            height: 150,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          'https://www.entornointeligente.com/wp-content/uploads/2018/12/goldrs_gym_los_gimnasios_necesitan_profesionales_certificados-573x350.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                  ),
                                )),
                                SizedBox(
                                  width: 2.5,
                                ),
                                Expanded(
                                    child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          'https://static.dw.com/image/53396004_401.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                  ),
                                )),
                                SizedBox(
                                  width: 2.5,
                                ),
                                Expanded(
                                    child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          'https://www.palco23.com/files/2020/19_redaccion/fitness/pure%20gym/pure-gym-728.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                  ),
                                )),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
