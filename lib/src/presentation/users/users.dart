import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gimnasio/src/config/colors.dart';
import 'package:gimnasio/src/domain/model/User.dart';
import 'package:gimnasio/src/presentation/users/widgets/item_users.dart';
import 'package:google_fonts/google_fonts.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  List<Usuario> usuarios = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
          child: Text("Mis Usuarios",
              style: GoogleFonts.raleway(
                  color: AppColors.blancoHueso,
                  fontSize: 22,
                  fontWeight: FontWeight.bold)),
        ),
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection("usuarios").snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData)
                return Center(child: CircularProgressIndicator());
              else {
                var list = snapshot.data.docs;
                print(list.length.toString());
                usuarios.clear();
                for (var doc in list) {
                  print(doc.data);
                  Usuario usr = Usuario.fromMap(doc.data());
                  usuarios.add(usr);
                }
                if (usuarios.length <= 0) {
                  return Center(
                    child: Text(
                      "No existe ningun usuario por el momento",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  );
                } else
                  return ListView.builder(
                      //reverse: true,
                      itemCount: usuarios.length,
                      itemBuilder: (context, i) {
                        return CardUsers.vertical(usuarios[i]);
                      });
              }
            }),
      ),
    );
  }
}
