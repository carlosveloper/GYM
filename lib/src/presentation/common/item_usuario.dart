import 'package:flutter/material.dart';
import 'package:gimnasio/src/domain/model/User.dart';
import 'package:gimnasio/src/presentation/common/avatar.dart';

class ItemUsuario extends StatelessWidget {
  final Usuario user;
  const ItemUsuario({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            MyAvatar(
              size: 100,
              url: user.foto,
            ),
            SizedBox(height: 10),
            Text(user.nombres + " " + user.apellidos),
            Text(user.correo)
          ],
        ),
      ),
    );
  }
}
