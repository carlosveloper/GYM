import 'package:flutter/material.dart';
import 'package:gimnasio/src/config/colors.dart';
import 'package:gimnasio/src/presentation/common/avatar.dart';
import 'package:gimnasio/src/presentation/home/widgets/app_bar.dart';
import 'package:gimnasio/src/presentation/home/widgets/drawer.dart';
import 'package:gimnasio/src/presentation/home/widgets/tab_bar.dart';
import 'package:gimnasio/src/provider/HomeProvider.dart';

import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage._();

  static ChangeNotifierProvider init() => ChangeNotifierProvider<HomeProvider>(
        create: (_) => HomeProvider(),
        builder: (_, __) => new HomePage._(),
      );

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  HomeProvider appHome = null;
  bool _isInitialized; //This is the key

  @override
  Widget build(BuildContext context) {
    print(":...........");
    appHome = context.watch<HomeProvider>();
    if (this._isInitialized == null || !this._isInitialized) {
      // Only execute once
      appHome.load(context);
      // appHome.cargarParametrosGenerales();
      this._isInitialized =
          true; // Set this to true to prevent next execution using "if()" at this root block
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0), // here the desired height
          child: AppBarHome(
            onPressedDrawer: () {
              _scaffoldKey.currentState.openDrawer();
            },
          )),
      backgroundColor: Colors.grey[300],
      drawer: DrawerWidget(),
      body: appHome.listPage[appHome.page],

      /*   NutritionPage(
        nutrition: appHome.alimentacion,
      ), */
      //GymPage(),
      bottomNavigationBar: TabBarHome(),
    );
  }

  Widget appBar(HomeProvider appHome) {
    return Container(
      height: kToolbarHeight * 1.1,
      padding: EdgeInsets.only(left: 5, top: 8, bottom: 8),
      color: AppColors.primary,
      child: Row(
        children: [
          /*  Container(
            height: 60,
            width: 60,
            child: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(
                    "https://w1.pngwing.com/pngs/177/316/png-transparent-mouse-computer-mouse-user-technical-support-car-computer-network-avatar-line.png")
                
                ),
          ), */

          if (appHome != null) ...{
            MyAvatar(size: 50, url: appHome.user.foto),
          },
          SizedBox(
            width: 10,
          ),
          Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  appHome.user?.nombres ??
                      '' + " " + appHome.user?.apellidos ??
                      '',
                  style: TextStyle(fontSize: 18, color: AppColors.blancoHueso),
                ),
              ],
            ),
          ),
          Spacer(),
          Icon(
            Icons.info,
            color: AppColors.blancoHueso,
            size: 30,
          ),
          SizedBox(
            width: 25,
          ),
          Icon(
            Icons.add,
            color: AppColors.blancoHueso,
            size: 30,
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
