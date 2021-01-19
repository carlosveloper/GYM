import 'package:flutter/material.dart';
import 'package:gimnasio/src/config/colors.dart';
import 'package:gimnasio/src/config/ui_icons.dart';
import 'package:gimnasio/src/provider/HomeProvider.dart';
import 'package:provider/provider.dart';

class TabBarHome extends StatefulWidget {
  TabBarHome({Key key}) : super(key: key);

  @override
  _TabBarHomeState createState() => _TabBarHomeState();
}

class _TabBarHomeState extends State<TabBarHome> {
  double sizeIcons = 26.0;
  @override
  Widget build(BuildContext context) {
    final appHome = Provider.of<HomeProvider>(context, listen: false);

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Theme.of(context).accentColor,
      selectedFontSize: 0,
      unselectedFontSize: 0,
      iconSize: 24,
      elevation: 0,
      backgroundColor: Colors.transparent,
      selectedIconTheme: IconThemeData(size: 25),
      unselectedItemColor: Theme.of(context).hintColor.withOpacity(1),
      currentIndex: 4,
      onTap: (int i) {
        //this._selectTab(i);
        appHome.changeSelect(i);
      },
      items: [
        BottomNavigationBarItem(
          label: "",
          // title: new Container(height: 0.0),
          icon: Icon(
            UiIcons.home,
            size: sizeIcons,
          ),
        ),
        BottomNavigationBarItem(
          label: "",
          // title: new Container(height: 0.0),

          icon: Icon(
            UiIcons.restaurant,
            size: sizeIcons,
          ),
        ),
        BottomNavigationBarItem(
          label: "",
          // title: new Container(height: 5.0),
          icon: Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
              boxShadow: [
                BoxShadow(
                    color: AppColors.primary.withOpacity(0.4),
                    blurRadius: 40,
                    offset: Offset(0, 15)),
                BoxShadow(
                    color: AppColors.primary.withOpacity(0.4),
                    blurRadius: 13,
                    offset: Offset(0, 3))
              ],
            ),
            child: new Icon(
              UiIcons.credit_card,
              color: Colors.white,
              size: sizeIcons,
            ),
          ),
        ),
        BottomNavigationBarItem(
          label: "",
          // title: new Container(height: 5.0),
          icon: new Icon(
            UiIcons.fitness,
            size: sizeIcons,
          ),
        ),
        BottomNavigationBarItem(
          label: "",
          // title: new Container(height: 5.0),
          icon: new Icon(
            UiIcons.user_1,
            size: sizeIcons,
          ),
        ),
      ],
    );
  }
}
