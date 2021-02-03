import 'package:flutter/material.dart';
import 'package:gimnasio/src/config/ui_icons.dart';
import 'package:gimnasio/src/presentation/common/avatar.dart';
import 'package:gimnasio/src/provider/HomeProvider.dart';

import 'package:provider/provider.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appHome = context.watch<HomeProvider>();

    return Drawer(
      child: ListView(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              //   Navigator.of(context).pushNamed('/Tabs', arguments: 1);
            },
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).hintColor.withOpacity(0.1),
                //color: AppColors().mainColor.withOpacity(0.1),
//              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(35)),
              ),
              accountName: appHome.user != null
                  ? Text(
                      appHome.user.nombres + " " + appHome.user.apellidos,
                      style: Theme.of(context).textTheme.headline6,
                    )
                  : null,
              accountEmail: appHome.user != null
                  ? Text(
                      appHome.user?.correo,
                      style: Theme.of(context).textTheme.caption,
                    )
                  : null,
              currentAccountPicture: appHome.user != null
                  ? MyAvatar(
                      size: 125,
                      url: appHome.user.foto,
                    )
                  : null,
              /* CircleAvatar(
                backgroundColor: Theme.of(context).accentColor,
                /* backgroundImage: NetworkImage( */
                /*     "https://www.elsoldemexico.com.mx/finanzas/nhqk9l-steve-jobs-apple/ALTERNATES/LANDSCAPE_1140/Steve%20Jobs%20Apple",), */
                child: ClipRRect(
                  // borderRadius: new BorderRadius.circular(100.0),
                  child: Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQqXJSJ-I3aOx25n541u1AqXN1VlOILtJ76Dg&usqp=CAU',
                    fit: BoxFit.fill,
                  ),
                ),
              ), */
            ),
          ),
          ListTile(
            dense: true,
            title: Text(
              "Menú",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            trailing: Icon(
              Icons.ac_unit,
              color: Theme.of(context).focusColor.withOpacity(0.3),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/RegistroUser', arguments: 0);
            },
            leading: Icon(
              UiIcons.user,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Registro Usuario",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            /*  trailing: Chip(
              padding: EdgeInsets.symmetric(horizontal: 5),
              backgroundColor: Colors.transparent,
              shape: StadiumBorder(
                  side: BorderSide(color: Theme.of(context).focusColor)),
              label: Text(
                '10',
                style: TextStyle(color: Theme.of(context).focusColor),
              ),
            ), */
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Maps');
            },
            leading: Icon(
              UiIcons.drug,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Datos Medicos",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/CardTags', arguments: 2);
            },
            leading: Icon(
              UiIcons.credit_card,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Mis Tarjetas",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/RecargaTags', arguments: 2);
            },
            leading: Icon(
              UiIcons.credit_card,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Planes y Recargas",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Historial', arguments: 2);
            },
            leading: Icon(
              UiIcons.zoom_in,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Historial",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Users', arguments: 0);
            },
            leading: Icon(
              UiIcons.user_1,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Usuarios",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Orders', arguments: 0);
            },
            leading: Icon(
              UiIcons.bell,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Notificaciones Plan",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            trailing: Chip(
              padding: EdgeInsets.symmetric(horizontal: 5),
              backgroundColor: Colors.transparent,
              shape: StadiumBorder(
                  side: BorderSide(color: Theme.of(context).focusColor)),
              label: Text(
                '10',
                style: TextStyle(color: Theme.of(context).focusColor),
              ),
            ),
          ),
          ListTile(
            dense: true,
            title: Text(
              "Preferencias de Aplicación",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            trailing: Icon(
              UiIcons.settings_1,
              //color: Theme.of(context).focusColor.withOpacity(0.3),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Help');
            },
            leading: Icon(
              UiIcons.settings_2,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Ayuda y Soporte",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Tabs', arguments: 1);
            },
            leading: Icon(
              UiIcons.settings,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Configuraciones",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          ListTile(
            onTap: () async {
              /*    final provider = context.read<UserProvider>();
              provider.signOut(); */

              Navigator.of(context).pushNamedAndRemoveUntil(
                  "/Login",
                  (
                    Route<dynamic> route,
                  ) =>
                      false);

              // final varContext = context.watch()<UserProvider>();
              //signOut
              //   varContext.signOut();
              //Navigator.of(context).pushNamed('/Login');
              print('debo salir de sesion');
            },
            leading: Icon(
              Icons.close,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Cerrar Sesión",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
        ],
      ),
    );
  }
}
