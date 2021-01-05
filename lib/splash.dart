import 'package:act0ne/begin.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'signin.dart';

class Splash extends StatefulWidget {
  Splash({Key key, this.login}) : super(key: key);

  final bool login;

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      gradientBackground: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [Colors.deepOrange[900], Colors.deepOrange[100]],
      ),

      seconds: 3,
      image: Image.asset("assets/images/egelogouc.png"),
      // Do not forget the declare the image into the pubspec.yaml
      loaderColor: Colors.black,
      photoSize: 125.0,
      navigateAfterSeconds: widget.login ? Begin() : SignIn(),
    );
  }
}
