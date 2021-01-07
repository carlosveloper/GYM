import 'package:flutter/material.dart';
import 'package:gimnasio/src/config/colors.dart';
import 'package:gimnasio/src/config/route_generator.dart';
import 'package:gimnasio/src/provider/MyappProvider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  App._();

  static ChangeNotifierProvider init() => ChangeNotifierProvider<MyAppProvider>(
        create: (_) => MyAppProvider(),
        builder: (_, __) => App._(),
      );

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MyAppProvider>();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gym',
        onGenerateRoute: RouteGenerator.generateRoute,
        navigatorKey: provider.navigatorKey,
        initialRoute: "/",
        builder: (context, widget) => ResponsiveWrapper.builder(
              BouncingScrollWrapper.builder(context, widget),
              maxWidth: MediaQuery.of(context).size.width,
              minWidth: 450,
              defaultScale: true,
              debugLog: false,
              breakpoints: [
                ResponsiveBreakpoint.resize(450, name: MOBILE),
                ResponsiveBreakpoint.autoScale(800, name: TABLET),
                ResponsiveBreakpoint.autoScale(1000, name: TABLET),
                ResponsiveBreakpoint.resize(1200, name: DESKTOP),
                ResponsiveBreakpoint.autoScale(2460, name: "4K"),
              ],
            ),
        //home: HomePage(),
        //initialRoute: "/",
        /* getPages: [
          GetPage(name: '/', page: () => HomePage()),

        ] */

        theme: ThemeData(
          fontFamily: 'Poppins',
          primaryColor: Colors.white,
          brightness: Brightness.light,
          accentColor: AppColors().mainColor(1),
          focusColor: AppColors().accentColor(1),
          hintColor: AppColors().secondColor(1),
          textTheme: TextTheme(
            button: TextStyle(color: Colors.white),
            headline5:
                TextStyle(fontSize: 20.0, color: AppColors().secondColor(1)),
            headline4: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: AppColors().secondColor(1)),
            headline3: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                color: AppColors().secondColor(1)),
            headline2: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w700,
                color: AppColors().mainColor(1)),
            headline1: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w300,
                color: AppColors().secondColor(1)),
            subtitle1: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
                color: AppColors().secondColor(1)),
            headline6: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: AppColors().mainColor(1)),
            bodyText1:
                TextStyle(fontSize: 12.0, color: AppColors().secondColor(1)),
            bodyText2: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                color: AppColors().secondColor(1)),
          ),
        ));
  }
}
