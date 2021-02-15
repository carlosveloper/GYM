import 'package:flutter/material.dart';
import 'package:gimnasio/src/config/colors.dart';
import 'package:gimnasio/src/provider/HomeProvider.dart';

import 'package:provider/provider.dart';

import 'button_notification.dart';

class AppBarHome extends StatelessWidget {
  final Function onPressedDrawer;
  const AppBarHome({Key key, @required this.onPressedDrawer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appHome = context.watch<HomeProvider>();
    return AppBar(
      automaticallyImplyLeading: false,
      leading: appHome.user != null && appHome.user.rol == "ADMIN"
          ? IconButton(
              icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
              onPressed: onPressedDrawer)
          : Container(),
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (appHome.user != null) ...{
            Text(
              appHome.user.nombres + " " + appHome.user.apellidos,
              style: Theme.of(context).textTheme.headline4,
            ),
          }
        ],
      ),
      actions: <Widget>[
        if (appHome.user != null && appHome.user.rol == "ADMIN") ...{
          ButtonNotification(
              labelCount: 10,
              iconColor: Theme.of(context).hintColor,
              //  labelColor: Theme.of(context).accentColor),
              labelColor: AppColors.buttonColor.withOpacity(0.9)),
        },
        if (appHome.user != null && appHome.user.rol == "CLIENTE") ...{
          Container(
              width: 30,
              height: 30,
              margin: EdgeInsets.only(top: 12.5, bottom: 12.5, right: 20),
              child: InkWell(
                borderRadius: BorderRadius.circular(300),
                onTap: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      "/Login",
                      (
                        Route<dynamic> route,
                      ) =>
                          false);
                },
                child: Icon(Icons.close),
              ))
        }
        /*  Container(
            width: 30,
            height: 30,
            margin: EdgeInsets.only(top: 12.5, bottom: 12.5, right: 20),
            child: InkWell(
              borderRadius: BorderRadius.circular(300),
              onTap: () {},
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  "https://w1.pngwing.com/pngs/177/316/png-transparent-mouse-computer-mouse-user-technical-support-car-computer-network-avatar-line.png",
                ),
              ),
            )), */
      ],
    );
  }
}
