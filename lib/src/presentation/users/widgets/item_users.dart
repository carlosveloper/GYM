import 'package:flutter/material.dart';
import 'package:gimnasio/src/config/colors.dart';
import 'package:gimnasio/src/domain/model/User.dart';
import 'package:gimnasio/src/presentation/common/avatar.dart';

class CardUsers extends StatelessWidget {
  final Usuario usuario;
  final bool horizontal;

  CardUsers(this.usuario, {this.horizontal = true});

  CardUsers.vertical(this.usuario) : horizontal = false;

  @override
  Widget build(BuildContext context) {
    final containerPrincipal = new Container(
      margin: new EdgeInsets.symmetric(vertical: 16.0),
      alignment:
          horizontal ? FractionalOffset.centerLeft : FractionalOffset.center,
      child: new Hero(
          tag: "usuario-hero-${usuario.correo}",
          child: MyAvatar(
            size: 100,
            url: usuario.foto,
          )),
    );

    Widget _direccionValue({String value}) {
      return Flex(
        direction: Axis.vertical,
        children: [
          Text(
            "Direccion: " + usuario.direccion,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ],
      );
    }

    final planetCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(
          horizontal ? 76.0 : 16.0, horizontal ? 16.0 : 42.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment:
            horizontal ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            height: 0.5,
          ),
          new Text(
            usuario.nombres + " " + usuario.apellidos,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          new Text(
            "Telefono: " + usuario.celular,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          _direccionValue(value: usuario.direccion)
        ],
      ),
    );

    Gradient appGradient = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.tituloCafe,
          AppColors.primary,
        ],
        stops: [
          0,
          0.7
        ]);

    final userCard = new Container(
      child: planetCardContent,
      height: horizontal ? 124.0 : 154.0,
      margin: horizontal
          ? new EdgeInsets.only(left: 35.0)
          : new EdgeInsets.only(top: 72.0),
      decoration: new BoxDecoration(
        shape: BoxShape.rectangle,
        gradient: appGradient,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: new Offset(0.0, 10.0),
          ),
        ],
      ),
    );

    return new GestureDetector(
        onTap: () {},
        child: new Container(
          margin: const EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 24.0,
          ),
          child: new Stack(
            children: <Widget>[
              userCard,
              containerPrincipal,
            ],
          ),
        ));
  }
}
