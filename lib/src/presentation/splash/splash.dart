import 'package:flutter/foundation.dart';
import 'package:gimnasio/src/config/colors.dart';
import 'package:gimnasio/src/provider/MyappProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

var tamanioLogo = kIsWeb ? 350.0 : 250.0;
var posicion = kIsWeb ? 100.0 : 50.0;
var division = kIsWeb ? 1.5 : 1.8;

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animationLogoIn;
  Animation<double> _animationLogoMovementUp;

  AnimationController _animationControllerSignUp;
  Animation<double> _animationLogoOut;

  void _setupFirstAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );
    _animationLogoIn = Tween(
      begin: 80.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.0, 0.25),
      ),
    );

    _animationLogoMovementUp = CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.35, 0.43),
    );

    _animationController.forward();
  }

  void _setupSecondAnimations() {
    _animationControllerSignUp = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );
    _animationLogoOut = CurvedAnimation(
      parent: _animationControllerSignUp,
      curve: Interval(0.0, 0.20),
    );
  }

  @override
  void initState() {
    _setupFirstAnimations();
    _setupSecondAnimations();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animationControllerSignUp.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var ancho = MediaQuery.of(context).size.width;

    final app = context.watch<MyAppProvider>();
    app.loadData();
    Future.delayed(const Duration(milliseconds: 6000), () async {
      print("voy a verificar");
      app.dirigirRuta("/Login");
    });

    return body(ancho);
  }

  Widget body(anchoPantalla) {
    return AnimatedBuilder(
        animation: Listenable.merge(
            [_animationController, _animationControllerSignUp]),
        builder: (context, _) {
          return Scaffold(
            backgroundColor: AppColors.primary,
            body: Material(
              type: MaterialType.transparency,
              child: Container(
                child: Stack(
                  children: [
                    Positioned(
                      top: MediaQuery.of(context).size.height / division,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          Transform.translate(
                            offset: Offset(0.0, 60 * _animationLogoOut.value),
                            child: Opacity(
                              opacity: (1 - _animationLogoOut.value),
                              child: Opacity(
                                  opacity: _animationLogoMovementUp.value,
                                  child: _footer(anchoPantalla)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height / 3 -
                          posicion * _animationLogoMovementUp.value,
                      left: 0,
                      right: 0,
                      child: Transform.scale(
                        scale: _animationLogoIn.value,
                        child: Hero(
                          tag: "logoSplash",
                          child: Container(
                            height: tamanioLogo,
                            width: tamanioLogo,
                            child: Image.asset(
                              'assets/logo.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget _footer(anchoPantalla) {
    return Column(
      children: [
        Text(
          'Gym Belgica',
          textAlign: TextAlign.center,
          style: GoogleFonts.aBeeZee(
            color: AppColors.tituloGris,
            fontSize: 40,
            decoration: TextDecoration.none,
          ),
        ),
      ],
    );
  }
}
