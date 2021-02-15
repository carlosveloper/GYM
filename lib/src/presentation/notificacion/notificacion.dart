import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gimnasio/src/domain/model/DtsNotificacion.dart';
import 'package:gimnasio/src/presentation/common/avatar_assets.dart';

class NotifiPage extends StatefulWidget {
  final context;
  const NotifiPage({Key key, this.context}) : super(key: key);

  @override
  _NotifiPageState createState() => _NotifiPageState();
}

class _NotifiPageState extends State<NotifiPage> {
  List<DtsNotificacion> notificaciones = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("notificaciones")
              .orderBy('fecha', descending: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData)
              return Center(child: CircularProgressIndicator());
            else {
              var list = snapshot.data.docs;
              //   print("tamaño de la lista");
              //   print(list.length.toString());
              notificaciones.clear();
              for (var doc in list) {
                // print(doc.data);
                DtsNotificacion mensaje = DtsNotificacion.fromMap(doc.data());
                notificaciones.add(mensaje);
              }

              if (notificaciones.length <= 0) {
                print("no tengo");
                return Center(
                  child: Text(
                    "No existe ninguna notificación por el momento",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                );
              } else
                return ListView.builder(
                    //reverse: true,
                    itemCount: notificaciones.length,
                    itemBuilder: (context, i) {
                      return VistaNotificacion(
                        causa: "",
                        mensaje: notificaciones[i].mensaje,
                      );
                    });
            }
          }),
    ));
  }
}

class VistaNotificacion extends StatelessWidget {
  final String mensaje;
  final String causa;

  const VistaNotificacion(
      {@required this.mensaje, @required this.causa, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ListTile(
            leading: MyAvatarAssets(
              size: 60,
              url: "assets/logo.png",
            ),
            title: Text("Plan vencido"),
            subtitle: Text(mensaje),
          ),
          Divider()
        ],
      ),
    );
  }
}
